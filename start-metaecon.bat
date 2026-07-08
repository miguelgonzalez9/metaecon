@echo off
rem Double-click launcher for MetaEcon: serves the app locally and opens the browser.
rem Uses port 8877 bound to 127.0.0.1 (port 8000 is often taken by other tools).
rem Live OpenAlex search + Claude extraction work in this mode (they are blocked
rem on the hosted artifact page).
cd /d "%~dp0"
start "" http://127.0.0.1:8877/
python -m http.server 8877 --bind 127.0.0.1
if errorlevel 1 (
  echo.
  echo MetaEcon could not start. Usual causes:
  echo  - Python is not installed / not on PATH  -^> install from python.org
  echo  - Port 8877 is already in use            -^> close the other MetaEcon window
  pause
)
