#BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
#BIBlue='\033[1;94m'       # Blue
#BIPurple='\033[1;95m'     # Purple
#BICyan='\033[1;96m'       # Cyan
BICyan='\033[1;97m'      # White
Uwhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'

# // Exporting Language to UTF-8

export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'


# // Export Color & Information
export m="\033[0;1;31m"
export y="\033[0;1;34m"
export yy="\033[0;1;36m"
export yl="\033[0;1;37m"
export wh="\033[0;1;33m"
export xz="\033[0;1;35m"
export gr="\033[0;1;32m"

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Exporting URL Host
export Server_URL="raw.githubusercontent.com/andre-sakti/test/main"
export Server1_URL="raw.githubusercontent.com/andre-sakti/limit/main"
export Server_Port="443"
export Server_IP="underfined"
export Script_Mode="Stable"
export Auther=".bijipeler"

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
		echo -e "${EROR} Please Run This Script As Root User !"
		exit 1
fi

# // Exporting IP Address
export IP=$( curl -s https://ipinfo.io/ip/ )

# // Exporting Network Interface
export NETWORK_IFACE="$(ip route show to default | awk '{print $5}')"

# // Validate Result ( 1 )
touch /etc/${Auther}/license.key
export Your_License_Key="$( cat /etc/${Auther}/license.key | awk '{print $1}' )"
export Validated_Your_License_Key_With_Server="$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $Your_License_Key | head -n1 | cut -d ' ' -f 1 )"
if [[ "$Validated_Your_License_Key_With_Server" == "$Your_License_Key" ]]; then
    validated='true'
else
    echo -e "${EROR} License Key Not Valid"
    exit 1
fi

# // Checking VPS Status > Got Banned / No
if [[ $IP == "$( curl -s https://${Server_URL}/blacklist.txt | cut -d ' ' -f 1 | grep -w $IP | head -n1 )" ]]; then
    echo -e "${EROR} 403 Forbidden ( Your VPS Has Been Banned )"
    exit  1
fi

# // Checking VPS Status > Got Banned / No
if [[ $Your_License_Key == "$( curl -s https://${Server_URL} | cut -d ' ' -f 1 | grep -w $Your_License_Key | head -n1)" ]]; then
    echo -e "${EROR} 403 Forbidden ( Your License Has Been Limited )"
    exit  1
fi

# // Checking VPS Status > Got Banned / No
if [[ 'Standart' == "$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $Your_License_Key | head -n1 | cut -d ' ' -f 6 )" ]]; then 
    License_Mode='Standart'
elif [[ Pro == "$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $Your_License_Key | head -n1 | cut -d ' ' -f 6 )" ]]; then 
    License_Mode='Pro'
else
    echo -e "${EROR} Please Using Genuine License !"
    exit 1
fi

# // Checking Script Expired
exp=$( curl -s https://${Server1_URL}/limit.txt | grep -w $IP | cut -d ' ' -f 3 )
now=`date -d "0 days" +"%Y-%m-%d"`
expired_date=$(date -d "$exp" +%s)
now_date=$(date -d "$now" +%s)
sisa_hari=$(( ($expired_date - $now_date) / 86400 ))
if [[ $sisa_hari -lt 0 ]]; then
    echo $sisa_hari > /etc/${Auther}/license-remaining-active-days.db
    echo -e "${EROR} Your License Key Expired ( $sisa_hari Days )"
    exit 1
else
    echo $sisa_hari > /etc/${Auther}/license-remaining-active-days.db
fi

# // Clear
clear
clear && clear && clear
clear;clear;clear
cek=$(service ssh status | grep active | cut -d ' ' -f5)
if [ "$cek" = "active" ]; then
stat=-f5
else
stat=-f7
fi
ssh=$(service ssh status | grep active | cut -d ' ' $stat)
if [ "$ssh" = "active" ]; then
ressh="${green}ON${NC}"
else
ressh="${red}OFF${NC}"
fi
sshstunel=$(service stunnel4 status | grep active | cut -d ' ' $stat)
if [ "$sshstunel" = "active" ]; then
resst="${green}ON${NC}"
else
resst="${red}OFF${NC}"
fi
sshws=$(service ws-stunnel status | grep active | cut -d ' ' $stat)
if [ "$sshws" = "active" ]; then
ressshws="${green}ON${NC}"
else
ressshws="${red}OFF${NC}"
fi
ngx=$(service nginx status | grep active | cut -d ' ' $stat)
if [ "$ngx" = "active" ]; then
resngx="${green}ON${NC}"
else
resngx="${red}OFF${NC}"
fi
dbr=$(service dropbear status | grep active | cut -d ' ' $stat)
if [ "$dbr" = "active" ]; then
resdbr="${green}ON${NC}"
else
resdbr="${red}OFF${NC}"
fi
v2r=$(service xray status | grep active | cut -d ' ' $stat)
if [ "$v2r" = "active" ]; then
resv2r="${green}ON${NC}"
else
resv2r="${red}OFF${NC}"
fi
function addhost(){
clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -rp "Domain/Host: " -e host
echo ""
if [ -z $host ]; then
echo "????"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
setting-menu
else
echo "IP=$host" > /var/lib/scrz-prem/ipvps.conf
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "Dont forget to renew cert"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
}
function x-bw(){
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
clear
_APISERVER=127.0.0.1:10085
_XRAY=/usr/local/bin/xray

apidata () {
    local ARGS=
    if [[ $1 == "pattern" ]]; then
      ARGS="-pattern=true"
    fi
    $_XRAY api statsquery --server=$_APISERVER "${ARGS}" \
    | awk '{
        if (match($1, /"name":/)) {
            f=1; gsub(/^"|link"|,$/, "", $2);
            split($2, p,  ">>>");
            printf "%s:%s->%s\t", p[1],p[2],p[4];
        }
        else if (match($1, /"value":/) && f){
          f = 0;
          gsub(/"/, "", $2);
          printf "%.0f\n", $2;
        }
        else if (match($0, /}/) && f) { f = 0; print 0; }
    }'
}

print_sum() {
    local DATA="$1"
    local PREFIX="$2"
    local SORTED=$(echo "$DATA" | grep "^${PREFIX}" | sort -r)
    local SUM=$(echo "$SORTED" | awk '
        /->up/{us+=$2}
        /->down/{ds+=$2}
        END{
            printf "SUM->up:\t%.0f\nSUM->down:\t%.0f\nSUM->TOTAL:\t%.0f\n", us, ds, us+ds;
        }')
    echo -e "${SORTED}\n${SUM}" \
    | numfmt --field=2 --suffix=B --to=iec \
    | column -t
}

DATA=$(apidata $1)
echo "================ INBOUND ================" | lolcat
print_sum "$DATA" "inbound"
echo "=========================================" | lolcat
echo "================ OUTBOUND ===============" | lolcat
print_sum "$DATA" "outbound"
echo "=========================================" | lolcat
echo
echo "================= USER ==================" | lolcat
print_sum "$DATA" "user"
echo "=========================================" | lolcat
read -n 1 -s -r -p "Press any key to back on menu"
xmenu
}
function auto-reboot(){
echo -e "\e[32mloading...\e[0m"
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com);
echo "Checking VPS"
clear
# PROVIDED
creditt=$(cat /root/provided)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR ON TOP
text=$(cat /etc/text)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
clear
if [ ! -e /usr/local/bin/reboot ]; then
echo '#!/bin/bash' > /usr/local/bin/reboot 
echo 'tanggal=$(date +"%m-%d-%Y")' >> /usr/local/bin/reboot 
echo 'waktu=$(date +"%T")' >> /usr/local/bin/reboot 
echo 'echo "Server successfully rebooted on the date of $tanggal hit $waktu]" >> /root/log-reboot]txt' >> /usr/local/bin/reboot 
echo '/sbin/shutdown -r now' >> /usr/local/bin/reboot 
chmod +x /usr/local/bin/reboot
fi

# Auto Reboot
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info1="Auto Reboot set every 1 hour ${Green_font_prefix}[ON]${Font_color_suffix}"
Info2="Auto Reboot set every 6 hour ${Green_font_prefix}[ON]${Font_color_suffix}"
Info3="Auto Reboot set every 12 hours ${Green_font_prefix}[ON]${Font_color_suffix}"
Info4="Auto Reboot set every 1 day ${Green_font_prefix}[ON]${Font_color_suffix}"
Info5="Auto Reboot set every 1 week ${Green_font_prefix}[ON]${Font_color_suffix}"
Info6="Auto Reboot set every 1 month ${Green_font_prefix}[ON]${Font_color_suffix}"
Info7="Auto Reboot set Every 00]00A]M ${Green_font_prefix}[ON]${Font_color_suffix}"
Info8="Auto Reboot set Every 2]00A]M ${Green_font_prefix}[ON]${Font_color_suffix}"
Info9="Auto Reboot set Every 4]00A]M ${Green_font_prefix}[ON]${Font_color_suffix}"
Error="Auto Reboot Server ${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(cat /home/autoreboot)
function every_an_hour () {
rm -f /etc/cron.d/reboot
echo "59 * * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start1" > /home/autoreboot
echo -e "======================================" | lolcat
echo -e ""
echo -e "AutoReboot : On"
echo -e "Auto-Reboot has been set every an hour"
echo -e ""
echo -e "======================================" | lolcat
echo -e "\e[0;32mDone\e[0m"
}
function every_6_hours () {
rm -f /etc/cron.d/reboot
echo "0 */6 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start2" > /home/autoreboot
echo -e "======================================" | lolcat
echo -e ""
echo -e "AutoReboot : On"
echo -e "Auto-Reboot has been successfully set every 6 hours"
echo -e ""
echo -e "======================================" | lolcat
echo -e "\e[0;32mDone\e[0m"
}
function every_12_hours () {
rm -f /etc/cron.d/reboot
echo "0 */12 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start3" > /home/autoreboot
echo -e "======================================" | lolcat
echo -e ""
echo -e "AutoReboot : On"
echo -e "Auto-Reboot has been successfully set every 12 hours"
echo -e ""
echo -e "======================================" | lolcat
echo -e "\e[0;32mDone\e[0m"
}
function set_once_a_day () {
rm -f /etc/cron.d/reboot
echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start4" > /home/autoreboot
echo -e "======================================" | lolcat
echo -e ""
echo -e "AutoReboot : On"
echo -e "Auto-Reboot has been successfully set once a day"
echo -e ""
echo -e "======================================" | lolcat
echo -e "\e[0;32mDone\e[0m"
}
function set_once_a_week () {
rm -f /etc/cron.d/reboot
echo "0 0 */7 * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start5" > /home/autoreboot
echo -e "======================================" | lolcat
echo -e ""
echo -e "AutoReboot : On"
echo -e "Auto-Reboot has been successfully set once a week"
echo -e ""
echo -e "======================================" | lolcat
echo -e "\e[0;32mDone\e[0m"
}
function once_a_month () {
rm -f /etc/cron.d/reboot
echo "0 0 * 1 * root /sbin/reboot" > /etc/cron.d/reboot
echo "start6" > /home/autoreboot
echo -e "======================================" | lolcat
echo -e ""
echo -e "AutoReboot : On"
echo -e "Auto-Reboot has been successfully set once a month"
echo -e ""
echo -e "======================================" | lolcat
echo -e "\e[0;32mDone\e[0m"
}
function set_every_00 () {
rm -f /etc/cron.d/reboot
echo "0 0 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start7" > /home/autoreboot
echo -e "======================================" | lolcat
echo -e ""
echo -e "AutoReboot : On"
echo -e "Auto-Reboot has been successfully set Every 00.00am"
echo -e ""
echo -e "======================================" | lolcat
echo -e "\e[0;32mDone\e[0m"
}
function set_every_02 () {
rm -f /etc/cron.d/reboot
echo "0 2 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start8" > /home/autoreboot
echo -e "======================================" | lolcat
echo -e ""
echo -e "AutoReboot : On"
echo -e "Auto-Reboot has been successfully set Every 02.00am"
echo -e ""
echo -e "======================================" | lolcat
echo -e "\e[0;32mDone\e[0m"
}
function set_every_04 () {
rm -f /etc/cron.d/reboot
echo "0 4 * * * root /sbin/reboot" > /etc/cron.d/reboot
echo "start9" > /home/autoreboot
echo -e "======================================" | lolcat
echo -e ""
echo -e "AutoReboot : On"
echo -e "Auto-Reboot has been successfully set Every 04.00am"
echo -e ""
echo -e "======================================" | lolcat
echo -e "\e[0;32mDone\e[0m"
}
function stop () {
rm -f /etc/cron.d/reboot
sleep 0]5
echo > /home/autoreboot
echo -e "======================================" | lolcat
echo -e ""
echo -e "Auto-Reboot has been successfully Turn Off"
echo -e ""
echo -e "======================================" | lolcat
echo -e "\e[0;32mDone\e[0m"
}
function deleted () {
echo "" > /root/log-reboot]txt
echo -e "======================================" | lolcat
echo -e ""
echo "Auto Reboot Log successfully deleted!"
echo -e ""
echo -e "======================================" | lolcat
}

