# Chrome History Decrypter

**Chrome History Decrypter** is a modular Windows toolkit developed for educational, red team, and digital forensics demonstrations.  
It enables security enthusiasts to extract and analyze Chrome browsing history from local systems. Future versions aim to integrate simple decryption or data correlation techniques for more comprehensive investigations.

---

## Features

- **History Extraction:** Retrieves Chrome browsing history from the user’s local database.
- **Wi-Fi Password Extractor:** Dumps stored Wi-Fi keys from the system for situational awareness.
- **Admin Brute Simulation:** Demonstrates brute force login attempts on local admin prompts *Main Worker Of Brute Force From Ebola Man* (safe concept only).
- **USB Collector:** Copies target files/directories from connected removable drives.
- **Windows Locker:** It put itself to the startup folder, don't allow user to login after next time user use the PC/Laptop.
- **Stealth Mode:** Hidden feature that executes multiple modules in sequence for quick assessments.

---

## Prerequisites

- Windows environment (tested on Windows 10/11).
- Batch interpreter (`cmd.exe`) — pre-installed on all Windows systems.
*Python should has to be 3.12.2 or above.*

---

## Installation

1. **Clone the repository:**
    ```bash
    git clone https://github.com/Nuknov/Chrome-History-Decrypter.git
    cd Chrome-History-Decrypter
    ```

2. **No external dependencies required.**
    - The toolkit is written in batch scripts; ensure you have appropriate administrative rights to execute certain modules.

---

## Usage

1. Navigate to the cloned directory.
2. Launch the toolkit by running:
    ```cmd
    Main.bat
    ```
3. Follow the interactive menu to choose the desired module.

---

## ⚠️ Disclaimer

> This toolkit is intended **solely for educational and authorized security testing purposes.**  
> The author does not take responsibility for misuse or any damage resulting from unauthorized deployment.  
> Always operate within your own environments or with explicit permission.
> *Kaspersky can get this now.*

---

## Author

- **Ahmed Naveed (Nuknov)**  
- https://github.com/Nuknov
- https://twitter.com/Nuknov 

---

## License

This project is licensed under the [MIT License](LICENSE).
