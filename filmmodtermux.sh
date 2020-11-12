#!/bin/bash
read -p "Film Kodunu girin: " val
ffmpeg.exe -protocol_whitelist file,http,https,tcp,tls,crypto -i "https://www.filmmodu.org/uploads/subs/$val/0.vtt" "$val.ass"
ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i "https://srv7.filmmodu.xyz/$val/1080p.en.m3u8" -i "$val.ass"  -c copy "&val.mkv"

