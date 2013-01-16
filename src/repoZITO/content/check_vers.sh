#!/bin/sh

#
# Z-Mod E8
#
# Please don't modify this code.
#
# Copyright - Zorge.R - 2010 - motofan.ru
#

showNotify "repoZITO" "$rz_check_rz_start r$rz_curvers" 1 3
mkdir -p $repoz_tmp/update/repoZITO
$rz_wget -O $repoz_tmp/update/repoZITO/nextver $rz_serv/update/repoZITO/next.ver
rz_nextvers=`cat $repoz_tmp/update/repoZITO/nextver`

if [ $rz_nextvers -gt $rz_curvers ]
then
	showNotify "repoZITO" "$rz_check_rz_upd_need r$rz_nextvers. $rz_check_rz_upd_need2" 1 5
	$rz_wget -O $repoz_tmp/update/repoZITO/repoZITO_r$rz_nextvers.upd $rz_serv/update/repoZITO/repoZITO_r$rz_nextvers.upd
	$rz_wget -O $repoz_tmp/update/repoZITO/repoZITO_r$rz_nextvers.md5sum $rz_serv/update/repoZITO/repoZITO_r$rz_nextvers.md5sum
	rz_md5sum=`cat $repoz_tmp/update/repoZITO/repoZITO_r$rz_nextvers.md5sum`
# MD5CHECK START
		if [ "$rz_md5sum" != "" ]
		then
			showNotify "repoZITO" "$rz_MD5_check_STARTED" 0 1
			cd $repoz_tmp/update/repoZITO/
			md5sumcheck=`md5sum ./repoZITO_r$rz_nextvers.upd | sed "s/  \.\/repoZITO_r$rz_nextvers.upd$//"`
			if [ "$rz_md5sum" != "$md5sumcheck" ]
			then
				showQ "$rz_md5_err_head" "$rz_md5_err_txt" 2
				rm "$repoz_tmp/update/repoZITO/repoZITO_r$rz_nextvers.upd"
				rm "$repoz_tmp/update/repoZITO/repoZITO_r$rz_nextvers.md5sum"
			else
				showNotify "repoZITO" "$rz_MD5_check_FINISH" 0 1
				# INSTALL
	mkdir -p /ezxlocal/download/mystuff/.tmp/rep
	busybox tar -jxvf "$repoz_tmp/update/repoZITO/repoZITO_r$rz_nextvers.upd" -C "/ezxlocal/download/mystuff/.tmp/rep/"
	cp -f /ezxlocal/download/mystuff/.tmp/rep/repoZITO/* "$repoz_mypath" -R
	chmod 777 "$repoz_mypath" -R
	rm -R /ezxlocal/download/mystuff/.tmp/rep
				# INSTALL
			fi
		else
			showQ "$rz_md5_err_head" "$rz_md5_inet_err" 2
		fi
# MD5CHECK END
else
	showQ "repoZITO" "$rz_check_rz_upd_dneed r$rz_curvers" 2
fi

$repoz_mypath/repoZITO.sh

