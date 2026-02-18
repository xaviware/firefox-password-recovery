# Mozilla Firefox Password Recovery

![Version](https://img.shields.io/badge/version-5.0.0-blue.svg)
![License](https://img.shields.io/badge/license-Shareware-orange.svg)
![Platform](https://img.shields.io/badge/platform-Windows-lightgrey.svg)

**Mozilla Firefox Password Recovery** is a legacy utility designed to instantly recover stored passwords from the Mozilla Firefox web browser. Developed in Visual Basic 6, it leverages internal decryption libraries and SQLite database access to provide a quick and efficient recovery process.

## 🚀 Features

- **Instant Recovery:** Recover all stored usernames and passwords with a single click.
- **Multi-version Support:** Compatible with legacy versions of Firefox (including 4.0 and 5.0).
- **Multi-language Interface:** Supports English, Spanish, Portuguese-Brazil, Bulgarian, Romanian, and more.
- **SQLite Integration:** Directly reads the browser's profile databases.
- **Anti-Debugger Protection:** Enhanced security measures in the latest version.

## 🛠️ Technical Details

- **Language:** Visual Basic 6.0 (VB6)
- **Database:** SQLite 3 (via `sqlite3.dll`)
- **Decryption:** Utilizes Mozilla's `NSS` (Network Security Services) libraries for handling encrypted credentials.
- **Architecture:** Uses a custom CDECL translation class (`cCDECL.cls`) to interface with standard C libraries from VB6.

## 📋 Installation & Usage

1. **Requirements:**
   - Windows OS.
   - `sqlite3.dll` must be present in the application directory.
   - Mozilla Firefox installed (or profile data available).

2. **Quick Start:**
   - Run the executable (`PWDMFF.exe`).
   - Click the **"Recover Passwords"** button.
   - The recovered data will be displayed instantly in the main grid.

## 📜 Licensing

This software is distributed as **Shareware**. 
- All copyrights are owned by **XaviWare Software Ltda.**
- The unregistered version may be freely distributed in its original form.
- Commercial use or reverse engineering is prohibited under the license terms.

## 📅 Version History

- **v5.0.0 (2011-08-14):** Added Anti-Debugger protection and Support for Firefox 4/5.
- **v1.0.2 (2010-03-06):** Added Romanian language support.
- **v1.0.1 (2010-02-19):** Bug fixes in registration and added Bulgarian support.
- **v1.0.0 (2010-02-14):** Initial public release.

---
Developed by **XaviWare Software**
