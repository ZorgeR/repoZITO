#!/bin/sh

#
# Z-Mod E8
#
# Please don't modify this code.
#
# Copyright - Zorge.R - 2010 - motofan.ru
#

rz_serv=`cat $repoz_content/reposerv`
rz_curvers=`cat $repoz_content/repovers`
# for stupid mosterpack (for monsterpack wich haven't wget)
#rz_wget="/bin/busybox wget"
rz_wget="wget"

showRadio "$rz_NAME_APP" "r$rz_curvers" "$rz_TAB_1" "$rz_TAB_2" "$rz_TAB_6" "$rz_TAB_3" "$rz_TAB_4" "$rz_TAB_5"

ret=$?
[ $ret -eq 0 ] && exit

case $ret in
	1)	. $repoz_content/upd_list.sh
		;;
	2)	. $repoz_content/tmp.sh
		;;
	3)	
		if [ "$rz_model" = "EM30" ];then rz_model=E8;fi
		$repoz_mypath/netexec.$rz_model
		;;
	4)	. $repoz_content/serv.sh
		;;
	5)	. $repoz_content/check_vers.sh
		;;
	6)	. $repoz_content/about.sh
		;;
	*)
		;;
esac

