:: 17' 0417 rev 3 by csc
:: - 修改比對版號後才更新
:: - 隱藏抓取空專案時錯誤訊息
:: 16' 1221 rev 2 by csc
:: - 修改跳號後可繼續checkout後續遊戲
:: - 加入更新repo功能
:: - 第一次建立資料夾完成後可於名稱後方加註說明(ex.編號 [註解])

@ECHO off
:: 輸入checkout最大值
:: set /p lastNum=Please enter the last number:
SETLOCAL EnableDelayedExpansion
FOR /l %%N IN (1,1,100) DO (
	SET "n=00000%%N"
	SET "NUM=!n:~-5!
	:: ==建立專案==
	:: 2>nul 隱藏錯誤訊息
	IF NOT EXIST PSS-ON-!NUM!* 2>nul (
		:: 建立空架構
		:: svn co http://playstar.no-ip.biz:8081/svn/game/PSS-ON-!NUM!/trunk --depth empty PSS-ON-!NUM!
		svn ls --depth empty "http://playstar.no-ip.biz:8081/svn/game/PSS-ON-!NUM!/trunk"
		:: 若 svn ls 無錯誤產生則 checkout 下來
		IF !ERRORLEVEL! == 0 (
			ECHO 下載新專案 PSS-ON-!NUM! ...
			svn co -q http://playstar.no-ip.biz:8081/svn/game/PSS-ON-!NUM!/trunk PSS-ON-!NUM!
			)
	) ELSE 2>nul ( REM 2>nul 隱藏錯誤訊息
		:: ==更新專案==
		:: 抓最新版號
		for /f "tokens=2" %%i in ('svn info -rHEAD PSS-ON-!NUM!*^|find "Revision"') do SET HEAD=%%i
		:: 抓現存版號
		for /f "tokens=2" %%i in ('svn info -rBASE PSS-ON-!NUM!*^|find "Revision"') do SET BASE=%%i
		:: 若版號不同則更新
		IF !BASE! NEQ !HEAD! (
			ECHO 更新 PSS-ON-!NUM! 中...
			svn up -q PSS-ON-!NUM!*
		) ELSE (
			ECHO PSS-ON-!NUM! 已是最新版本。
		)
	)
)
GOTO :END

:ERROR
ECHO ERROR !!
PAUSE

:END
ECHO.
ECHO ===更新完畢===
pause