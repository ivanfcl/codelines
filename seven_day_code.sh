#!/bin/bash
#rm -rf CDIS CBS NCDB FEE
#rm -rf code-lines.csv
git clone git@gitlab:isu/CDIS.git
git clone git@gitlab:isu/NCDS.git
git clone git@gitlab:isu/CBS.git
git clone git@gitlab:isu/FEE.git
git clone git@gitlab:isu/fxmss.git
#git clone git@gitlab:fxmss-lpa/fxmss.git fxmss
#git clone git@gitlab:FXMSS-NEWTOUCH/fxmss.git FXMSS-NEWTOUCH
#git clone git@gitlab:algo-data/algo.git

end_date=`date +%Y-%m-%d`
#whichday=`date -d $today +%w`
#monday=`date -d "$today -$[${whichdate}-1] days" +%Y%m%d`
start_date=`date -d "$today-6 days" +%Y-%m-%d`
#echo "姓名,新增代码行数,删除代码行数,总计代码行数,代码分支,日期,系统" > code-lines.csv
#touch /root/code_statistics/codeline/code-lines.csv
for project in CDIS NCDS CBS
do
	cd $project
	for i in `git branch -a | sed '1,2d' | sed -n '/dev_/p' | sort -r`
	do
		branch=`echo $i | awk -F '/' '{print $3}'`
		git checkout -b $branch $i
		for j in `git log --after="$start_date 00:00:00" --before="$end_date 23:59:59" --format='%aN' | sort -u`
		do
			echo "$j,`git log --no-merges --after="$start_date 00:00:00" --before="$end_date 23:59:59" --author="$j" --pretty=tformat: --numstat | grep -v "vo" | awk '{add += $1;subs += $2; loc +=$1+$2} END {printf "%s,%s,%s",add,subs,loc}'`,$branch,$start_date,$end_date,$project" >> /root/code_statistics/codelines/code-lines.csv
		done
	done
	cd ..
done

cd FEE
for i in `git branch -a | sed '1,2d' | sed -n '/V/p' | sort -r`
do
	branch=`echo $i | awk -F '/' '{print $3}'`
	git checkout -b $branch $i
	for j in `git log --after="$start_date 00:00:00" --before="$end_date 23:59:59" --format='%aN' | sort -u`
	do
		echo "$j,`git log --no-merges --after="$start_date 00:00:00" --before="$end_date 23:59:59" --author="$j" --pretty=tformat: --numstat | awk '{add += $1;subs += $2; loc +=$1+$2} END {printf "%s,%s,%s",add,subs,loc}'`,$branch,$start_date,$end_date,FEE" >> /root/code_statistics/codelines/code-lines.csv
	done
done
cd ..

cd fxmss
for i in `git branch -a | sed '1,2d' | sed -n '/release/p' | sort -r`
do
	branch=`echo $i | awk -F '/' '{print $3}'`
	git checkout -b $branch $i
	for j in `git log --after="$start_date 00:00:00" --before="$end_date 23:59:59" --format='%aN' | sort -u`
	do
		echo "$j,`git log --no-merges --after="$start_date 00:00:00" --before="$end_date 23:59:59" --author="$j" --pretty=tformat: --numstat | sed '/[0-9,a-z]\{20\}/d' | grep -v "webapp" | awk '{add += $1;subs += $2; loc +=$1+$2} END {printf "%s,%s,%s",add,subs,loc}'`,$branch,$start_date,$end_date,FXMSS" >> /root/code_statistics/codelines/code-lines.csv
	done
done
cd ..

#cd FXMSS-NEWTOUCH
#for i in `git branch -a | sed '1,3d' | sed -n '/master/p' | sort -r`
#do
#	branch=`echo $i | awk -F '/' '{print $3}'`
#	git checkout -b $branch $i
#	for j in `git log --after="$date 00:00:00" --before="$date 23:59:59" --format='%aN' | sort -u`
#	do
#		echo "$j,`git log --no-merges --after="$date 00:00:00" --before="$date 23:59:59" --author="$j" --pretty=tformat: --numstat | sed '/[0-9,a-z]\{20\}/d' | awk '{add += $1;subs += $2; loc +=$1+$2} END {printf "%s,%s,%s",add,subs,loc}'`,$branch,$date,FXMSS" >> ../code-lines.csv
#	done
#done
#cd ..

#cd algo
#for i in `git branch -a | sed '1,2d' | sed '/master/d' | sort -r`
#do
#	branch=`echo $i | awk -F '/' '{print $3}'`
#	git checkout -b $branch $i
#	for j in `git log --after="$date 00:00:00" --before="$date 23:59:59" --format='%aN' | sort -u`
#	do
#		echo "$j,`git log --no-merges --after="$date 00:00:00" --before="$date 23:59:59" --author="$j" --pretty=tformat: --numstat | awk '{add += $1;subs += $2; loc +=$1+$2} END {printf "%s,%s,%s",add,subs,loc}'`,$branch,$date,algo" >> ../code-lines.csv
#	done
#done
#cd ..

sed -i '/,,,,/d' /root/code_statistics/codelines/code-lines.csv
sed -i 's/邓锦涛/dengjintao_wq/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/刘冰/liubing/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/王忠旭/wangzhongxu/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/黄风棋/huangfengqi_fb/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/眭林韬/suilintao/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/赵小芳/zhaoxiaofang_zr/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/汤亮/tangliang/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/吴磬/wuqing/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/赵晨阳/zhaochenyang_yt/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/季英财/jiyingcai/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/单国海/shanguohai_zwx/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/史浩军/shihaojun_zwx/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/孙本康/sunbenkang_zwx/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/肖泽亚/xiaozeya_zwx/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/朱方远/zhufangyuan_zwx/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/陈博/chenbo_zh/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/李飞/lifei_xz/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/李鹏/lipeng_xz/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/梁振荣/liangzhenrong_xz/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/张令/zhangling_hut/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/谭超/tanchao_jy/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/曹指利/caozhili_zwx/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/胡士杰/hushijie_zwx/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/邹军/zoujun_xp/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/沈瑞虎/shenruihu_xz/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/夏期彪/xiaqibiao/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/邓祥英/dengxiangying/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/王翰/wanghan/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/李财政/licaizhen_zh/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/周旻杰/zhouminjie_hs/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/白帆/baifan/g' /root/code_statistics/codelines/code-lines.csv
sed -i 's/樊辰龙/xiaomituan/g' /root/code_statistics/codelines/code-lines.csv

