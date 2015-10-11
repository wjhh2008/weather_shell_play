#! /bin/bash
dir=/home/pi/weather

weather0=$(cat $dir/shanghai.xml | grep pudong | cut -d ' ' -f 10| sed -r 's/.*"(.+)".*/\1/')
high0=$(cat $dir/shanghai.xml | grep pudong | cut -d ' ' -f 11| sed -r 's/.*"(.+)".*/\1/')
low0=$(cat $dir/shanghai.xml | grep pudong | cut -d ' ' -f 12| sed -r 's/.*"(.+)".*/\1/')
now0=$(cat $dir/shanghai.xml | grep pudong | cut -d ' ' -f 13| sed -r 's/.*"(.+)".*/\1/')
wind0=$(cat $dir/shanghai.xml | grep pudong | cut -d ' ' -f 14| sed -r 's/.*"(.+)".*/\1/')


wget -q -O $dir/shanghai.xml http://flash.weather.com.cn/wmaps/xml/shanghai.xml

weather=$(cat $dir/shanghai.xml | grep pudong | cut -d ' ' -f 10| sed -r 's/.*"(.+)".*/\1/')
high=$(cat $dir/shanghai.xml | grep pudong | cut -d ' ' -f 11| sed -r 's/.*"(.+)".*/\1/')
low=$(cat $dir/shanghai.xml | grep pudong | cut -d ' ' -f 12| sed -r 's/.*"(.+)".*/\1/')
now=$(cat $dir/shanghai.xml | grep pudong | cut -d ' ' -f 13| sed -r 's/.*"(.+)".*/\1/')
wind=$(cat $dir/shanghai.xml | grep pudong | cut -d ' ' -f 14| sed -r 's/.*"(.+)".*/\1/')

url="http://translate.google.cn/translate_tts?tl=zh_cn&q="
up=`expr $high - $high0`
down=`expr $high0 - $high`
add=""
if [ $up -lt 2 -o $down -lt 2 ]; 
	then add="相比昨日，温度相差不大。"
fi
if [ $up -gt 3 ]; 
	then add="相比昨日，升温"$up"摄氏度。"
fi
if [ $down -gt 3 ]; 
	then add="相比昨日，降温"$down"摄氏度。" 
fi
statement=${url}"早上好！今日天气，"${weather}"。气温，"${low}"到"${high}"摄氏度。"${add}"当前温度，"${now}"摄氏度。"${wind}"。"
#echo $statement
wget -q -U "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1312.52 Safari/537.17" -O $dir/test.mp3 $statement && mplayer $dir/test.mp3