#Status Auto Reboot
if [[ "$cek" = "start1" ]]; then
sts="${Info1}"
elif [[ "$cek" = "start2" ]]; then
sts="${Info2}"
elif [[ "$cek" = "start3" ]]; then
sts="${Info3}"
elif [[ "$cek" = "start4" ]]; then
sts="${Info4}"
elif [[ "$cek" = "start5" ]]; then
sts="${Info5}"
elif [[ "$cek" = "start6" ]]; then
sts="${Info6}"
elif [[ "$cek" = "start7" ]]; then
sts="${Info7}"
elif [[ "$cek" = "start8" ]]; then
sts="${Info8}"
elif [[ "$cek" = "start9" ]]; then
sts="${Info9}"
else
sts="${Error}"
fi
clear

# Echo Shell
echo -e "=================================================" | lolcat
echo -e "                   AUTO REBOOT" | lolcat
echo -e "=================================================" | lolcat
echo -e "\e[${text} STATUS :\e[0m  $sts"
echo -e ""
echo -e " \e[${number}  1) $NC \e[${below} Set Auto-Reboot Every 1 Hour"$NC
echo -e " \e[${number}  2) $NC \e[${below} Set Auto-Reboot Every 6 Hours"$NC
echo -e " \e[${number}  3) $NC \e[${below} Set Auto-Reboot Every 12 Hours"$NC
echo -e " \e[${number}  4) $NC \e[${below} Set Auto-Reboot Once 1 Day"$NC
echo -e " \e[${number}  5) $NC \e[${below} Set Auto-Reboot Once 1 Week"$NC
echo -e " \e[${number}  6) $NC \e[${below} Set Auto-Reboot Once 1 Month"$NC
echo -e " \e[${number}  7) $NC \e[${below} Set Auto-Reboot Every 00.00 AM"$NC
echo -e " \e[${number}  8) $NC \e[${below} Set Auto-Reboot Every 2.00 AM"$NC
echo -e " \e[${number}  9) $NC \e[${below} Set Auto-Reboot Every 4.00 AM"$NC
echo -e " \e[${number} 10) $NC \e[${below} Turn off Auto-Reboot Server"$NC
echo -e " \e[${number} 11) $NC \e[${below} View reboot log"$NC
echo -e " \e[${number} 12) $NC \e[${below} Remove reboot log"$NC
echo -e " \e[${number} 13) $NC \e[${below} Back to menu"$NC
echo -e "=================================================" | lolcat
echo -e ""
echo -e "\e[${below}Press CTRL+C to Return/Exit"
read -rp "Please Enter The Correct Number : " -e num
if [[ "$num" = "1" ]]; then
every_an_hour
elif [[ "$num" = "2" ]]; then
every_6_hours
elif [[ "$num" = "3" ]]; then
every_12_hours
elif [[ "$num" = "4" ]]; then
set_once_a_day
elif [[ "$num" = "5" ]]; then
set_once_a_week
elif [[ "$num" = "6" ]]; then
once_a_month
elif [[ "$num" = "7" ]]; then
set_every_00
elif [[ "$num" = "8" ]]; then
set_every_02
elif [[ "$num" = "9" ]]; then
set_every_04
elif [[ "$num" = "10" ]]; then
xmenu
elif [[ "$num" = "16" ]]; then
stop
elif [[ "$num" = "11" ]]; then
if [ ! -e /root/log-reboot]txt ]; then
	echo "No reboot activity found"
	else 
	echo -e "\e[1;36mLOG REBOOT\e[0m"
	echo -e "\e[1;33m----------\e[0m"
	cat /root/log-reboot]txt
