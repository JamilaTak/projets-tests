@echo off
rem Empêche d'afficher chaque commande exécutée dans le terminal

echo Lancement des tests unitaires...
rem Affiche ce message avant d'exécuter les tests unitaires

python -m unittest discover -v tests_unitaires
rem Lance tous les tests dans le dossier tests_unitaires avec détails (-v = verbose)
