@echo off
rem Script pour exécuter tous les tests en une seule fois

echo Lancement de tous les tests...
rem Affiche un message d'introduction

call lancer_tests_unitaires.bat
rem Appelle le script des tests unitaires
if errorlevel 1 exit /b 1
rem si une erreur est détectée (code retour >0), on arrête tout

call lancer_tests_api.bat
rem Appelle le script des tests API
if errorlevel 1 exit /b 1

call lancer_tests_ihm.bat
rem Appelle le script des tests IHM
if errorlevel 1 exit /b 1

echo Tous les tests se sont exécutés correctement.
pause