fi
elif [[ "$num" = "12" ]]; then
echo "" > /root/log-reboot]txt
echo -e "${GREEN}Auto Reboot Log successfully deleted!${NC}"
else
clear
echo -e "\e[1;31mYou Entered The Wrong Number, Please Try Again!\e[0m"
fi
}
function check-service(){
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
yl='\e[32;1m'
bl='\e[36;1m'
gl='\e[32;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
bd='\e[1m'
color1='\e[031;1m'
color2='\e[34;1m'
color3='\e[0m'
# Getting
# IP Validation
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

MYIP=$(curl -sS ipinfo.io/ip)

red='\e[1;31m'
green='\e[1;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
PERMISSION
clear

# GETTING OS INFORMATION
source /etc/os-release
Versi_OS=$VERSION
ver=$VERSION_ID
Tipe=$NAME
URL_SUPPORT=$HOME_URL
basedong=$ID

# VPS ISP INFORMATION
#ITAM='\033[0;30m'
echo -e "$ITAM"
REGION=$( curl -s ipinfo.io/region )
#clear
#COUNTRY=$( curl -s ipinfo.io/country )
#clear
#WAKTU=$( curl -s ipinfo.ip/timezone )
#clear
CITY=$( curl -s ipinfo.io/city )
#clear
#REGION=$( curl -s ipinfo.io/region )
#clear

# CHEK STATUS 
#openvpn_service="$(systemctl show openvpn.service --no-page)"
#oovpn=$(echo "${openvpn_service}" | grep 'ActiveState=' | cut -f2 -d=)
#status_openvp=$(/etc/init.d/openvpn status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#status_ss_tls="$(systemctl show shadowsocks-libev-server@tls.service --no-page)"
#ss_tls=$(echo "${status_ss_tls}" | grep 'ActiveState=' | cut -f2 -d=)
#sst_status=$(systemctl status shadowsocks-libev-server@tls | grep Active | awk '{print $0}' | cut -d "(" -f2 | cut -d ")" -f1) 
#ssh_status=$(systemctl status shadowsocks-libev-server@http | grep Active | awk '{print $0}' | cut -d "(" -f2 | cut -d ")" -f1) 
#status_ss_http="$(systemctl show shadowsocks-libev-server@http.service --no-page)"
#ss_http=$(echo "${status_ss_http}" | grep 'ActiveState=' | cut -f2 -d=)
#sssohtt=$(systemctl status shadowsocks-libev-server@*-http | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#status="$(systemctl show shadowsocks-libev.service --no-page)"
#status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)
tls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
nontls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vless_tls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vless_nontls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ss_tls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ss_nontls_v2ray_status=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ssr_status=$(systemctl status ssrmu | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
trojan_server=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#trojangfw_server=$(systemctl status trojan | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
dropbear_status=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
stunnel_service=$(/etc/init.d/stunnel5 status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#sstp_service=$(systemctl status accel-ppp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#squid_service=$(/etc/init.d/squid status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
vnstat_service=$(/etc/init.d/vnstat status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
cron_service=$(/etc/init.d/cron status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
fail2ban_service=$(/etc/init.d/fail2ban status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wg="$(systemctl show wg-quick@wg0.service --no-page)"
#swg=$(echo "${wg}" | grep 'ActiveState=' | cut -f2 -d=)
trgo="$(systemctl show trojan-go.service --no-page)"                                      
strgo=$(echo "${trgo}" | grep 'ActiveState=' | cut -f2 -d=)  
#sswg=$(systemctl status wg-quick@wg0 | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
wstls=$(systemctl status ws-stunnel.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wsdrop=$(systemctl status ws-dropbear.service | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wsovpn=$(systemctl status ws-ovpn | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#wsopen=$(systemctl status ws-openssh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#osslh=$(systemctl status sslh | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ohp=$(systemctl status dropbear-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ohq=$(systemctl status openvpn-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
#ohr=$(systemctl status ssh-ohp | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

# COLOR VALIDATION
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
clear

# STATUS SERVICE OPENVPN
if [[ $oovpn == "active" ]]; then
  status_openvpn=" ${GREEN}Running ${NC}( No Error )"
else
  status_openvpn="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  SSH 
if [[ $ssh_service == "running" ]]; then 
   status_ssh=" ${GREEN}Running ${NC}( No Error )"
else
   status_ssh="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  SQUID 
if [[ $squid_service == "running" ]]; then 
   status_squid=" ${GREEN}Running ${NC}( No Error )"
else
   status_squid="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  VNSTAT 
if [[ $vnstat_service == "running" ]]; then 
   status_vnstat=" ${GREEN}Running ${NC}( No Error )"
else
   status_vnstat="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  CRONS 
if [[ $cron_service == "running" ]]; then 
   status_cron=" ${GREEN}Running ${NC}( No Error )"
else
   status_cron="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  FAIL2BAN 
if [[ $fail2ban_service == "running" ]]; then 
   status_fail2ban=" ${GREEN}Running ${NC}( No Error )"
else
   status_fail2ban="${RED}  Not Running ${NC}  ( Error )"
fi

# STATUS SERVICE  TLS 
if [[ $tls_v2ray_status == "running" ]]; then 
   status_tls_v2ray=" ${GREEN}Running${NC} ( No Error )"
else
   status_tls_v2ray="${RED}  Not Running${NC}   ( Error )"
fi

# STATUS SERVICE NON TLS V2RAY
if [[ $nontls_v2ray_status == "running" ]]; then 
   status_nontls_v2ray=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   status_nontls_v2ray="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE VLESS HTTPS
if [[ $vless_tls_v2ray_status == "running" ]]; then
  status_tls_vless=" ${GREEN}Running${NC} ( No Error )"
else
  status_tls_vless="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE VLESS HTTP
if [[ $vless_nontls_v2ray_status == "running" ]]; then
  status_nontls_vless=" ${GREEN}Running${NC} ( No Error )"
else
  status_nontls_vless="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS SERVICE SS HTTPS
if [[ $ss_tls_v2ray_status == "running" ]]; then
  status_tls_ss=" ${GREEN}Running${NC} ( No Error )"
else
  status_tls_ss="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS SERVICE SS HTTP
if [[ $ss_nontls_v2ray_status == "running" ]]; then
  status_nontls_ss=" ${GREEN}Running${NC} ( No Error )"
else
  status_nontls_ss="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS SERVICE TROJAN
if [[ $trojan_server == "running" ]]; then 
   status_virus_trojan=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   status_virus_trojan="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# Status Service Trojan GO
if [[ $strgo == "active" ]]; then
  status_trgo=" ${GREEN}Running ${NC}( No Error )${NC}"
else
  status_trgo="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS SERVICE TROJAN GFW
if [[ $trojangfw_server == "running" ]]; then 
   status_virus_trojangfw=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   status_virus_trojangfw="${RED}  Not Running ${NC}  ( Error )${NC}"
fi
# STATUS SERVICE DROPBEAR
if [[ $dropbear_status == "running" ]]; then 
   status_beruangjatuh=" ${GREEN}Running${NC} ( No Error )${NC}"
else
   status_beruangjatuh="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE STUNNEL
if [[ $stunnel_service == "running" ]]; then 
   status_stunnel=" ${GREEN}Running ${NC}( No Error )"
else
   status_stunnel="${RED}  Not Running ${NC}  ( Error )}"
fi
# STATUS SERVICE WEBSOCKET TLS
if [[ $wstls == "running" ]]; then 
   swstls=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   swstls="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# STATUS SERVICE WEBSOCKET DROPBEAR
if [[ $wsdrop == "running" ]]; then 
   swsdrop=" ${GREEN}Running ${NC}( No Error )${NC}"
else
   swsdrop="${RED}  Not Running ${NC}  ( Error )${NC}"
fi

# TOTAL RAM
total_ram=` grep "MemTotal: " /proc/meminfo | awk '{ print $2}'`
totalram=$(($total_ram/1024))

# TIPE PROCESSOR
#totalcore="$(grep -c "^processor" /proc/cpuinfo)" 
#totalcore+=" Core"
#corediilik="$(grep -c "^processor" /proc/cpuinfo)" 
#tipeprosesor="$(awk -F ': | @' '/model name|Processor|^cpu model|chip type|^cpu type/ {
  #                      printf $2;
      #                  exit
    #                    }' /proc/cpuinfo)"

# GETTING CPU INFORMATION
#cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
#cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
#cpu_usage+=" %"

# OS UPTIME
#uptime="$(uptime -p | cut -d " " -f 2-10)"

# KERNEL TERBARU
kernelku=$(uname -r)

# WAKTU SEKARANG 
#harini=`date -d "0 days" +"%d-%m-%Y"`
#jam=`date -d "0 days" +"%X"`

# DNS PATCH
#tipeos2=$(uname -m)
#Name=$(curl -sS https://raw.githubusercontent.com/Fahmiiiiiiii/anjim/main/anjay/allow | grep $MYIP | awk '{print $2}')
#Exp=$(curl -sS https://raw.githubusercontent.com/Fahmiiiiiiii/anjim/main/anjay/allow | grep $MYIP | awk '{print $3}')
# GETTING DOMAIN NAME
Domen="$(cat /etc/xray/domain)"
echo -e ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m              ⇱ Sytem Information ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "❇️ Hostname    : $HOSTNAME"
echo -e "❇️ OS Name     : $Tipe"
# echo -e "Processor   : $tipeprosesor"
# echo -e "Proc Core   :$totalcore"
# echo -e "Virtual     :$typevps"
# echo -e "Cpu Usage   :$cpu_usage"
echo -e "❇️ Total RAM   : ${totalram}MB"
echo -e "❇️ Public IP   : $MYIP"
echo -e "❇️ Domain      : $Domen"
#echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
#echo -e "\E[44;1;39m          ⇱ Subscription Information ⇲          \E[0m"
#echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
#echo -e "❇️ Client Name : $Name"
#echo -e "❇️ Exp Script  : $Exp"
#echo -e "❇️ Version     : Latest Version"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m            ⇱ Service Information ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "❇️ SSH / TUN                  :$status_ssh"
#echo -e "❇️ OpenVPN                   :$status_openvpn"
echo -e "❇️ Dropbear                   :$status_beruangjatuh"
#echo -e "❇️ Stunnel5                   :$status_stunnel"
#echo -e "❇️ Squid                     :$status_squid"
echo -e "❇️ Fail2Ban                   :$status_fail2ban"
echo -e "❇️ Crons                      :$status_cron"
echo -e "❇️ Vnstat                     :$status_vnstat"
echo -e "❇️ XRAYS Vmess TLS            :$status_tls_v2ray"
echo -e "❇️ XRAYS Vmess None TLS       :$status_nontls_v2ray"
echo -e "❇️ XRAYS Vless TLS            :$status_tls_vless"
echo -e "❇️ XRAYS Vless None TLS       :$status_nontls_vless"
echo -e "❇️ XRAYS Shadowsocks TLS      :$status_tls_ss"
echo -e "❇️ XRAYS Shadowsocks None TLS :$status_nontls_ss"
echo -e "❇️ XRAYS Trojan               :$status_virus_trojan"
echo -e "❇️ Trojan GO                  :$status_virus_trojan"
#echo -e "❇️ Trojan GFW                :$status_virus_trojangfw"
echo -e "❇️ Websocket TLS              :$swstls"
echo -e "❇️ Websocket None TLS         :$swstls"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo ""
read -n 1 -s -r -p "Press any key to back on menu"

xmenu
}
function cek-bandwidth(){
clear
echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                   BANDWIDTH MONITOR                           \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${wh}"
echo -e "     1 ⸩   Lihat Total Bandwith Tersisa"

echo -e "     2 ⸩   Tabel Penggunaan Setiap 5 Menit"

echo -e "     3 ⸩   Tabel Penggunaan Setiap Jam"

echo -e "     4 ⸩   Tabel Penggunaan Setiap Hari"

echo -e "     5 ⸩   Tabel Penggunaan Setiap Bulan"

echo -e "     6 ⸩   Tabel Penggunaan Setiap Tahun"

echo -e "     7 ⸩   Tabel Penggunaan Tertinggi"

echo -e "     8 ⸩   Statistik Penggunaan Setiap Jam"

echo -e "     9 ⸩   Lihat Penggunaan Aktif Saat Ini"

echo -e "    10 ⸩   Lihat Trafik Penggunaan Aktif Saat Ini [5s]"

echo -e "    11 ⸩   Menu"
echo -e "${off}"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "${wh}"
read -p "     [#]  Masukkan Nomor :  " noo
echo -e "${off}"

case $noo in
1)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m              TOTAL BANDWIDTH SERVER TERSISA                   \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

2)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m              PENGGUNAAN BANDWIDTH SETIAP 5 MENIT              \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -5

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

3)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                PENGGUNAAN BANDWIDTH SETIAP JAM                \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -h

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

4)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                PENGGUNAAN BANDWIDTH SETIAP HARI               \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -d

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

5)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                PENGGUNAAN BANDWIDTH SETIAP BULAN              \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -m

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

6)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                PENGGUNAAN BANDWIDTH SETIAP TAHUN              \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -y

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

7)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                 PENGGUNAAN BANDWIDTH TERTINGGI                \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -t

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

8)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m              GRAFIK BANDWIDTH TERPAKAI SETIAP JAM             \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -hg

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

9)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m               LIVE PENGGUNAAN BANDWIDTH SAAT INI              \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${GREEN}CTRL+C Untuk Berhenti!${off}"
echo -e ""

