🏡 Raspberry Pi 4 Thuis-VPN & DuckDNS (WireGuard)

Met deze repository installeer je eenvoudig een WireGuard VPN-server via PiVPN op je Raspberry Pi 4, inclusief een automatische DuckDNS IP-updater.

Hiermee verbind je vanuit het buitenland (bijv. Spanje) veilig met je thuisnetwerk op iOS en Android, alsof je gewoon op je eigen wifi zit.

⚡ 1. Voorbereiding op de Raspberry Pi

A. Vaste netwerkkabel (LAN) gebruiken

Voor een stabiele VPN-verbinding is een LAN-kabel sterk aanbevolen. Schakel wifi uit op je Pi om conflicten te voorkomen:

sudo rfkill block wifi


B. Snelle Installatie via SSH

Log in op je Pi via SSH en voer het volgende commando uit:

wget -O setup_vpn.sh https://raw.githubusercontent.com/v12345vtm/raspi-vpn-server/main/setup_vpn.sh
chmod +x setup_vpn.sh
./setup_vpn.sh


📋 2. Stappen tijdens het uitvoeren van het script

Stap 1: DuckDNS Instellen (Optioneel)

Het script vraagt om je DuckDNS gegevens:

Domeinnaam: Vul je subdomein in (bijv. dejeans — zonder .duckdns.org).

API Token: Je unieke token van duckdns.org.

Let op: Druk gewoon op Enter om dit over te slaan als je DuckDNS (nog) niet gebruikt.

Stap 2: PiVPN Menu-instellingen

Interface: Kies eth0 (de vaste netwerkkabel).

Protocol: Kies WireGuard.

Poort: Accepteer de standaard poort 51820.

DNS Provider: Kies een openbare DNS zoals Cloudflare (1.1.1.1) of Quad9.

Public IP / DNS: Kies Public DNS en vul je DuckDNS domein in:

dejeans.duckdns.org


(Vul het domein exact zo in, dus zonder http:// of https://!)

⚙️ 3. Router Instellen (Port Forwarding & DHCP)

Port Forwarding:
Stuur in de instellingen van je thuisrouter de volgende poort door naar het IP-adres van je Raspberry Pi:

Poort: 51820

Protocol: UDP

Doel IP: IP-adres van je Raspberry Pi.

DHCP Reserve (Static Lease):
Laat de Raspberry Pi op DHCP staan. Stel op je router een Static Lease / DHCP Reservation in op basis van het MAC-adres van de Pi. Mocht je de Pi verhuizen naar een andere router/IP-range, dan krijgt hij automatisch een geldig IP zonder dat de netwerkinstellingen vastlopen.

📱 4. Apparaten Verbinden (iOS & Android)

Download de WireGuard app op je telefoon of tablet via de App Store of Google Play Store.

Maak een nieuw VPN-profiel aan via SSH op de Raspberry Pi:

pivpn add


(Voer een naam in, bijv. M_city)

Genereer de QR-code:

pivpn -qr


(Of geef het nummer van het profiel mee, bijv. pivpn -qr 1)

Open de WireGuard-app op je telefoon, tik op + -> Scan QR-code en scan de code van je scherm.

🔍 5. Handige Commando's & Testen

DuckDNS Werking Testen via SSH

Update-script handmatig testen:

~/duckdns/duck.sh && cat ~/duckdns/duck.log


(Geeft OK terug als de koppeling gelukt is)

IP-adres vergelijken:

curl -s https://ifconfig.me
nslookup dejeans.duckdns.org


(Het IP-adres uit beide uitkomsten moet exact gelijk zijn)

Actieve VPN-verbindingen & Dataverbruik inzien

Bekijk wie er momenteel verbonden is en hoeveel MB/GB er verbruikt is:

pivpn -c


(Of gebruik: sudo wg show)

🧪 6. Testen voor vertrek naar het buitenland

Zet de wifi op je telefoon uit (gebruik 4G/5G), open de WireGuard-app en zet de VPN aan. Als je nu normaal kunt browsen op internet en toegang hebt tot je lokale apparaten, werkt je VPN-server vlekkeloos!
