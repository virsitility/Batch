@ECHO off
REM :: 1221 rev 2 csc
REM :: - �ק������i�~��إ߫���C��
REM :: - �[�J��s�\��
REM :: - �Ĥ@���إ߸�Ƨ�������i��W�٫��[������

REM :: ��Jcheckout�̤j��
REM :: set /p lastNum=Please enter the last number:
SETLOCAL EnableDelayedExpansion
FOR /l %%N IN (1,1,100) DO (
	SET "n=00000%%N"
	SET "NUM=!n:~-5!
REM	:: �إ߱M��
	IF NOT EXIST PSS-ON-!NUM!* (
REM ::	�إߪŬ[�c
REM ::	svn co http://playstar.no-ip.biz:8081/svn/game/PSS-ON-!NUM!/trunk --depth empty PSS-ON-!NUM!
	svn co http://playstar.no-ip.biz:8081/svn/game/PSS-ON-!NUM!/trunk PSS-ON-!NUM!
  ) else (
REM	:: ��s�M��
	svn up dir PSS-ON-!NUM!*
  )
)
GOTO :END

:ERROR
ECHO ERROR !!
PAUSE

:END
pause