vnstat -l

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

10)
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                LIVE TRAFIK PENGGUNAAN BANDWIDTH              \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""

vnstat -tr

echo -e ""
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "$baris2 $yy|"
echo -e "Script Mod By Andre Sakti"
;;

11)
sleep 1
xmenu
;;

*)
sleep 1
echo -e "${m}Nomor Yang Anda Masukkan Salah!${yy}"
;;
esac
read -n 1 -s -r -p "Press any key to back on menu"

xmenu
}
function limitspeed(){
clear
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(cat /home/limit)
NIC=$(ip -o $ANU -4 route show to default | awk '{print $5}');
function start () {
echo -e "Limit Speed All Service"
read -p "Set maximum download rate (in Kbps): " down
read -p "Set maximum upload rate (in Kbps): " up
if [[ -z "$down" ]] && [[ -z "$up" ]]; then
echo > /dev/null 2>&1
else
echo "Start Configuration"
sleep 0.5
wondershaper -a $NIC -d $down -u $up > /dev/null 2>&1
systemctl enable --now wondershaper.service
echo "start" > /home/limit
echo "Done"
fi
}
function stop () {
wondershaper -ca $NIC
systemctl stop wondershaper.service
echo "Stop Configuration"
sleep 0.5
echo > /home/limit
echo "Done"
}
if [[ "$cek" = "start" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
clear
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e "\E[0;41;37m                Limit Bandwidth Speed                           \E[0m"
echo -e "\e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " Status $sts"
echo -e "  1. Start Limit"
echo -e "  2. Stop Limit"
echo -e " Press CTRL+C to return"
read -rp " Please Enter The Correct Number : " -e num
if [[ "$num" = "1" ]]; then
start
elif [[ "$num" = "2" ]]; then
stop
else
clear
echo " You Entered The Wrong Number"
read -n 1 -s -r -p "Press any key to back on menu"
xmenu
fi
}
function genssl(){
clear
systemctl stop nginx
domain=$(cat /var/lib/scrz-prem/ipvps.conf | cut -d'=' -f2)
Cek=$(lsof -i:80 | cut -d' ' -f1 | awk 'NR==2 {print $1}')
if [[ ! -z "$Cek" ]]; then
sleep 1
echo -e "[ ${red}WARNING${NC} ] Detected port 80 used by $Cek " 
systemctl stop $Cek
sleep 2
echo -e "[ ${green}INFO${NC} ] Processing to stop $Cek " 
sleep 1
fi
echo -e "[ ${green}INFO${NC} ] Starting renew cert... " 
sleep 2
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d $domain --standalone -k ec-256
~/.acme.sh/acme.sh --installcert -d $domain --fullchainpath /etc/xray/xray.crt --keypath /etc/xray/xray.key --ecc
echo -e "[ ${green}INFO${NC} ] Renew cert done... " 
sleep 2
echo -e "[ ${green}INFO${NC} ] Starting service $Cek " 
sleep 2
echo $domain > /etc/xray/domain
systemctl restart xray
systemctl restart nginx
echo -e "[ ${green}INFO${NC} ] All finished... " 
sleep 0.5
echo ""
read -n 1 -s -r -p "Press any key to back on menu"
xmenu
}
function xmenu(){
#is_root
#pkg install ncurses-utils
ip=$(wget -qO- ipinfo.io/ip)
#domainhost=$(cat /root/domain)
# GETTING DOMAIN NAME
Domen=$(cat /etc/xray/domain)
region=$(wget -qO- ipinfo.io/region)
isp=$(wget -qO- ipinfo.io/org)
timezone=$(wget -qO- ipinfo.io/timezone)
ossys=$(neofetch | grep "OS" | cut -d: -f2 | sed 's/ //g')
host=$(neofetch | grep "Host" | cut -d: -f2 | sed 's/ //g')
kernel=$(neofetch | grep "Kernel" | cut -d: -f2 | sed 's/ //g')
uptime=$(neofetch | grep "Uptime" | cut -d: -f2 | sed 's/ //g')
cpu=$(neofetch | grep "CPU" | cut -d: -f2 | sed 's/ //g')
memory=$(neofetch | grep "Memory" | cut -d: -f2 | sed 's/ //g')
#echo -e "Getting Information..."
export sem=$( curl -s https://raw.githubusercontent.com/andre-sakti/test/main/versions)
export pak=$( cat /home/.ver)
IPVPS=$(curl -s ipinfo.io/ip )
ISPVPS=$( curl -s ipinfo.io/org )
export Server_URL="raw.githubusercontent.com/andre-sakti/test/main"
License_Key=$(cat /etc/${Auther}/license.key)
export Nama_Issued_License=$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $License_Key | cut -d ' ' -f 7-100 | tr -d '\r' | tr -d '\r\n')
clear
echo -e " \e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e " \E[0;41;37m                     SYSTEM INFORMATION                        \E[0m"
echo -e " \E[0;41;37m                   SCRIPT BY ANDRE SAKTI                       \E[0m"
echo -e " \e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"   
echo -e " $yy IP Address  :$xz $ip $xz"
#echo -e " $yy Domain     :$yl $domainhost $yl"
echo -e " $yy Domain      :$yl $Domen $yl"
echo -e " $yy City        :$yl $region $yl"
echo -e " $yy ISP         :$yl $isp $yl"
#echo -e " $yy Host       :$yl $host $yl"
#echo -e " $yy CPU        :$yl $cpu $yl"
#echo -e " $yy Kernel     :$yl $kernel $yl"
echo -e " $yy OS System   :$yl $ossys $yl"
#echo -e " $yy Time Zone  :$yl $timezone $yl"
echo -e " $yy RAM         :$yl $memory $yl"
echo -e " $yy Up Time     :$yl $uptime $yl"
echo -e " $yy Date        :$yl $(date +%A) $(date +%m-%d-%Y)"
echo -e " $yy My Telegram :$xz https://t.me/AndreSakti_Store $xz"
echo -e " \e[36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"     
echo -e " ${On_IRed}         ${BICyan} SSH${On_IRed}: $ressh${On_IRed}"  "${BICyan} NGINX${On_IRed}: $resngx""${On_IRed} ${BICyan}  XRAY${NC}${On_IRed}: $resv2r""${On_IRed} ${BICyan} TROJAN${NC}${On_IRed}: $resv2r${On_IRed}           ${NC}"
echo -e " ${On_IRed}       ${BICyan}${On_IRed}      ${BICyan}STUNNEL${NC}${On_IRed}: $resst${On_IRed}${BICyan} DROPBEAR${NC}${On_IRed}: $resdbr${On_IRed}${BICyan} SSH-WS${NC}${On_IRed}: $ressshws${On_IRed}              ${NC}"
echo -e "${yl}┌──────────────────────────────────────────────────────────────┐${yl}"
#echo -e "${yl}│                                                              ${yl}│${yl}"
echo -e "${yl}│  $yy 1$wh. SSH $wh          $yy[${wh}Menu$yy]     9$wh.  BANDWIDTH$wh         $yy[${wh}Menu$yy]   ${yl}│${yl}"
echo -e "${yl}│  $yy 2$wh. VMESS $wh        $yy[${wh}Menu$yy]     10$wh. BANDWIDTH USER$wh    $yy[${wh}Menu$yy]   ${yl}│${yl}"  
echo -e "${yl}│  $yy 3$wh. VLESS $wh        $yy[${wh}Menu$yy]     11$wh. ADD-HOST$wh          $yy[${wh}Menu$yy]   ${yl}│${yl}" 
echo -e "${yl}│  $yy 4$wh. TROJAN $wh       $yy[${wh}Menu$yy]     12$wh. GEN SSL$wh           $yy[${wh}Menu$yy]   ${yl}│${yl}" 
echo -e "${yl}│  $yy 5$wh. SS WS $wh        $yy[${wh}Menu$yy]     13$wh. CHECK ALL SERVICE$wh $yy[${wh}Menu$yy]   ${yl}│${yl}" 
echo -e "${yl}│  $yy 6$wh. SOCK WS $wh      $yy[${wh}Menu$yy]     14$wh. RESTART SERVICE$wh   $yy[${wh}Menu$yy]   ${yl}│${yl}" 
echo -e "${yl}│  $yy 7$wh. LIMIT SPEED$wh   $yy[${wh}Menu$yy]     15$wh. AUTO REBOOT$wh       $yy[${wh}Menu$yy]   ${yl}│${yl}"
echo -e "${yl}│  $yy 8$wh. BACKUP $wh       $yy[${wh}Menu$yy]     16$wh. BACK$wh              $yy[${wh}Menu$yy]   ${yl}│${yl}" 
#echo -e "${yl}│                                                              ${yl}│${yl}"
echo -e "${yl}└──────────────────────────────────────────────────────────────┘${yl}"
echo -e "${yl}┌──────────────────────────────────────────────────────────────┐${NC}"
echo -e "${yl}   Version       :\033[1;36m Latest Version\e[0m"
#echo -e "${yl}   Version       :\033[1;36m 1.0\e[0m"
echo -e "${yl}   User          :\033[1;36m $Nama_Issued_License \e[0m"
echo -e "${yl}   Expiry script $yl: ${BIYellow}$(cat /etc/${Auther}/license-remaining-active-days.db)${NC} Days" | lolcat
echo -e "${yl}└──────────────────────────────────────────────────────────────┘${NC}"
echo
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; menu-ssh ;;
2) clear ; menu-vmess ;;
3) clear ; menu-vless ;;
4) clear ; menu-trojan ;;
5) clear ; menu-ss ;;
6) clear ; menu-socks ;;
7) clear ; limitspeed ;;
8) clear ; menu-bckp ;;
9) clear ; cek-bandwidth ;;
#007) clear ; wget https://raw.githubusercontent.com/andre-sakti/ranjau-darate/main/cek-bandwidth.sh && chmod +x cek-bandwidth.sh && ./cek-bandwidth.sh && rm -f /root/cek-bandwidth.sh ;;
#008) clear ; wget https://raw.githubusercontent.com/andre-sakti/ranjau-darate/main/limitspeed.sh && chmod +x limitspeed.sh && ./limitspeed.sh && rm -f /root/limitspeed.sh ;;
10) clear ; x-bw ;;
11) clear ; addhost ;;
12) clear ; genssl ;;
13) clear ; check-service ;;
15) clear ; auto-reboot ;;
14) clear ; systemctl restart xray; systemctl restart ws-stunnel; systemctl restart nginx; systemctl restart fail2ban; systemctl restart dropbear; systemctl restart ssh; systemctl restart stunnel4;
    clear; echo -e "${OKEY} Successfull Restarted All Service";
    ;;
