#!/bin/sh

#
# Z-Mod E8
#
# Please don't modify this code.
#
# Copyright - Zorge.R - 2010 - motofan.ru
#

rz_packtoget=$rz_packname
rz_postfix=`grep "^$rz_model = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^$rz_model = ,,"`
rz_md5sum=`grep "^md5sum.$rz_model = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^md5sum.$rz_model = ,,"`


rz_getapponline()
{
if [ -f "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix" ]
then
	showQ "repoZITO" "$rz_cache_found_txt" 1
	rzgetappfromcache=$?
	if [ "$rzgetappfromcache" = "1" ]
	then
	mkdir -p "$repoz_tmp/$rz_packtype/$rz_packtoget"
	showNotify "repoZITO" "$rz_start_download" 1 1
	rm "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix"
	$rz_wget -O "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix" "$rz_serv/$rz_packtype/$rz_packtoget/$rz_postfix"
	showNotify "repoZITO" "$rz_download_complete" 0 1
	fi
else
	showNotify "repoZITO" "$rz_start_download" 1 1
	rm "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix"
	$rz_wget -O "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix" "$rz_serv/$rz_packtype/$rz_packtoget/$rz_postfix"
	showNotify "repoZITO" "$rz_download_complete" 0 1
fi
}

rz_getappcache()
{
if [ ! -f "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix" ]; then showQ "repoZITO" "$rz_cache_not_found_txt" 1
rzcacheapp=$?
if [ "$rzcacheapp" = "1" ]
then
	mkdir -p "$repoz_tmp/$rz_packtype/$rz_packtoget"
	$rz_wget -O "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix" "$rz_serv/$rz_packtype/$rz_packtoget/$rz_postfix"
else
. $repoz_content/upd_list.sh -afterselect
fi
fi
}

MD5sumChecker()
{
# MD5CHECK START
		if [ "$rz_md5sum" != "" ]
		then
			showNotify "repoZITO" "$rz_MD5_check_STARTED" 0 1
			cd $repoz_tmp/$rz_packtype/$rz_packtoget
			md5sumcheck=`md5sum ./$rz_postfix | sed "s/  \.\/$rz_postfix$//"`
			if [ "$rz_md5sum" != "$md5sumcheck" ]
			then
				showQ "$rz_md5_err_head" "$rz_md5_err_txt" 2
				rm "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix"
			else
				showNotify "repoZITO" "$rz_MD5_check_FINISH" 0 1
				# INSTALL
				rzdoinstall$rzPtype
				# INSTALL
			fi
		else
			# INSTALL
			rzdoinstall$rzPtype
			# INSTALL

		fi
# MD5CHECK END
}


if [ "$cached" = "false" ]
then
rz_getapponline
else
rz_getappcache
fi

MD5sumChecker

. $repoz_content/upd_list.sh -afterselect

