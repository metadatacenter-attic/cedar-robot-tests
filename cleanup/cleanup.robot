*** Settings ***
Documentation     Create Resource.
#Suite Setup       Open Browser To Login Page
Test Setup        Open Browser To Login Page
Test Teardown     Close Browser
#Suite Teardown    Close Browser
Resource          ../lib/vars.robot
Resource          ../lib/login.robot
Resource          ../lib/keywords.robot
Resource          ../lib/workspace.robot
Resource          ../lib/workspace-remove.robot

*** Test Cases ***
Remove All Resources For User Should Succeed
    Login With User1
    Switch To List View

    Go To Workspace View
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
