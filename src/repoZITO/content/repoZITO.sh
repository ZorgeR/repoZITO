#!/bin/sh

#
# Z-Mod E8
#
# Please don't modify this code.
#
# Copyright - Zorge.R - 2010 - motofan.ru
#

ifgprsON()
{
showRadio "$rz_NAME_APP" "r$rz_curvers" "$rz_mm_get_main_list" "$rz_mm_get_cache_list" "$rz_mm_server" "$rz_mm_check_upd" "$rz_mm_info"

ret=$?
[ $ret -eq 0 ] && exit

case $ret in
	1)	
		cached="false"
		. $repoz_content/upd_list.sh
		;;
	2)	
		cached="true"
		. $repoz_content/upd_list.sh
		;;
	3)	. $repoz_content/serv.sh
		;;
	4)	. $repoz_content/check_vers.sh
		;;
	5)	. $repoz_content/about.sh
		;;
	*)
		;;
esac
}

ifgprsOFF()
{
showRadio "$rz_NAME_APP" "r$rz_curvers" "$rz_mm_get_main_list" "$rz_mm_get_cache_list" "$rz_mm_server" "$rz_mm_check_upd" "$rz_mm_gprs" "$rz_mm_info"

ret=$?
[ $ret -eq 0 ] && exit

case $ret in
	1)	
		cached="false"
		. $repoz_content/upd_list.sh
		;;
	2)	
		cached="true"
		. $repoz_content/upd_list.sh
		;;
	3)	. $repoz_content/serv.sh
		;;
	4)	. $repoz_content/check_vers.sh
		;;
	5)	if [ "$rz_model" = "EM30" ];then rz_model=E8;fi
		if [ -f "$repoz_mypath/netexec.$rz_model" ];then $repoz_mypath/netexec.$rz_model;else showQ "$rz_gprs_head" "$rz_gprs_err" 2; . $repoz_content/repoZITO.sh;fi
		;;
	6)	. $repoz_content/about.sh
		;;
	*)
		;;
esac
}

# проверяем, активен ли GPRS mode
checkNETexec=`pidof netexec.$rz_model`

if [ "$checkNETexec" != 0 ] && [ "$checkNETexec" != "" ]
then
	ifgprsON
else
	ifgprsOFF
fi

