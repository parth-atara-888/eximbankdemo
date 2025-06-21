run_precompute.bat file 
 
@echo off
REM Activate virtual environment and run Python script
 
REM Set the path to the virtual environment Python executable
set VENV_PYTHON=C:\effiya\root\non-web\name_screenig_ai_service_venv\Scripts\python.exe
 
REM Set the path to the script
set SCRIPT_PATH=C:\effiya\root\web\apps\ai_precompute\precomputation-populator\main.py
 
REM Run the script
"%VENV_PYTHON%" "%SCRIPT_PATH%"
 
REM Pause to keep the console window open if needed
REM pause