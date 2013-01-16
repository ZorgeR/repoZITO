#!/bin/sh

#
# Z-Mod E8
#
# Please don't modify this code.
#
# Copyright - Zorge.R - 2010 - motofan.ru
#

rz_curserv=`cat $repoz_content/reposerv`

showRadio "$rz_HEAD_SERV" "$rz_curserv" "$rz_SERV_TAB_1"

ret=$?
[ $ret -eq 0 ] && . $repoz_content/repoZITO.sh

case $ret in
	1)	
		rz_newserv=`showTextEntry "$repoz_content/reposerv" "repoZITO" "$rz_newserv_enter" 0`
		#echo -ne "$rz_newserv" >$repoz_content/reposerv
		showQ "$rz_newserv_compl" "$rz_newserv_compl_txt - $rz_newserv" 2
		;;
	*)
		;;
esac

. $repoz_content/repoZITO.sh

