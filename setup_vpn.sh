#!/bin/bash

# Zorg dat het script stopt bij fouten
set -e

echo "🚀 Systeem updaten en upgraden..."
sudo apt-get update && sudo apt-get upgrade -y

echo "📦 WireGuard VPN installeren via PiVPN..."
# Download en start de PiVPN installer
curl -L https://install.pivpn.io | bash

echo "======================================================"
echo "✅ Installatie voltooid!"
echo "📱 Gebruik het commando 'pivpn add' om een nieuw apparaat toe te voegen."
echo "📷 Gebruik daarna 'pivpn qr' om een QR-code te genereren voor je telefoon."
echo "======================================================"
