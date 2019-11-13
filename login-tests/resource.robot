*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER_BASE}      https://cedar.metadatacenter.orgx
${LOGIN_BASE}       https://auth.metadatacenter.orgx/auth/realms/CEDAR/login-actions/authenticate
${BROWSER}          Chrome
${DELAY}            0.1 seconds
${VALID USER}       test1@test.com
${VALID PASSWORD}   test1

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${SERVER_BASE}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Log in to CEDAR

Input Username
    [Arguments]    ${username}
    Input Text    username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    password    ${password}

Submit Credentials
    Click Button    Log in

