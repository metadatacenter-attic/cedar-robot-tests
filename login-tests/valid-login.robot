*** Settings ***
Documentation     Valid login test.
...
#Suite Setup       Open Browser To Login Page
Test Setup        Open Browser To Login Page
Test Teardown     Close Browser
#Suite Teardown    Close Browser
Resource          resource.robot

*** Test Cases ***
Login With Valid Credentials Should Succeed
    Login With Credentials  ${VALID USER}    ${VALID PASSWORD}

*** Keywords ***
Login With Credentials
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Succeed

Login Should Have Succeed
    Location Should Contain    ${SERVER_BASE}
    Wait Until Page Contains    Workspace
    Page Should Contain    Workspace