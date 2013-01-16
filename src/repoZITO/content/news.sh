#!/bin/sh

#
# Z-Mod E8
#
# Please don't modify this code.
#
# Copyright - Zorge.R - 2010 - motofan.ru
#

rm "$repoz_tmp/news.list"
showNotify "repoZITO" "$rz_start_download" 1 1
$rz_wget -O "$repoz_tmp/news.list" "$rz_serv/news.list"
rz_news_txt=`cat "$repoz_tmp/news.list"`
showQ "repoZITO" "$rz_news_txt" 2

. $repoz_content/repoZITO.sh

