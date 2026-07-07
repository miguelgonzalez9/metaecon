@echo off
rem Double-click launcher for MetaEcon: serves the app locally and opens the browser.
rem Live OpenAlex search + Claude extraction work in this mode (they are blocked on
rem the hosted artifact page).
cd /d "%~dp0"
start "" http://localhost:8000/
python -m http.server 8000
