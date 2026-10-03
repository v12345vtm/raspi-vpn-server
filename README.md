# 🏡 Raspberry Pi 4 Thuis-VPN & DuckDNS (WireGuard)

Dit script installeer automatisch een **WireGuard VPN-server** via PiVPN op je Raspberry Pi 4, inclusief een automatische **DuckDNS IP-updater**. Hiermee kun je vanuit het buitenland (bijv. Spanje) veilig verbinden met je thuisnetwerk, ook als je provider thuis je IP-adres verandert.

## 🚀 Snelle Installatie

Log in op je Raspberry Pi via SSH en voer het volgende commando uit:

```bash
wget -O setup_vpn.sh [https://raw.githubusercontent.com/v12345vtm/raspi-vpn-server/main/setup_vpn.sh](https://raw.githubusercontent.com/v12345vtm/raspi-vpn-server/main/setup_vpn.sh)
chmod +x setup_vpn.sh
./setup_vpn.sh
