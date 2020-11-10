SET /P var=[Film Kodunu Girin] 
ffmpeg -protocol_whitelist file,http,https,tcp,tls,crypto -i https://www.filmmodu.org/uploads/subs/%var%/0.vtt %var%.vtt
SLEEP 3
ffmpeg -i %var%.mp4 -filter_complex "subtitles=%var%.vtt" -c:a copy %var%.mp4
SLEEP 3
del /f %var%.vtt