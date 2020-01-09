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
    Switch ResourceType Filters  False  False  False  False
    Remove All Resources By Search  ${resourceTypeFolder}  SrcWrksp
    Go To Workspace View
    Switch ResourceType Filters  False  False  True  False
    Remove All Resources By Search  ${resourceTypeField}  SrcWrksp
    Go To Workspace View
    Switch ResourceType Filters  False  True  False  False
    Remove All Resources By Search  ${resourceTypeElement}  SrcWrksp
    Go To Workspace View
    Switch ResourceType Filters  False  False  False  True
    Remove All Resources By Search  ${resourceTypeInstance}  SrcWrksp
    Go To Workspace View
    Switch ResourceType Filters  True  False  False  False
    Remove All Resources By Search  ${resourceTypeTemplate}  SrcWrksp
    Switch ResourceType Filters  True  True  True  True

*** Keywords ***

