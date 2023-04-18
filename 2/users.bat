@echo off
Title User Creation
chcp 1250
SETLOCAL EnableDelayedExpansion

cd /d %~dp0
net session
set d=Š Ž ? ? ? š ž ? ? ? Á Â Ä Ç ? É Ë ? Í Î Ó Ô Ö Ú Ü ? Ý á â ä ç ? é ë ? í î ó ô ö ú ü ? ý
set b=S Z R N T s z r n t A A A C C E E E I I O O O U U U Y a a a c c e e e i i o o o u u u y
set /a x=0
for %%a in (%d%) do (
set d[!x!]=%%a
set /a x=!x!+1
)
set /a x=0
for %%a in (%b%) do (
set b[!x!]=%%a
set /a x=!x!+1
)
set /a x=%x%-1
:a
echo !d[%x%]!=!b[%x%]!>>pravidlo_diakr.txt
set /a x=!x!-1
if !x! GEQ 0 goto a
set v=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
set m=a b c d e f g h i j k l m n o p q r s t u v w x y z
set /a x=0
for %%a in (%v%) do (
set v[!x!]=%%a
set /a x=!x!+1
)
set /a x=0
for %%a in (%m%) do (
set m[!x!]=%%a
set /a x=!x!+1
)
set /a x=%x%-1
:b
echo !v[%x%]!=!m[%x%]!>>NaMala.txt
echo !m[%x%]!=!v[%x%]!>>NaVelka.txt
set /a x=!x!-1
if !x! GEQ 0 goto b
for /f "eol=# skip=1 delims=; tokens=1,2,3,4,5" %%a in (studenti.txt) do (
call :conversion %%a
set Prijmeni=!slovo!
call :conversion %%b
set Jmeno=!slovo!
net user !Jmeno!.!Prijmeni! /delete
net localgroup %%c /delete
)
net localgroup IT /delete
net localgroup ELE /delete
net localgroup MUZ /delete
net localgroup ZENA /delete
net localgroup IT /add
net localgroup ELE /add
net localgroup MUZ /add
net localgroup ZENA /add
echo. >log.txt
date /t >>log.txt
time /t >>log.txt
echo. >>log.txt
for /f "skip=1 delims=; tokens=1,2,3,4,5" %%a in (studenti.txt) do (
echo ----------------- >> log.txt
echo %%a %%b >> log.txt
echo ----------------- >> log.txt
echo. >> log.txt
set datum=%%c
set datum=!datum:~1,1!
set /a datum=4-!datum!
set /a datum=!date:~-4!+!datum!+1
set datum=31/8/!datum!
call :conversion %%a
set Prijmeni=!slovo!
call :conversion %%b
set Jmeno=!slovo!
echo Vytvoreni uctu >> log.txt
net user !Jmeno!.!Prijmeni! !Prijmeni!Q12020^^^! /add /logonpasswordchg:yes /countrycode:044 /expires:!!datum! /fullname:"%%a %%b" /y >> log.txt
set trida=%%c
set obor=!trida:~0,1!
echo skupiny oboru >> log.txt
if /i !obor!==E net localgroup ELE !Jmeno!.!Prijmeni! /add >> log.txt
if /i !obor!==T net localgroup IT !Jmeno!.!Prijmeni! /add >> log.txt
echo skupiny trid >> log.txt
net localgroup | find "%%c"
if !errorlevel! NEQ 0 net localgroup %%c /add
net localgroup %%c !Jmeno!.!Prijmeni! /add >> log.txt
set pohlavi=%%e
set pohlavi=!pohlavi:~0,1!
set pohlavi=!pohlavi:Ž=Z!
echo skupiny pohlavi >> log.txt
if /i !pohlavi!==M net localgroup MUZ !Jmeno!.!Prijmeni! /add >> log.txt
if /i !pohlavi!==Z net localgroup ZENA !Jmeno!.!Prijmeni! /add >> log.txt
echo. >> log.txt
net user !Jmeno!.!Prijmeni! >> log.txt
)
:end
pause
del "pravidlo_diakr.txt"
del "NaMala.txt"
del "NaVelka.txt"
exit /b
:conversion
set retezec=%~1 %~2
for /f "tokens=1" %%a in (pravidlo_diakr.txt) do (
set retezec=!retezec:%%a!
)
for /f "tokens=1,2" %%a in ("%retezec%") do (
set slov=%%a
set druhe=%%b
)
set zby=%slov:~1%
set pr=%slov:~0,1%
for /f "tokens=1" %%a in (NaMala.txt) do (
set zby=!zby:%%a!
)
for /f "tokens=1" %%a in (NaVelka.txt) do (
set pr=!pr:%%a!
)
set slovo=%pr%%zby%
IF [%druhe%] == [] GOTO complete
set zby=%druhe:~1%
set pr=%druhe:~0,1%
for /f "tokens=1" %%a in (NaMala.txt) do (
set zby=!zby:%%a!
)
for /f "tokens=1" %%a in (NaVelka.txt) do (
set pr=!pr:%%a!
)
set slovo=%slovo%%pr%%zby%
:complete
exit /b
