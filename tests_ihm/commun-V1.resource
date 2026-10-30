*** Settings ***
Library    Selenium2Library
#Suite Setup    MOTCLE 1
#Suite Teardown   MOTCLE 2

*** Variables ***
${SERVEUR}         livraison3.testacademy.fr
${HOMEY URL}      http://${SERVEUR}/
${NAVIGATEUR}    chrome 
#option ouverture du navigateur -> empeche pop-up mot de passe de s'ouvrir sinon test echoue
${OPTIONS}    add_experimental_option("prefs", {"credentials_enable_service": False, "profile.password_manager_enabled": False, "profile.password_manager_leak_detection": False}); add_argument("--disable-features=PasswordLeakDetection")
${LIEN SE CONNECTER}    xpath=//a[contains(text(),'Se connecter')]
${CHAMP NOM UTILISATEUR}    name=username 
${CHAMP MOT DE PASSE}    name=password
${UTILISATEUR VALIDE}    robot 
${MOT DE PASSE VALIDE}    robot 
${BOUTON SE CONNECTER}    css=.homey_login_button
${TITRE TABLEAU DE BORD}    Tableau de bord - Livraison 3
${ZONE ERREUR}    css=#modal-login .error

# ---------------------------------------------------------------
# Contacter l'hôte : page cible (présente dans page_listing.html / form_contact.html)
# ---------------------------------------------------------------
${URL FICHE LOGEMENT}    ${HOMEY URL}index.php/listing/jta-maroc-12/
${TITRE FICHE LOGEMENT}    JTA Maroc 12 - Livraison 3

# Locators issus du fichier .side (parcours de recherche, conservés pour référence)
${BOUTON CHERCHER}    css=.search-button > .btn-primary:nth-child(1)
${LIEN ANNONCE JTA MAROC 12}    css=.item-wrap:nth-child(6) .hover-effect
${BOUTON CONTACTER HOTE SIDE}    css=.btn-full-width:nth-child(2)

# Locators "Contacter l'hôte" (HTML + .side)
${BOUTON CONTACTER HOTE SIDEBAR}    css=button.btn-full-width[data-target='#modal-contact-host']
${LIEN CONTACTER HOTE SECTION}    css=#host-section a[data-target='#modal-contact-host']
${MODALE CONTACT HOTE}    id=modal-contact-host
${TITRE MODALE CONTACT HOTE}    css=#modal-contact-host .modal-title
${CHAMP CONTACT NOM}    css=#modal-contact-host input[name='name']
${CHAMP CONTACT EMAIL}    css=#modal-contact-host input[name='email']
${CHAMP CONTACT TELEPHONE}    css=#modal-contact-host input[name='phone']
${CHAMP CONTACT MESSAGE}    css=#modal-contact-host textarea[name='message']
${BOUTON SOUMETTRE CONTACT}    css=#modal-contact-host .contact_listing_host
${BOUTON FERMER MODALE CONTACT}    css=#modal-contact-host button.close
${ZONE MESSAGE CONTACT}    css=#modal-contact-host .homey_contact_messages

# Données de test (reprises du .side)
${TEXTE TITRE MODALE CONTACT}    Contactez l'hôte
${CONTACT NOM}    Jamila
${CONTACT EMAIL}    jamila@test.com
${CONTACT TELEPHONE}    0601020304
${CONTACT MESSAGE}    Ceci est un test de Jamila

*** Keywords ***
Ouvrir Le Navigateur Et Accéder A L'Application
    Open Browser    browser=${NAVIGATEUR}    options=${OPTIONS}
    Maximize Browser Window
    Go To     ${HOMEY URL}

Accéder A LA Page De Connexion
    Click Element    ${LIEN SE CONNECTER}

Saisir Le Nom D'Utilisateur
    [Arguments]    ${utilisateur valide}
    Wait Until Element Is Visible    ${CHAMP NOM UTILISATEUR}
    Click Element    ${CHAMP NOM UTILISATEUR}
    Input Text    ${CHAMP NOM UTILISATEUR}    ${utilisateur valide}

Saisir Le Mot De Passe
    [Arguments]    ${mot de passe valide}
    Wait Until Element Is Visible    ${CHAMP MOT DE PASSE}
    Click Element    ${CHAMP MOT DE PASSE}
    Input Text    ${CHAMP MOT DE PASSE}    ${mot de passe valide}

Soumettre Le Formulaire De Connexion
    Click Button    ${BOUTON SE CONNECTER}

# ---------------------------------------------------------------
# Contacter l'hôte
# ---------------------------------------------------------------
Accéder A La Fiche Du Logement
    Go To    ${URL FICHE LOGEMENT}
    Title Should Be    ${TITRE FICHE LOGEMENT}

Ouvrir La Modale Contacter L'Hôte Depuis La Colonne Latérale
    Wait Until Element Is Visible    ${BOUTON CONTACTER HOTE SIDEBAR}    timeout=10s
    Click Button    ${BOUTON CONTACTER HOTE SIDEBAR}
    Wait Until Element Is Visible    ${MODALE CONTACT HOTE}    timeout=10s

Ouvrir La Modale Contacter L'Hôte Depuis La Section Hébergeur
    Scroll Element Into View    ${LIEN CONTACTER HOTE SECTION}
    Wait Until Element Is Visible    ${LIEN CONTACTER HOTE SECTION}    timeout=10s
    Click Element    ${LIEN CONTACTER HOTE SECTION}
    Wait Until Element Is Visible    ${MODALE CONTACT HOTE}    timeout=10s

Saisir Le Nom Du Contact
    [Arguments]    ${nom}
    Wait Until Element Is Visible    ${CHAMP CONTACT NOM}
    Click Element    ${CHAMP CONTACT NOM}
    Input Text    ${CHAMP CONTACT NOM}    ${nom}

Saisir L'Email Du Contact
    [Arguments]    ${email}
    Wait Until Element Is Visible    ${CHAMP CONTACT EMAIL}
    Click Element    ${CHAMP CONTACT EMAIL}
    Input Text    ${CHAMP CONTACT EMAIL}    ${email}

Saisir Le Téléphone Du Contact
    [Arguments]    ${telephone}
    Wait Until Element Is Visible    ${CHAMP CONTACT TELEPHONE}
    Click Element    ${CHAMP CONTACT TELEPHONE}
    Input Text    ${CHAMP CONTACT TELEPHONE}    ${telephone}

Saisir Le Message Du Contact
    [Arguments]    ${message}
    Wait Until Element Is Visible    ${CHAMP CONTACT MESSAGE}
    Click Element    ${CHAMP CONTACT MESSAGE}
    Input Text    ${CHAMP CONTACT MESSAGE}    ${message}

Remplir Le Formulaire De Contact Complet
    Saisir Le Nom Du Contact    ${CONTACT NOM}
    Saisir L'Email Du Contact    ${CONTACT EMAIL}
    Saisir Le Téléphone Du Contact    ${CONTACT TELEPHONE}
    Saisir Le Message Du Contact    ${CONTACT MESSAGE}

Soumettre Le Formulaire De Contact
    Wait Until Element Is Visible    ${BOUTON SOUMETTRE CONTACT}
    Click Button    ${BOUTON SOUMETTRE CONTACT}

Fermer La Modale Contacter L'Hôte
    Click Button    ${BOUTON FERMER MODALE CONTACT}

Fermer Le Navigateur
    Close All Browsers
