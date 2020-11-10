SET /P var=[Film Kodunu Girin] 
ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i https://www.filmmodu.org/uploads/subs/%var%/0.vtt %var%.ass
SLEEP 3
ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i https://srv7.filmmodu.xyz/%var%/1080p.en.m3u8 -i %var%.ass -map 0:v -map 0:a -map 1:s -metadata:s:a language=eng -metadata:s:s:1 language=tur -c copy %var%.mkv
SLEEP 3
del /f %var%.ass
