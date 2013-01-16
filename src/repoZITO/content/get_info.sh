#!/bin/sh

#
# Z-Mod E8
#
# Please don't modify this code.
#
# Copyright - Zorge.R - 2010 - motofan.ru
#

rz_packtoget=$rz_packname

showNotify "repoZITO" "$rz_start_download" 1 1

if [ ! -f "$repoz_tmp/$rz_packtype/$rz_packtoget/info" ]
then
	mkdir -p $repoz_tmp/$rz_packtype/$rz_packtoget

	$rz_wget -O $repoz_tmp/$rz_packtype/$rz_packtoget/info $rz_serv/$rz_packtype/$rz_packtoget/info
	showNotify "repoZITO" "$rz_download_complete" 0 1
	rz_info=`grep '^info = ' "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed 's,^info = ,,'`
	rz_packsize=`grep "^size = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^size = ,,"`
	rz_packversion=`grep "^version = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^version = ,,"`
	rz_packlng=`grep "^lng = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^lng = ,,"`
	showQ "info about $rz_packtoget" "$rz_info $rz_size_txt $rz_packsize. $rz_vers_txt $rz_packversion. $rz_lng_txt $rz_packlng. $rz_inst_NOW" 1
	retr=$?
	if [ $retr -eq 1 ]
	then
		. $repoz_content/get_pack.sh
	else
		. $repoz_content/upd_list.sh
	fi
else
	rz_info=`grep '^info = ' "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed 's,^info = ,,'`
	rz_packsize=`grep "^size = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^size = ,,"`
	rz_packversion=`grep "^version = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^version = ,,"`
	rz_packlng=`grep "^lng = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^lng = ,,"`
	showQ "info about $rz_packtoget" "$rz_info $rz_size_txt $rz_packsize. $rz_vers_txt $rz_packversion. $rz_lng_txt $rz_packlng. $rz_inst_NOW" 1
	retr=$?
	if [ $retr -eq 1 ]
	then
		. $repoz_content/get_pack.sh
	else
		. $repoz_content/upd_list.sh
	fi
fi



