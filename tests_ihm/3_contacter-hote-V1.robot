*** Settings ***
Library    Selenium2Library
Resource    commun-V1.resource
Test Setup       Préparer Le Test Contacter L'Hôte
Test Teardown    Fermer Le Navigateur

*** Test Cases ***
#1er Test     OKKKKK !!!!!
La Modale Contacter L'Hôte Doit S'Afficher Avec Tous Ses Champs Depuis La Colonne Latérale
    Ouvrir La Modale Contacter L'Hôte Depuis La Colonne Latérale
    Vérifier Que La Modale Contacter L'Hôte Est Complète

#2ème Test    OKKKKK !!!!!
La Modale Contacter L'Hôte Doit S'Afficher Depuis La Section Hébergeur
    Ouvrir La Modale Contacter L'Hôte Depuis La Section Hébergeur
    Vérifier Que La Modale Contacter L'Hôte Est Complète

#3ème Test
Les Champs Du Formulaire Contacter L'Hôte Doivent Conserver Les Valeurs Saisies
    Ouvrir La Modale Contacter L'Hôte Depuis La Colonne Latérale
    Remplir Le Formulaire De Contact Complet
    Vérifier Que Les Valeurs Saisies Sont Conservées

#4ème Test    OKKKKK !!!!!
Un Message De Retour Doit Etre Affiché Après L'Envoi D'Un Formulaire Complet
    Ouvrir La Modale Contacter L'Hôte Depuis La Colonne Latérale
    Remplir Le Formulaire De Contact Complet
    Soumettre Le Formulaire De Contact
    Vérifier Qu'Un Message De Retour Est Affiché

#5ème Test    OKKKKK !!!!!
La Modale Contacter L'Hôte Doit Se Fermer Avec Le Bouton De Fermeture
    Ouvrir La Modale Contacter L'Hôte Depuis La Colonne Latérale
    Fermer La Modale Contacter L'Hôte
    Vérifier Que La Modale Contacter L'Hôte Est Fermée

*** Keywords ***
Préparer Le Test Contacter L'Hôte
    Ouvrir Le Navigateur Et Accéder A L'Application
    Accéder A La Fiche Du Logement

Vérifier Que La Modale Contacter L'Hôte Est Complète
    Element Should Be Visible    ${MODALE CONTACT HOTE}
    Element Text Should Be    ${TITRE MODALE CONTACT HOTE}    ${TEXTE TITRE MODALE CONTACT}
    Element Should Be Visible    ${CHAMP CONTACT NOM}
    Element Should Be Visible    ${CHAMP CONTACT EMAIL}
    Element Should Be Visible    ${CHAMP CONTACT TELEPHONE}
    Element Should Be Visible    ${CHAMP CONTACT MESSAGE}
    Element Should Be Visible    ${BOUTON SOUMETTRE CONTACT}

Vérifier Que Les Valeurs Saisies Sont Conservées
    Textfield Value Should Be    ${CHAMP CONTACT NOM}    ${CONTACT NOM}
    Textfield Value Should Be    ${CHAMP CONTACT EMAIL}    ${CONTACT EMAIL}
    Textfield Value Should Be    ${CHAMP CONTACT TELEPHONE}    ${CONTACT TELEPHONE}
    Textarea Value Should Be    ${CHAMP CONTACT MESSAGE}    ${CONTACT MESSAGE}

Vérifier Qu'Un Message De Retour Est Affiché
    # Le texte exact du message n'étant présent dans aucun fichier fourni,
    # on vérifie uniquement que la zone de retour contient du texte.
    Wait Until Keyword Succeeds    10s    1s    La Zone De Message Contact Doit Contenir Du Texte

La Zone De Message Contact Doit Contenir Du Texte
    ${texte}=    Get Text    ${ZONE MESSAGE CONTACT}
    Should Not Be Empty    ${texte}

Vérifier Que La Modale Contacter L'Hôte Est Fermée
    Wait Until Element Is Not Visible    ${MODALE CONTACT HOTE}    timeout=10s
