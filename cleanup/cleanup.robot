*** Settings ***
Documentation     Create Resource.
Resource          ../resource.robot
#Suite Setup       Open Browser To Login Page
Test Setup        Open Browser To Login Page
Test Teardown     Close Browser
#Suite Teardown    Close Browser

*** Test Cases ***
#Reset User Preferences Should Succeed
    #Login With Credentials  ${VALID USER}    ${VALID PASSWORD}
    #Init User Preferences

Remove All Resources For User Should Succeed
    Login With Credentials  ${VALID USER}    ${VALID PASSWORD}
    Go To Workspace View
    Switch To List View
    Remove All Resources By Search  ${resourceTypeFolder}  SrcWrksp
    Go To Workspace View
    Remove All Resources By Search  ${resourceTypeField}  SrcWrksp
    Go To Workspace View
    Remove All Resources By Search  ${resourceTypeElement}  SrcWrksp
    Go To Workspace View
    Remove All Resources By Search  ${resourceTypeTemplate}  SrcWrksp

*** Keywords ***

