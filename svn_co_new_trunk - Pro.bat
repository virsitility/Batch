:: 17' 0417 rev 3 by csc
:: - �ק��睊����~��s
:: - ���ç���űM�׮ɿ��~�T��
:: 16' 1221 rev 2 by csc
:: - �ק������i�~��checkout����C��
:: - �[�J��srepo�\��
:: - �Ĥ@���إ߸�Ƨ�������i��W�٫��[������(ex.�s�� [����])

@ECHO off
:: ��Jcheckout�̤j��
:: set /p lastNum=Please enter the last number:
SETLOCAL EnableDelayedExpansion
FOR /l %%N IN (1,1,100) DO (
	SET "n=00000%%N"
	SET "NUM=!n:~-5!
	:: ==�إ߱M��==
	:: 2>nul ���ÿ��~�T��
	IF NOT EXIST PSS-ON-!NUM!* 2>nul (
		:: �إߪŬ[�c
		:: svn co http://playstar.no-ip.biz:8081/svn/game/PSS-ON-!NUM!/trunk --depth empty PSS-ON-!NUM!
		svn ls --depth empty "http://playstar.no-ip.biz:8081/svn/game/PSS-ON-!NUM!/trunk"
		:: �Y svn ls �L���~���ͫh checkout �U��
		IF !ERRORLEVEL! == 0 (
			ECHO �U���s�M�� PSS-ON-!NUM! ...
			svn co -q http://playstar.no-ip.biz:8081/svn/game/PSS-ON-!NUM!/trunk PSS-ON-!NUM!
			)
	) ELSE 2>nul ( REM 2>nul ���ÿ��~�T��
		:: ==��s�M��==
		:: ��̷s����
		for /f "tokens=2" %%i in ('svn info -rHEAD PSS-ON-!NUM!*^|find "Revision"') do SET HEAD=%%i
		:: ��{�s����
		for /f "tokens=2" %%i in ('svn info -rBASE PSS-ON-!NUM!*^|find "Revision"') do SET BASE=%%i
		:: �Y�������P�h��s
		IF !BASE! NEQ !HEAD! (
			ECHO ��s PSS-ON-!NUM! ��...
			svn up -q PSS-ON-!NUM!*
		) ELSE (
			ECHO PSS-ON-!NUM! �w�O�̷s�����C
		)
	)
)
GOTO :END

:ERROR
ECHO ERROR !!
PAUSE

:END
ECHO.
ECHO ===��s����===
pause