@ECHO off
REM :: 1221 rev 2 csc
REM :: - 修改跳號後可繼續建立後續遊戲
REM :: - 加入更新功能
REM :: - 第一次建立資料夾完成後可於名稱後方加註說明

REM :: 輸入checkout最大值
REM :: set /p lastNum=Please enter the last number:
SETLOCAL EnableDelayedExpansion
FOR /l %%N IN (1,1,100) DO (
	SET "n=00000%%N"
	SET "NUM=!n:~-5!
REM	:: 建立專案
	IF NOT EXIST PSS-ON-!NUM!* (
REM ::	建立空架構
REM ::	svn co http://playstar.no-ip.biz:8081/svn/game/PSS-ON-!NUM!/trunk --depth empty PSS-ON-!NUM!
	svn co http://playstar.no-ip.biz:8081/svn/game/PSS-ON-!NUM!/trunk PSS-ON-!NUM!
  ) else (
REM	:: 更新專案
	svn up dir PSS-ON-!NUM!*
  )
)
GOTO :END

:ERROR
ECHO ERROR !!
PAUSE

:END
pause