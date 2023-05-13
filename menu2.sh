#!/bin/bash

BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
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
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

export sem=$( curl -s https://raw.githubusercontent.com/andre-sakti/test/main/versions)
export pak=$( cat /home/.ver)
IPVPS=$(curl -s ipinfo.io/ip )
export Server_URL="raw.githubusercontent.com/andre-sakti/test/main"
License_Key=$(cat /etc/${Auther}/license.key)
export Nama_Issued_License=$( curl -s https://${Server_URL}/validated-registered-license-key.txt | grep -w $License_Key | cut -d ' ' -f 7-100 | tr -d '\r' | tr -d '\r\n')
clear
          cat /root/te
echo -e "╔════════════════════════════════════════════════════════╗"
echo -e "╟                 ${On_IRed}${UWhite}--Server Informations--${NC}"
echo -e "╟"
echo -e "╟${BIGreen} ◉${NC} IP Server  : $IPVPS"
echo -e "╟${BIGreen} ◉${NC} Domain     : $(cat /etc/xray/domain)"
echo -e "╟${BIGreen} ◉${NC} Use-Core   : XRAY-CORE"
echo -e "╚════════════════════════════════════════════════════════╝"
echo -e "        SSH :      NGINX :      XRAY :      STUNNEL  :"
echo -e "       DROPBEAR :     FAILBAN :      WS-STUNNEL : "
echo -e "╔════════════════════════════════════════════════════════╗"
echo -e "║${On_IRed}                     --SCRIPT MENU--                    ${NC}║"
echo -e "╠════════════════════════════════════════════════════════╣"
echo -e "  [01] SSH          [06] SSR         [11] CHANGE TIME"
echo -e "  [02] VMESS        [07] SOCKS5      [12] CHANGE BANNER"
echo -e "  [03] TROJAN       [08] WIREGUARD   [13] BACKUP"
echo -e "  [04] VLESS        [09] ADD-HOST    [14] RESTORE"
echo -e "  [05] SHADOWSOCKS  [10] GEN-SSL     [15] XOL-BOT"
echo -e "╚════════════════════════════════════════════════════════╝ "
echo -e " ${On_IRed}   Information License                                  ${NC} "
echo -e "╔════════════════════════════════════════════════════════╗"
echo -e "╟${BIGreen} ◉${NC} Client Name        : Bahenol69"
echo -e "╟${BIGreen} ◉${NC} Expired License    : Lifetime"
echo -e "╟${BIGreen} ◉${NC} Version Scripts    : 1.2"
echo -e "╟${BIGreen} ◉${NC} Base Scripts       : ${BIWhite}Horasssss${NC}"
echo -e "╟${BIGreen} ◉${NC} Decodec            : ${BIWhite}@boootzzzz${NC}"
echo -e "╚════════════════════════════════════════════════════════╝"
echo -e "";

read -p "Input Your Choose ( 1-10 ) : " xi

case $xi in
1) sshx
clear
		echo -e "${BICyan} ┌─────────────────────────────────────────────────────┐${NC}"
		echo -e "       ${BIWhite}${UWhite}SSH ${NC}"
		echo -e ""
		echo -e "     ${BICyan}[${BIWhite}01${BICyan}] Add Account SSH      "
		echo -e "     ${BICyan}[${BIWhite}02${BICyan}] Delete Account SSH      "
		echo -e "     ${BICyan}[${BIWhite}03${BICyan}] Renew Account SSH      "
		echo -e "     ${BICyan}[${BIWhite}04${BICyan}] Cek User SSH     "
		echo -e "     ${BICyan}[${BIWhite}05${BICyan}] Mullog SSH     "
		echo -e "     ${BICyan}[${BIWhite}06${BICyan}] Auto Del user Exp     "
		echo -e "     ${BICyan}[${BIWhite}07${BICyan}] Cek Member SSH"
		echo -e " ${BICyan}└─────────────────────────────────────────────────────┘${NC}"
		read -p "Please Choose One : " biji
		if [[ $biji == "1" ]]; then
			clear
			cekray=`cat /root/log-install.txt | grep -ow "XRAY" | sort | uniq`
			if [ "$cekray" = "XRAY" ]; then
			domen=`cat /etc/xray/domain`
			else
			domen=`cat /etc/v2ray/domain`
			fi
			portsshws=`cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2 | awk '{print $1}'`
			wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`

			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo -e "\E[0;41;36m            SSH Account            \E[0m"
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			read -p "Username : " Login
			read -p "Password : " Pass
			read -p "Expired (hari): " masaaktif

			IP=$(curl -sS ifconfig.me);
			ossl=`cat /root/log-install.txt | grep -w "OpenVPN" | cut -f2 -d: | awk '{print $6}'`
			opensh=`cat /root/log-install.txt | grep -w "OpenSSH" | cut -f2 -d: | awk '{print $1}'`
			db=`cat /root/log-install.txt | grep -w "Dropbear" | cut -f2 -d: | awk '{print $1,$2}'`
			ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
			clear
			useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
			exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
			echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null
			
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
			echo -e "\E[0;41;36m            SSH Account            \E[0m" | tee -a /etc/log-create-user.log
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
			echo -e "Username : $Login" | tee -a /etc/log-create-user.log
			echo -e "Password : $Pass" | tee -a /etc/log-create-user.log
			echo -e "Expired On : $exp" | tee -a /etc/log-create-user.log
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
			echo -e "IP : $IP" | tee -a /etc/log-create-user.log
			echo -e "Host : $domen" | tee -a /etc/log-create-user.log
			echo -e "OpenSSH : $opensh" | tee -a /etc/log-create-user.log
			echo -e "Dropbear : $db" | tee -a /etc/log-create-user.log
			echo -e "SSH-WS : $portsshws" | tee -a /etc/log-create-user.log
			echo -e "SSH-SSL-WS : $wsssl" | tee -a /etc/log-create-user.log
			echo -e "SSL/TLS : $ssl" | tee -a /etc/log-create-user.log
			echo -e "UDPGW : 7100-7300" | tee -a /etc/log-create-user.log
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
			echo -e "Payload WS" | tee -a /etc/log-create-user.log
			echo -e "GET / HTTP/1.1[crlf]Host: $domen[crlf]Upgrade: websocket[crlf][crlf]" | tee -a /etc/log-create-user.log
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /etc/log-create-user.log
		elif [[ $biji == "2" ]]; then
			clear
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo -e "\E[0;41;36m               DELETE USER                \E[0m"
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"  
			echo ""
			read -p "Username SSH to Delete : " Pengguna
				if getent passwd $Pengguna > /dev/null 2>&1; then
					userdel $Pengguna > /dev/null 2>&1
					echo -e "User $Pengguna was removed."
				else
					echo -e "Failure: User $Pengguna Not Exist."
     				fi
   		elif [[ $biji == "3" ]]; then
   			clear
				echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
				echo -e "\E[0;41;36m               RENEW  USER                \E[0m"
				echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"  
				echo
				read -p "Username : " User
				egrep "^$User" /etc/passwd >/dev/null
				if [ $? -eq 0 ]; then
				read -p "Day Extend : " Days
				Today=`date +%s`
				Days_Detailed=$(( $Days * 86400 ))
				Expire_On=$(($Today + $Days_Detailed))
				Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
				Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
				passwd -u $User
				usermod -e  $Expiration $User
				egrep "^$User" /etc/passwd >/dev/null
				echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
   			clear
				echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
				echo -e "\E[0;41;36m               RENEW  USER                \E[0m"
				echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"  
				echo -e ""
				echo -e " Username : $User"
				echo -e " Days Added : $Days Days"
				echo -e " Expires on :  $Expiration_Display"
				echo -e ""
				echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
				else
				clear
				echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
				echo -e "\E[0;41;36m               RENEW  USER                \E[0m"
				echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"  
				echo -e ""
				echo -e "   Username Doesnt Exist      "
				echo -e ""
				echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
				fi
			elif [[ $biji == "4" ]]; then
			clear
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo -e "\E[0;41;36m                 MEMBER SSH               \E[0m"
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"      
			echo "USERNAME          EXP DATE          STATUS"
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			while read expired
			do
			AKUN="$(echo $expired | cut -d: -f1)"
			ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
			exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
			status="$(passwd -S $AKUN | awk '{print $2}' )"
			if [[ $ID -ge 1000 ]]; then
			if [[ "$status" = "L" ]]; then
			printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "LOCKED${NORMAL}"
			else
			printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "UNLOCKED${NORMAL}"
			fi
			fi
			done < /etc/passwd
			JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			echo "Account number: $JUMLAH user"
			echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
			fi
		;;
2) menu-vmess;;
3) menu-trojan;;
4) menu-vless;;
5) menu-ssws;;
6) menu-socks;;
7)
        clear
        read -p "Input New Domain : " domainbaru
        #Validate
        if [[ $domainbaru == "" ]]; then
        echo "Please Input New Domain"
        clear
        exit 1
        else
        echo ""
        echo "IP=$host" > /var/lib/scrz-prem/ipvps.conf
        echo "Dont forget to renew cert"
        sleep 2
        menu;
        fi
        ;;
*)
        clear
        sleep 2
        echo -e "${ERROR} Please Input an valid number";
        menu;
esac