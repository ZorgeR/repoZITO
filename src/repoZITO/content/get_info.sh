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
### Installation block ####

### GET INFO BLOCK ###
rz_dogetinfo()
{
	rz_info=`grep "^info.$LANGSTR = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^info.$LANGSTR = ,,"`
	if [ "$rz_info" = "" ]; then rz_info=`grep "^info = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^info = ,,"`; fi
	rz_packsize=`grep "^size = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^size = ,,"`
	rz_packversion=`grep "^version = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^version = ,,"`
	rz_packlng=`grep "^lng = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^lng = ,,"`
	rz_check_pep=`grep "^pep.$rz_model = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^pep.$rz_model = ,,"`
	rz_check_zpk=`grep "^zpk.$rz_model = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^zpk.$rz_model = ,,"`
	rz_check_mpkg=`grep "^mpkg.$rz_model = " "$repoz_tmp/$rz_packtype/$rz_packtoget/info" | sed "s,^mpkg.$rz_model = ,,"`
	if [ "$rz_check_pep" = "true" ]
	then rzPtype="PEP"
	elif [ "$rz_check_zpk" = "true" ]
	then rzPtype="ZPK"
	elif [ "$rz_check_mpkg" = "true" ]
	then rzPtype="MPKG"
	else rzPtype="MGX"
	fi
	showQ "info about $rz_packtoget" "========
$rz_info
========
$rz_size_txt: $rz_packsize.
$rz_vers_txt: $rz_packversion.
$rz_lng_txt: $rz_packlng.
$rz_packtype_txt: $rzPtype.
========
$rz_inst_NOW" 1
}
### GET INFO BLOCK ###

showNotify "repoZITO" "$rz_start_download" 1 1

if [ ! -f "$repoz_tmp/$rz_packtype/$rz_packtoget/info" ]
then
	mkdir -p $repoz_tmp/$rz_packtype/$rz_packtoget
	$rz_wget -O $repoz_tmp/$rz_packtype/$rz_packtoget/info $rz_serv/$rz_packtype/$rz_packtoget/info
	showNotify "repoZITO" "$rz_download_complete" 0 1
	rz_dogetinfo
	retr=$?
	if [ $retr -eq 1 ]
	then
		. $repoz_content/get_pack.sh
	else
		. $repoz_content/upd_list.sh
	fi
else
	rz_dogetinfo
	retr=$?
	if [ $retr -eq 1 ]
	then
		. $repoz_content/get_pack.sh
	else
		. $repoz_content/upd_list.sh
	fi
fi



