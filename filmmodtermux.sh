#!/bin/bash
pkg install ffmpeg -y 
termux-setup-storage 
wait 4
cd ~/storage/downloads
read -p "Film Kodunu girin: " val
ffmpeg.exe -protocol_whitelist file,http,https,tcp,tls,crypto -i "https://www.filmmodu.org/uploads/subs/$val/0.vtt" "$val.ass"
ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "https://srv7.filmmodu.xyz/$val/1080p.en.m3u8" -i "https://srv7.filmmodu.xyz/$val/1080p.tr.m3u8" -i "$val.ass" -map 0:v -map 0:a -map 1:a -map 2:s -metadata:s:a:0 language=eng -metadata:s:a:1 language=tur -metadata:s:s:2 language=tur -c copy "val.mkv"

