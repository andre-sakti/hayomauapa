source /etc/bahenol/autokill.conf;
while true; do
sleep 30
# // Start
source /etc/bahenol/autokill.conf;
grep -c -E "^### " "/etc/xray/config.json" > /etc/bahenol/jumlah-akun-vmess.db;
grep -E "^### " "/etc/xray/config.json"  > /etc/bahenol/akun-vmess.db;
totalaccounts=`cat /etc/bahenol/akun-vmess.db | wc -l`;
echo "Total Akun = $totalaccounts" > /etc/bahenol/total-akun-vmess.db;
for((i=1; i<=$totalaccounts; i++ ));
do
    # // Username Interval Counting
    user=(`cat /etc/xray/config.json | grep '^###' | cut -d ' ' -f 2 | sort | uniq`);
    exp=$(grep -w "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)

    # // Creating Cache for access.log
    cat /var/log/xray/access.log | tail -n 30000 > /etc/bahenol/xray/cache.log

    # // Configuration user logs
    now=$(date +%Y-%m-%d)
    waktu=`date -d "0 days" +"%H:%M"`;
    waktunya=`date -d "0 days" +"%Y/%m/%d %H:%M"`;
    jumlah_baris_log=$( cat /etc/bahenol/xray/cache.log  | grep -w 'accepted' | grep -w $user | wc -l );

    if [[ $jumlah_baris_log -gt $VMESS ]]; then
        sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
        systemctl restart xray;
        date=`date +"%X"`;
        echo "$(date) ${user} - Multi Login Detected - Killed at ${date}"
        echo "VMESS - $(date) - ${user} - Multi Login Detected - Killed at ${date}" >> /etc/bahenol/autokill.log;                             
fi
# // End Function
done
done