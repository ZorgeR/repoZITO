#!/bin/sh

#
# Z-Mod E8
#
# Please don't modify this code.
#
# Copyright - Zorge.R - 2010 - motofan.ru
#

find $repoz_tmp/* -name *.mpkg | xargs rm
find $repoz_tmp/* -name *.list | xargs rm
find $repoz_tmp/* -name *.mgx | xargs rm
find $repoz_tmp/* -name *.mgs | xargs rm
find $repoz_tmp/* -name *.txt | xargs rm
find $repoz_tmp/* -name *.zpk | xargs rm
find $repoz_tmp/* -name *.pep | xargs rm
find $repoz_tmp/* -name *.pkg | xargs rm
find $repoz_tmp/* -name *info | xargs rm
find $repoz_tmp/* -name *ver | xargs rm

showQ "$rz_cache_head" "$rz_cache_complete" 2

. $repoz_content/repoZITO.sh

