*** Settings ***
Documentation     Valid login test.
...
#Suite Setup       Open Browser To Login Page
Test Setup        Open Browser To Login Page
Test Teardown     Close Browser
#Suite Teardown    Close Browser
Resource          ../resource.robot

*** Test Cases ***
Login With Valid Credentials Should Succeed
    Login With User1