16)
sleep 1
menu

;;
esac
read -n 1 -s -r -p "Press any key to back on menu"

menu
}
export sem=$( curl -s https://raw.githubusercontent.com/andre-sakti/test/main/versions)
export pak=$( cat /home/.ver)
IPVPS=$(curl -s ipinfo.io/ip )
export Server_URL="raw.githubusercontent.com/andre-sakti/test/main"
License_Key=$(cat /etc/${Auther}/license.key)
export Nama_Issued_License=$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $License_Key | cut -d ' ' -f 7-100 | tr -d '\r' | tr -d '\r\n')
#information
OK="${yy}[OK]${yl}"
Error="${m}[Mistake]${yl}"
#pkg install ncurses-utils
#echo -e "Getting Information Please Wait...."
is_root() {
    if [ 0 == $UID ]; then
        echo -e "${OK} ${yl} The current user is the root user..${yl}"
        sleep 1
        echo -e "Getting Information...."
    else
        echo -e "${Error} ${yl} Please switch to the root user and execute start-menu again ${yl}"
        exit 1
    fi
}
clear
export m="\033[0;1;31m"
export y="\033[0;1;34m"
export yy="\033[0;1;36m"
export yl="\033[0;1;37m"
export wh="\033[0;1;33m"
export xz="\033[0;1;35m"
export gr="\033[0;1;32m"
echo "1;36m" > /etc/banner
echo "30m" > /etc/box
echo "1;31m" > /etc/line
echo "1;32m" > /etc/text
echo "1;33m" > /etc/below
echo "47m" > /etc/back
echo "1;35m" > /etc/number
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
echo 3d > /usr/bin/test
GitUser="givpn"
#IZIN SCRIPT
MYIP=$(curl -sS ipv4.icanhazip.com)
clear
#Domain
Domen=$(cat /etc/xray/domain)
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10)
CITY=$(curl -s ipinfo.io/city)
WKT=$(curl -s ipinfo.io/timezone)
IPVPS=$(curl -s ipinfo.io/ip)
cpu=$(neofetch | grep "CPU" | cut -d: -f2 | sed 's/ //g')
cname=$(awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo)
cores=$(awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo)
freq=$(awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo)
tram=$(free -m | awk 'NR==2 {print $2}')
uram=$(free -m | awk 'NR==2 {print $3}')
fram=$(free -m | awk 'NR==2 {print $4}')
clear
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# USERNAME
rm -f /usr/bin/user
username=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $2}')
echo "$username" >/usr/bin/user
# Order ID
rm -f /usr/bin/ver
user=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $3}')
echo "$user" >/usr/bin/ver
# validity
rm -f /usr/bin/e
valid=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
echo "$valid" >/usr/bin/e
# DETAIL ORDER
username=$(cat /usr/bin/user)
oid=$(cat /usr/bin/ver)
exp=$(cat /usr/bin/e)
clear
version=$(cat /home/ver)
ver=$( curl https://raw.githubusercontent.com/${GitUser}/version/main/version.conf )
clear
# CEK UPDATE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info1="${Green_font_prefix}$version${Font_color_suffix}"
Info2="${Green_font_prefix} Latest Version ${Font_color_suffix}"
Error=" Version ${Green_font_prefix}[$ver]${Font_color_suffix} Available${Red_font_prefix}[Update]${Font_color_suffix}"
version=$(cat /home/ver)
new_version=$( curl https://raw.githubusercontent.com/${GitUser}/version/main/version.conf | grep $version )
#Status Version
if [ $version = $new_version ]; then
stl="${Info2}"
else
stl="${Error}"
fi
clear
# Getting CPU Information
vnstat_profile=$(vnstat | sed -n '3p' | awk '{print $1}' | grep -o '[^:]*')
vnstat -i ${vnstat_profile} >/root/t1
bulan=$(date +%b)
today=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
todayd=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $8}')
today_v=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $9}')
today_rx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $2}')
today_rxv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $3}')
today_tx=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $5}')
today_txv=$(vnstat -i ${vnstat_profile} | grep today | awk '{print $6}')
if [ "$(grep -wc ${bulan} /root/t1)" != '0' ]; then
    bulan=$(date +%b)
    month=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $9}')
    month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $10}')
    month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $3}')
    month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $4}')
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $6}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $7}')
else
    bulan=$(date +%Y-%m)
    month=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $8}')
    month_v=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $9}')
    month_rx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $2}')
    month_rxv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $3}')
    month_tx=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $5}')
    month_txv=$(vnstat -i ${vnstat_profile} | grep "$bulan " | awk '{print $6}')
