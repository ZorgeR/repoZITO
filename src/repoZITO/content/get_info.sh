#!/bin/sh

#
# Z-Mod E8
#
# Please don't modify this code.
#
# Copyright - Zorge.R - 2010 - motofan.ru
#

rz_packtoget=$rz_packname

### Installation block ####
rzdoinstallMGX()
{
	$rz_rokr2 -o "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix"
}

rzdoinstallPEP()
{
	$rz_pep -o "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix"
}

rzdoinstallZPK()
{
	$rz_zpk -o "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix"
}

rzdoinstallMPKG()
{
	$rz_mpkg -d "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix"
}

rzdoinstallMGS()
{
	$rz_mgs -d "$repoz_tmp/$rz_packtype/$rz_packtoget/$rz_postfix"
}
### Installation block ####

### GET INFO BLOCK ###
rz_dogetinfo()
{
	rz_info=`grep "^info.$LANGSTR = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^info.$LANGSTR = ,,"`
	if [ "$rz_info" = "" ]; then rz_info=`grep "^info = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^info = ,,"`; fi
	rz_packsize=`grep "^size = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^size = ,,"`
	rz_packversion=`grep "^version = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^version = ,,"`
	rz_packlng=`grep "^lng = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^lng = ,,"`
	rz_author=`grep "^author = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^author = ,,"`
	rz_screens=`grep "^screens = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^screens = ,,"`
	rz_check_pep=`grep "^pep.$rz_model = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^pep.$rz_model = ,,"`
	rz_check_zpk=`grep "^zpk.$rz_model = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^zpk.$rz_model = ,,"`
	rz_check_mpkg=`grep "^mpkg.$rz_model = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^mpkg.$rz_model = ,,"`
	rz_check_mgs=`grep "^mgs.$rz_model = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^mgs.$rz_model = ,,"`
	if [ "$rz_check_pep" = "true" ]
	then rzPtype="PEP"
	elif [ "$rz_check_zpk" = "true" ]
	then rzPtype="ZPK"
	elif [ "$rz_check_mpkg" = "true" ]
	then rzPtype="MPKG"
	elif [ "$rz_check_mgs" = "true" ]
	then rzPtype="MGS"
	else rzPtype="MGX"
	fi
	showRadio "info about $rz_packtoget" "========
$rz_info
========
$rz_size_txt: $rz_packsize.
$rz_vers_txt: $rz_packversion.
$rz_lng_txt: $rz_packlng.
$rz_author_txt: $rz_author.
$rz_packtype_txt: $rzPtype.
========" "$rz_get_info_install" "$rz_get_info_screen"
}
### GET INFO BLOCK ###

rz_getinfoonline()
{
	showNotify "repoZITO" "$rz_start_download" 1 1
	mkdir -p $repoz_tmp/$rz_packtype/$rz_packtoget
	$rz_wget -O "$repoz_tmp/$rz_packtype/$rz_packtoget/info" "$rz_serv/$rz_packtype/$rz_packtoget/i.nfo"
	showNotify "repoZITO" "$rz_download_complete" 0 1
}

rz_getinfocache()
{
if [ ! -f $repoz_tmp/$rz_packtype/$rz_packtoget/info ]; then showQ "repoZITO" "$rz_cache_not_found_txt" 1
rzcachefl=$?
if [ "$rzcachefl" = "1" ]
then
	mkdir -p $repoz_tmp/$rz_packtype/$rz_packtoget
	$rz_wget -O "$repoz_tmp/$rz_packtype/$rz_packtoget/info" "$rz_serv/$rz_packtype/$rz_packtoget/i.nfo"
else
. $repoz_content/upd_list.sh -afterselect
fi
fi
}

rz_dogetscreen()
{
### SCREENSHOT BLOCK ###

if [ "$rz_screens" != 0 ] && [ "$rz_screens" != "" ]
then
	showQ "repoZITO" "$rz_screen_txt
$rz_screen_num_txt: $rz_screens
$rz_screen_open_txt" 1
	screendo=$?
	num=0
	let rz_true_screen_num=$rz_screens-1
	if [ $screendo -eq 1 ]
	then
		while [ $num -le $rz_true_screen_num ]
		do
			if [ ! -f "$repoz_tmp/$rz_packtype/$rz_packtoget/$num.png" ]
			then
				mkdir -p $repoz_tmp/$rz_packtype/$rz_packtoget
				$rz_wget -O "$repoz_tmp/$rz_packtype/$rz_packtoget/$num.png" "$rz_serv/$rz_packtype/$rz_packtoget/screens/$num.png"
			fi
		showNotify "repoZITO" "$rz_start_download" 1 1
		$imgviewer -d "$repoz_tmp/$rz_packtype/$rz_packtoget/$num.png"
		let num=$num+1
		done
	fi
else
showQ "repoZITO" "$rz_screen_not_found" 2
fi
### SCREENSHOT BLOCK ###
}


if [ "$cached" = "false" ]
then
rz_getinfoonline
else
rz_getinfocache
fi

	rz_dogetinfo

	retr=$?
	if [ "$retr" -eq "1" ]
	then
		. $repoz_content/get_pack.sh
	elif [ "$retr" -eq "2" ]
	then
		rz_dogetscreen
		. $repoz_content/get_info.sh
	else
		. $repoz_content/upd_list.sh -afterselect
	fi

