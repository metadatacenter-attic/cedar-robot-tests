*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${SERVER_BASE}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    ${keycloakLoginPageTitle}

Input Username
    [Arguments]    ${username}
    Input Text    ${keycloakLoginFormUsernameName}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${keycloakLoginFormPasswordName}    ${password}

Submit Credentials
    Click Button    ${keycloakLoginFormLoginButtonId}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Succeed

Login With User1
    Login With Credentials  ${VALID USER 1}    ${VALID PASSWORD 1}

Login Should Have Succeed
    Location Should Contain    ${SERVER_BASE}
    Wait Until Element Is Visible  ${leftMenuWorkspaceLinkXpath}
    Element Should Be Visible    ${leftMenuWorkspaceLinkXpath}

Login Should Have Failed
    Location Should Contain    ${LOGIN_BASE}
    Wait Until Element Is Visible    ${keycloakLoginFormFeedbackTextXpath}
    Page Should Contain    ${keycloakLoginPageLoginErrorText}
