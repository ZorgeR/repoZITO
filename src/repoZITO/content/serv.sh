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
		if [ $rz_model = E2 ];then rz_newserv=`showTextEntry 0 "repoZITO" "Enter adress with http:// or ftp://"`;echo "$rz_newserv" > "$repoz_content/reposerv";else rz_newserv=`showTextEntry "$repoz_content/reposerv" "repoZITO" "$rz_newserv_enter" 0`;fi
		rz_newserv_txt=`cat $repoz_content/reposerv`
		showQ "$rz_newserv_compl" "$rz_newserv_compl_txt - $rz_newserv_txt" 2
		;;
	*)
		;;
esac

. $repoz_content/repoZITO.sh

