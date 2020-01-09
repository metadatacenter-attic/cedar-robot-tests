*** Settings ***
Documentation     Several invalid login tests.
...
#Suite Setup       Open Browser To Login Page
Test Setup        Open Browser To Login Page
Test Template     Login With Invalid Credentials Should Fail
Test Teardown     Close Browser
#Suite Teardown    Close Browser
Resource          ../lib/vars.robot
Resource          ../lib/login.robot

*** Test Cases ***               USER NAME        PASSWORD
Invalid Username                 invalid          ${VALID PASSWORD 1}
Invalid Password                 ${VALID USER 1}  invalid
Invalid Username And Password    invalid          whatever
Empty Username                   ${EMPTY}         ${VALID PASSWORD 1}
Empty Password                   ${VALID USER 1}  ${EMPTY}
Empty Username And Password      ${EMPTY}         ${EMPTY}

*** Keywords ***
Login With Invalid Credentials Should Fail
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Failed