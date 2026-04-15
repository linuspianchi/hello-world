#!/bin/bash 
{
infos=$(curl -sI https://www2.informatik.hu-berlin.de/sar/Itsec/lectures.html)

echo "===== HTTP-Infos ======="
echo "$infos" | awk '/HTTP/ {print "HTTP_code: " $2} /Date/ {print $0}' 
echo "$infos" | grep '^Last[a-zA-Z]*' 
echo "===== DNS ====="
nslookup www.hu-berlin.de 2>/dev/null | sed '1,2d' | grep '^Address:' 
echo "===== Zertifikat ====="
zertifikat=$(openssl s_client -connect hu-berlin.de:443 -servername hu-berlin.de < /dev/null 2>&1)
echo "$zertifikat"
} > webcheck.txt 2>&1
check=$?
if [ check ]; then
	echo "webcheck happend"
else
	echo "some errors occured"
fi
