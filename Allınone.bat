@ECHO off
chcp 65001 >NUL 2>&1
SET /P var=[Film Kodunu Girin] 
SET /P mod=[Seçiniz Dublaj(D)- Altyazı(A)- Multi(M)] 
if %mod%==D goto dublaj
if %mod%==A goto altyazi
if %mod%==M goto multi
if %mod%==d goto dublaj
if %mod%==a goto altyazi
if %mod%==m goto multi

:multi
ffmpeg.exe -v quiet -y -protocol_whitelist file,http,https,tcp,tls,crypto -i https://www.filmmodu.org/uploads/subs/%var%/0.vtt %var%.ass
ffmpeg.exe -v quiet -stats -y -protocol_whitelist file,http,https,tcp,tls,crypto -i https://srv7.filmmodu.xyz/%var%/1080p.tr.m3u8 -i https://srv7.filmmodu.xyz/%var%/1080p.en.m3u8 -i %var%.ass -map 0:v -map 0:a -map 1:a -map 2:s -metadata:s:a:0 language=tur -metadata:s:a:1 language=eng -metadata:s:s:2 language=tur -c copy %var%.mkv
if %errorlevel% neq 0 goto multihata
del /f %var%.ass
set sonuc=Multi
goto end

:altyazi
ffmpeg.exe -v quiet -y -protocol_whitelist file,http,https,tcp,tls,crypto -i https://www.filmmodu.org/uploads/subs/%var%/0.vtt %var%.ass
if %errorlevel% neq 0 goto althata
ffmpeg.exe -v quiet -stats -y -protocol_whitelist file,http,https,tcp,tls,crypto -i https://srv7.filmmodu.xyz/%var%/1080p.en.m3u8 -i %var%.ass -map 0:v -map 0:a -map 1:s -metadata:s:a language=eng -metadata:s:s:1 language=tur -c copy %var%.mkv
del /f %var%.ass
set sonuc=Altyazi
goto end

 
:dublaj
ffmpeg.exe -v quiet -stats -y -protocol_whitelist file,http,https,tcp,tls,crypto -i https://srv7.filmmodu.xyz/%var%/1080p.tr.m3u8 -map 0:v -map 0:a -map -metadata:s:a language=tur -c copy %var%.mkv
if %errorlevel% neq 0 goto dubhata
set sonuc=Dublaj
goto end


:multihata
cls
SET /P hata=[Multi İndirilmiyor Dublaj yada Altyazı Denensin Mi? (D)ublaj/(A)lyazı/(H)ayır ]  
if %hata%==D goto dublaj
if %hata%==A goto altyazi
if %hata%==H goto end-hata
if %hata%==d goto dublaj
if %hata%==a goto altyazi
if %hata%==h goto end-hata

:althata
cls
SET /P hata=[Altyazı İndirilmiyor Dublaj Denensin Mi? (E)vet/(H)ayır  ]  
if %hata%==E goto dublaj
if %hata%==H goto end-hata
if %hata%==e goto dublaj
if %hata%==h goto end-hata
:dubhata
cls
SET /P hata=[Dublaj İndirilmiyor Altyazı Denensin Mi? (E)vet/(H)ayır  ]  
if %hata%==E goto altyazi
if %hata%==H goto end-hata
if %hata%==e goto altyazi
if %hata%==h goto end-hata

:end
echo "%sonuc% İndirme Tamamlandı"
pause

:end-hata
del /f %var%.ass
echo "İndirilemedi Kulanıcı Tarafından İptal Edildi"
pause