fi
if [ "$(grep -wc yesterday /root/t1)" != '0' ]; then
    yesterday=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $8}')
    yesterday_v=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $9}')
    yesterday_rx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $2}')
    yesterday_rxv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $3}')
    yesterday_tx=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $5}')
    yesterday_txv=$(vnstat -i ${vnstat_profile} | grep yesterday | awk '{print $6}')
else
    yesterday=NULL
    yesterday_v=NULL
    yesterday_rx=NULL
    yesterday_rxv=NULL
    yesterday_tx=NULL
    yesterday_txv=NULL
fi
#if [ "$(grep -wc live /root/t1)" != '0' ]; then
#    live=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $8}')
#    live_v=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $9}')
#    live_rx=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $2}')
#    live_rxv=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $3}')
#    live_tx=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $5}')
#    live_txv=$(vnstat -i ${vnstat_profile} | grep live | awk '{print $6}')
#fi


# STATUS EXPIRED ACTIVE
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[4$below" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}(Registered)${Font_color_suffix}"
Error="${Green_font_prefix}${Font_color_suffix}${Red_font_prefix}[EXPIRED]${Font_color_suffix}"

today=$(date -d "0 days" +"%Y-%m-%d")
Exp1=$(curl https://raw.githubusercontent.com/${GitUser}/allow/main/ipvps.conf | grep $MYIP | awk '{print $4}')
if [[ $today < $Exp1 ]]; then
    sts="${Info}"
else
    sts="${Error}"
fi
echo -e "\e[32mloading...\e[0m"
# CERTIFICATE STATUS
d1=$(date -d "$valid" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))
# TOTAL ACC CREATE VMESS WS
vmess=$(grep -c -E "^###vms " "/etc/xray/config.json")
# TOTAL ACC CREATE  VLESS WS
vless=$(grep -c -E "^###vls " "/etc/xray/config.json")
# TOTAL ACC CREATE  VLESS TCP XTLS
ssws=$(grep -c -E "^###ssws " "/etc/xray/config.json")
# TOTAL ACC CREATE  TROJAN
trtls=$(grep -c -E "^###trx " "/etc/xray/tcp.json")
# TOTAL ACC CREATE  TROJAN WS TLS
trws=$(grep -c -E "^###trs " "/etc/xray/config.json")
# TOTAL ACC CREATE  SOCKWS
shockws=$(grep -c -E "^###sckws " "/etc/xray/config.json")
# TOTAL ACC CREATE OVPN SSH
total_ssh="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
# PROVIDED
creditt=$(cat /root/provided)
# BANNER COLOUR
banner_colour=$(cat /etc/banner)
# TEXT ON BOX COLOUR
box=$(cat /etc/box)
# LINE COLOUR
line=$(cat /etc/line)
# TEXT COLOUR ON TOP
text=$(cat /etc/text)
# TEXT COLOUR BELOW
below=$(cat /etc/below)
# BACKGROUND TEXT COLOUR
back_text=$(cat /etc/back)
# NUMBER COLOUR
number=$(cat /etc/number)
# BANNER
banner=$(cat /usr/bin/bannerku)
ascii=$(cat /usr/bin/test)
clear
echo -e "\e[$banner_colour"
#figlet -f $ascii "$banner"
#echo -e "\e[$text  VPS Script"
export sem=$( curl -s https://raw.githubusercontent.com/andre-sakti/test/main/versions)
export pak=$( cat /home/.ver)
IPVPS=$(curl -s ipinfo.io/ip )
ISPVPS=$( curl -s ipinfo.io/org )
export Server_URL="raw.githubusercontent.com/andre-sakti/test/main"
License_Key=$(cat /etc/${Auther}/license.key)
export Nama_Issued_License=$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $License_Key | cut -d ' ' -f 7-100 | tr -d '\r' | tr -d '\r\n')
clear
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
echo -e "  \e[$back_text                    \e[30m[\e[$box SERVER INFORMATION\e[30m ]\e[1m                  \e[m"
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "  \e[$yy CPU Model            : $cpu"
#echo -e "  \e[$yy CPU Model            :$cname \e[0m"
echo -e "  \e[$yy CPU Frequency        :$y$freq MHz $yl"
#echo -e "  \e[$yy Number Of Core       : $cores $yl"
echo -e "  \e[$yy Operating System     : "$(hostnamectl | grep "Operating System" | cut -d ' ' -f5-)
echo -e "  \e[$yy Kernel               : $(uname -r)"
echo -e "  \e[$yy Total Amount Of Ram  : $tram MB"
echo -e "  \e[$yy Used RAM             : $uram MB"
echo -e "  \e[$yy Free RAM             : $fram MB"
echo -e "  \e[$yy System Uptime        : $uptime"
echo -e "  \e[$yy Ip Vps/Address       :$xz $IPVPS $xz"
echo -e "  \e[$yy Domain Name          :$xz $Domen $xz"
echo -e "  \e[$yy Order ID             :$xz $Nama_Issued_License $xz"
#echo -e "  \e[$yy Expired Status       :$wh $(cat /etc/${Auther}/license-remaining-active-days.db)$wh Days$wh" | lolcat
echo -e "  \e[$yy Provided By          :$yl Script Credit by Andre Sakti $yl"
echo -e "  \e[$yy Status Update        :$stl"
echo -e "  $yy Expired Status       :$wh $(cat /etc/${Auther}/license-remaining-active-days.db)$wh Days$wh" | lolcat
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
echo -e " \e[$yy      Traffic        Today       Yesterday      Month   $yy"
echo -e "   \e[$text    Download${NC}     \e[${text}$today_tx $today_txv      $yesterday_tx $yesterday_txv     $month_tx $month_txv   \e[0m"
echo -e "   \e[$text    Upload${NC}       \e[${text}$today_rx $today_rxv      $yesterday_rx $yesterday_rxv     $month_rx $month_rxv   \e[0m"
echo -e "   \e[$text    Total${NC}      \e[${text}  $todayd $today_v     $yesterday $yesterday_v     $month $month_v  \e[0m "
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
#echo -e "                       \E[0;41;37m LIST ACCOUNTS \E[0m" 
echo -e "                          LIST ACCOUNTS " | lolcat
echo -e " \e[$yy    SSH      Vmess     Vless    Trojan-Ws   SS-WS    SOCK-WS$yy "  
echo -e " \e[$below     $total_ssh         $vmess         $vless         $trws          $ssws         $shockws \e[0m "
echo -e " \e[$yy  Account   Account   Account    Account   Account   Account$yy "  
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
#echo -e "  \e[   $yyExpired Status :$wh $(cat /etc/${Auther}/license-remaining-active-days.db)$wh Days$wh" | lolcat
echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "  \e[$number (111)\e[m\e[$below xmenu"  ">>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >>> >>> \e[m" | lolcat
echo -e " \e[$line╒════════════════════════════════════════════════════════════╕\e[m"
#echo -e " \e[$yy      Traffic        Download       Upload      Total   $yy"
#echo -e "   \e[$text    Live${NC}     \e[${text}$live_tx $live_txv      ${text}$live_rx $live_rxv     ${text}  $live $live_v   \e[0m"
#echo -e " \e[$line╘════════════════════════════════════════════════════════════╛\e[m"
echo -e "\e[$below "
read -p " Select xmenu :  " menu
echo -e ""
case $menu in
111) clear ; xmenu ;;
0) clear ; menu ;;
#x) exit ;;
#*) echo -e "" ; echo "Press any key to back exit" ; sleep 1 ; exit ;;
esac
