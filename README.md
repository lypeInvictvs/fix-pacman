# fix-pacman
Recover a broken pacman installation caused by incompatible or other issues.

⚙️ Features <br>
✅ Automatically downloads and installs pacman-static <br>
🔑 Auto-imports missing GPG keys <br>
🔧 Repairs core packages: libxml2, icu, and pacman <br>
🧠 Safe to run on any Arch-based system <br>
🪶 Minimal dependencies: curl, tar, and gpg <br>

## Requirements
Make sure you have the following tools available:
<code>curl  gpg  tar </code>

🚀 Usage <br>
1️⃣ Clone or download the script<br>
<code> git clone https://github.com/<yourusername>/fix-pacman.git</code> <br>
<code> cd fix-pacman </code> <br>
2️⃣ Make it executable <br>
<code> chmod +x fix-pacman.sh</code> <br>
3️⃣ Run the script <br>
<code> ./fix-pacman.sh</code>

## The script will
<pre>
Download pacman-static from the official maintainer’s repository
Verify the GPG signature
Automatically import the missing GPG key if necessary
Move pacman-static to /usr/local/bin/
</pre>
