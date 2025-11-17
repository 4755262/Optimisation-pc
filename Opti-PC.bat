@echo off
echo ================================================
echo   Script de Nettoyage et Optimisation PC discord : 4755262 
echo ================================================
echo.

REM Vérification des droits administrateur
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Ce script necessite les droits administrateur.
    echo Faites un clic droit et selectionnez "Executer en tant qu'administrateur"
    pause
    exit
)

echo Nettoyage en cours... Veuillez patienter.
echo.

REM Nettoyage du dossier Temp utilisateur
echo [1/8] Nettoyage de %TEMP%...
del /f /s /q "%TEMP%\*" >nul 2>&1
for /d %%p in ("%TEMP%\*") do rmdir "%%p" /s /q >nul 2>&1

REM Nettoyage du dossier Temp Windows
echo [2/8] Nettoyage de C:\Windows\Temp...
del /f /s /q "C:\Windows\Temp\*" >nul 2>&1
for /d %%p in ("C:\Windows\Temp\*") do rmdir "%%p" /s /q >nul 2>&1

REM Nettoyage du dossier Prefetch
echo [3/8] Nettoyage des fichiers Prefetch...
del /f /s /q "C:\Windows\Prefetch\*" >nul 2>&1

REM Nettoyage de la corbeille
echo [4/8] Vidage de la corbeille...
rd /s /q %systemdrive%\$Recycle.bin >nul 2>&1

REM Nettoyage des fichiers temporaires d'Internet Explorer
echo [5/8] Nettoyage du cache Internet Explorer...
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8 >nul 2>&1

REM Nettoyage des logs Windows
echo [6/8] Nettoyage des logs Windows...
del /f /s /q "C:\Windows\Logs\*" >nul 2>&1
for /d %%p in ("C:\Windows\Logs\*") do rmdir "%%p" /s /q >nul 2>&1

REM Nettoyage des fichiers de mise à jour Windows
echo [7/8] Nettoyage des anciens fichiers de mise a jour...
dism /online /Cleanup-Image /StartComponentCleanup >nul 2>&1

REM Nettoyage avec l'outil Windows (cleanmgr)
echo [8/15] Lancement du nettoyage de disque Windows...
cleanmgr /sagerun:1 >nul 2>&1

REM Nettoyage du cache DNS
echo [9/15] Nettoyage du cache DNS...
ipconfig /flushdns >nul 2>&1

REM Nettoyage du cache des miniatures
echo [10/15] Nettoyage du cache des miniatures...
del /f /s /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1

REM Nettoyage des fichiers de rapport d'erreurs Windows
echo [11/15] Suppression des rapports d'erreurs...
del /f /s /q "C:\ProgramData\Microsoft\Windows\WER\*" >nul 2>&1
for /d %%p in ("C:\ProgramData\Microsoft\Windows\WER\*") do rmdir "%%p" /s /q >nul 2>&1

REM Nettoyage du dossier de distribution Windows Update
echo [12/15] Nettoyage des fichiers Windows Update...
net stop wuauserv >nul 2>&1
del /f /s /q "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%p in ("C:\Windows\SoftwareDistribution\Download\*") do rmdir "%%p" /s /q >nul 2>&1
net start wuauserv >nul 2>&1

REM Nettoyage des logs d'événements
echo [13/15] Nettoyage des logs d'evenements...
for /f "tokens=*" %%G in ('wevtutil el') do wevtutil cl "%%G" >nul 2>&1

REM Désactivation des services inutiles temporairement
echo [14/15] Optimisation des services...
sc config "SysMain" start=disabled >nul 2>&1
net stop "SysMain" >nul 2>&1

REM Optimisation de la mémoire
echo [15/15] Liberation de la memoire RAM...
%windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks >nul 2>&1

echo.
echo ================================================
echo   Nettoyage et Optimisation termine avec succes!
echo ================================================
echo.
echo Espace libere et performances ameliorees :
echo - Fichiers temporaires supprimes
echo - Cache DNS vide
echo - Memoire RAM optimisee
echo - Services inutiles desactives (SuperFetch/SysMain)
echo - Rapports d'erreurs supprimes
echo.
echo Redemarrage recommande pour appliquer tous les changements.
echo.
pause