#!/bin/bash

# Zorg dat het script stopt bij onverwachte fouten
set -e

echo "======================================================"
echo "🚀 Raspberry Pi VPN & DuckDNS Setup"
echo "======================================================"

# 1. System Update
echo "📦 Systeem updaten en upgraden..."
sudo apt-get update && sudo apt-get upgrade -y

# 2. DuckDNS Setup (Optioneel via input)
echo ""
echo "--- DuckDNS Configuratie (Optioneel) ---"
read -p "Voer je DuckDNS domeinnaam in (bijv. dejeans, zonder .duckdns.org): " DUCK_DOMAIN
read -p "Voer je DuckDNS API Token in: " DUCK_TOKEN

if [ -n "$DUCK_DOMAIN" ] && [ -n "$DUCK_TOKEN" ]; then
    echo "⚙️ DuckDNS instellen voor domein: ${DUCK_DOMAIN}.duckdns.org..."
    
    mkdir -p ~/duckdns
    
    # Maak het duck.sh script aan
    cat << EOF > ~/duckdns/duck.sh
echo url="https://www.duckdns.org/update?domains=${DUCK_DOMAIN}&token=${DUCK_TOKEN}&ip=" | curl -k -s -K - > ~/duckdns/duck.log
EOF

    chmod 700 ~/duckdns/duck.sh

    # Voer een eerste test-run uit
    ~/duckdns/duck.sh
    DUCK_RESULT=$(cat ~/duckdns/duck.log)
    
    if [ "$DUCK_RESULT" = "OK" ]; then
        echo "✅ DuckDNS succesvol bijgewerkt (Status: OK)!"
    else
        echo "⚠️ DuckDNS melding: $DUCK_RESULT. Controleer later je token en domein."
    fi

    # Voeg toe aan crontab als het er nog niet in staat (elke 5 minuten)
    (crontab -l 2>/dev/null | grep -v "duckdns/duck.sh" ; echo "*/5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1") | crontab -
    echo "⏰ Cronjob ingesteld: DuckDNS ververst elke 5 minuten."
else
    echo "⏩ DuckDNS overgeslagen (geen domein of token ingevoerd)."
fi

# 3. PiVPN (WireGuard) Installatie
echo ""
echo "------------------------------------------------------"
echo "📦 WireGuard VPN (PiVPN) installatie starten..."
echo "------------------------------------------------------"
curl -L https://install.pivpn.io | bash

echo ""
echo "======================================================"
echo "✅ Installatie voltooid!"
echo "------------------------------------------------------"
echo "📱 Gebruik 'pivpn add' om een nieuw apparaat toe te voegen."
echo "📷 Gebruik 'pivpn -qr' om een QR-code voor je telefoon te tonen."
echo "======================================================"
