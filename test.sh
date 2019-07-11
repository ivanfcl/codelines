#!/bin/bash
rm -rf /root/code_statistics/codelines/*.csv
sh /root/code_statistics/delete_code.sh
while true
do 
	sh /root/code_statistics/two_day_code.sh	
	if [ $? -eq 0 ]; then
		sh /root/code_statistics/delete_code.sh
	break
	else
		sh /root/code_statistics/delete_code.sh
		rm -f /root/code_statistics/codelines/twoday-codes.csv
	fi
done


while true
do
        sh /root/code_statistics/seven_day_code.sh
        if [ $? -eq 0 ]; then
                sh /root/code_statistics/delete_code.sh
        break
        else
                sh /root/code_statistics/delete_code.sh
                rm -f /root/code_statistics/codelines/code-lines.csv
        fi
done

while true
do
        sh /root/code_statistics/half_month_code.sh
        if [ $? -eq 0 ]; then
                sh /root/code_statistics/delete_code.sh
        break
        else
                sh /root/code_statistics/delete_code.sh
                rm -f /root/code_statistics/codelines/half_month_code.csv
        fi
done

/usr/local/python3/bin/python3  /root/code_statistics/codelines/twoday_codeline.py
/usr/local/python3/bin/python3  /root/code_statistics/codelines/sevenday_codeline.py
/usr/local/python3/bin/python3  /root/code_statistics/codelines/halfmonth_codeline.py



