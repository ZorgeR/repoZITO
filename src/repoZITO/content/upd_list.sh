#!/bin/sh

#
# Z-Mod E8
#
# Please don't modify this code.
#
# Copyright - Zorge.R - 2010 - motofan.ru
#

showRadio "repoZITO" "$rz_list_header" "$rz_list_app" "$rz_list_game" "$rz_list_upd"
listsel=$?
if [ $listsel -eq 1 ]
then
	rz_packtype="app"
elif [ $listsel -eq 2 ]
then
	rz_packtype="game"
elif [ $listsel -eq 3 ]
then
	rz_packtype="patch"
else
	exit
fi

showNotify "repoZITO" "$rz_start_download" 1 1
$rz_wget -O $repoz_tmp/list $rz_serv/$rz_packtype/$rz_model
showNotify "repoZITO" "$rz_download_complete" 0 1

rz_list=`cat $repoz_tmp/list`
rz_sedlist=$repoz_tmp/list

showRadio "$rz_NAME_APP" "$rz_Pack_on_server" $rz_list
RADIORES=$?
if [ $RADIORES -eq 0 ]
then
	. $repoz_content/upd_list.sh
else
	rz_packname=`sed -n $RADIORES\p $rz_sedlist`
	showQ "repoZITO" "$rz_pack_selected - $rz_packname" 2
	. $repoz_content/get_info.sh
fi

