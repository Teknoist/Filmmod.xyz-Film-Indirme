@SET /P var=[Film Kodunu Girin]
@SET /P mod=[Seçiniz Dublaj(D)- Altyazı(A)- Multi(M)] 

@if %mod%==D goto dublaj
@if %mod%==A goto altyazi
@if %mod%==M goto multi

:multi
@ffmpeg.exe -protocol_whitelist file,http,https,tcp,tls,crypto -i https://www.filmmodu.org/uploads/subs/%var%/0.vtt %var%.ass
@SLEEP 3
@ffmpeg.exe -protocol_whitelist file,http,https,tcp,tls,crypto -i https://srv7.filmmodu.xyz/%var%/1080p.tr.m3u8 -i https://srv7.filmmodu.xyz/%var%/1080p.en.m3u8 -i %var%.ass -map 0:v -map 0:a -map 1:a -map 2:s -metadata:s:a:0 language=tur -metadata:s:a:1 language=eng -metadata:s:s:2 language=tur -c copy %var%.mkv
@SLEEP 3
@del /f %var%.ass
@set sonuc=Multi
@goto end

:altyazi
@ffmpeg.exe -protocol_whitelist file,http,https,tcp,tls,crypto -i https://www.filmmodu.org/uploads/subs/%var%/0.vtt %var%.ass
@SLEEP 3
@ffmpeg.exe -protocol_whitelist file,http,https,tcp,tls,crypto -i https://srv7.filmmodu.xyz/%var%/1080p.en.m3u8 -i %var%.ass -map 0:v -map 0:a -map 1:s -metadata:s:a language=eng -metadata:s:s:1 language=tur -c copy %var%.mkv
@SLEEP 3
@del /f %var%.ass
@set sonuc=Altyazi
@goto end

 
:dublaj
@ffmpeg.exe -protocol_whitelist file,http,https,tcp,tls,crypto -i https://srv7.filmmodu.xyz/%var%/1080p.tr.m3u8 -map 0:v -map 0:a -map -metadata:s:a language=tur -c copy %var%.mkv
@set sonuc=Dublaj
@goto end

:end
@echo "%sonuc% İndirme Tamamlandı"
