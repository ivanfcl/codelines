#!/bin/bash
for i in `ps aux | grep test.sh| awk '{print $2}'`
do 
	kill -9 $i
done

