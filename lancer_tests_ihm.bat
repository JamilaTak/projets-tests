@echo off
rem Cache l'affichage des commandes dans le terminal

echo Lancement des tests IHM...
rem Affiche ce message avant d'exécuter les tests IHM

robot tests_ihm
pause
rem rem Lance tous les tests dans le dossier tests_ihm