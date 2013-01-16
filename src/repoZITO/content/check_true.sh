#!/bin/sh

#
# Z-Mod E8
#
# Please don't modify this code.
#
# Copyright - Zorge.R - 2010 - motofan.ru
#

# check - true

if [ ! -f "/bin/busybox" ]
			then
				showQ "" "$rz_ZMOD_ERR" 2
			else
				# start repoZITO
				. $repoz_content/repoZITO.sh
fi

