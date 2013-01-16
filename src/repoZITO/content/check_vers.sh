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
	$rz_wget -O $repoz_tmp/update/repoZITO/repoZITO_r$rz_nextvers.mgx $rz_serv/update/repoZITO/repoZITO_r$rz_nextvers.mgx
	mkdir -p /ezxlocal/download/mystuff/.tmp/rep
	busybox tar -jxvf "$repoz_tmp/update/repoZITO/repoZITO_r$rz_nextvers.mgx" -C "/ezxlocal/download/mystuff/.tmp/rep/"
	cp -f /ezxlocal/download/mystuff/.tmp/rep/repoZITO/* "$repoz_mypath" -R
	chmod 777 "$repoz_mypath" -R
	rm -R /ezxlocal/download/mystuff/.tmp/rep
else
	showQ "repoZITO" "$rz_check_rz_upd_dneed r$rz_curvers" 2
fi

$repoz_mypath/repoZITO.sh

