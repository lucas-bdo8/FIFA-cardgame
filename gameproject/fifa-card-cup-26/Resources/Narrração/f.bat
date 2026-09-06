@echo off

set "OUTPUT=E:\fifa-card-cup-26\Resources\Narrração"

if not exist "%OUTPUT%" mkdir "%OUTPUT%"

for %%F in (*.mp4) do (
    echo Convertendo %%F...

    ffmpeg -i "%%F" -vn -c:a libvorbis -q:a 6 "%OUTPUT%\%%~nF.ogg"
)

echo.
echo Conversao concluida!
pause