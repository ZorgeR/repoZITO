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

showNotify "repoZITO" "$rz_start_download" 1 1

if [ ! -f "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix" ]
then
	mkdir -p "$repoz_tmp/$rz_packtype/$rz_packtoget"
		$rz_wget -O "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix" "$rz_serv/$rz_packtype/$rz_packtoget/$rz_postfix"
		showNotify "repoZITO" "$rz_download_complete" 0 1
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
				rzdoinstall$rzPEPMGXZPK
				# INSTALL
			fi
		else
			# INSTALL
			rzdoinstall$rzPEPMGXZPK
			# INSTALL

		fi
# MD5CHECK END

else
	
# INSTALL
rzdoinstall$rzPEPMGXZPK
# INSTALL

fi

. $repoz_content/repoZITO.sh

