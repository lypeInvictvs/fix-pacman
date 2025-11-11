#!/usr/bin/env bash
# ============================================================
#  Script: fix-pacman.sh
#  Author: lypeInvictvs & CHATGPT
#  Purpose: Recover a broken pacman installation caused by
#           incompatible or other issues.
# ============================================================

set -e

# === CONFIGURATION ===
URL_BIN="https://pkgbuild.com/~morganamilo/pacman-static/x86_64/bin/pacman-static"
URL_SIG="https://pkgbuild.com/~morganamilo/pacman-static/x86_64/bin/pacman-static.sig"
KEY_ID="F850562FCDA369F80D33000AE48D0A8326DE47C5"

# === CHECK DEPENDENCIES ===
for cmd in curl gpg tar; do
  if ! command -v "$cmd" &>/dev/null; then
    echo "❌ Error: required command '$cmd' is not installed."
    exit 1
  fi
done

echo "⚙️  Downloading pacman-static..."
curl -fsS -O "$URL_BIN"
curl -fsS -O "$URL_SIG"

echo "🔍 Verifying GPG signature..."
if ! gpg --verify pacman-static.sig pacman-static &>/dev/null; then
  echo "🔑 Signature could not be verified. Attempting to import public key..."
  if gpg --keyserver keyserver.ubuntu.com --recv-keys "$KEY_ID"; then
    echo "✅ Key $KEY_ID successfully imported."
  else
    echo "❌ Failed to import GPG key. Check your network or keyserver."
    exit 1
  fi

  echo "🔁 Verifying signature again..."
  if ! gpg --verify pacman-static.sig pacman-static &>/dev/null; then
    echo "❌ Invalid signature even after importing key. Aborting."
    exit 1
  fi
else
  echo "✅ Signature is valid."
fi

# === INSTALL PACMAN-STATIC ===
chmod +x pacman-static
sudo mv pacman-static /usr/local/bin/

# === VERIFY INSTALLATION ===
if ! command -v pacman-static &>/dev/null; then
  echo "❌ Error: pacman-static was not installed correctly."
  exit 1
fi

# === DONE ===
echo
echo "🎉 pacman-static has been successfully installed and executed!"
echo "   You can now run: sudo pacman-static -Syu"
echo "   and then test your normal pacman with: pacman -V"
echo
