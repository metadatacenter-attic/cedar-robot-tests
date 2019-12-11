*** Settings ***
Documentation     Several invalid login tests.
...
#Suite Setup       Open Browser To Login Page
Test Setup        Open Browser To Login Page
Test Template     Login With Invalid Credentials Should Fail
Test Teardown     Close Browser
#Suite Teardown    Close Browser
Resource          ../resource.robot

*** Test Cases ***               USER NAME        PASSWORD
Invalid Username                 invalid          ${VALID PASSWORD}
Invalid Password                 ${VALID USER}    invalid
Invalid Username And Password    invalid          whatever
Empty Username                   ${EMPTY}         ${VALID PASSWORD}
Empty Password                   ${VALID USER}    ${EMPTY}
Empty Username And Password      ${EMPTY}         ${EMPTY}

*** Keywords ***
Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Failed