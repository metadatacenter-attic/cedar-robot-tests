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
Resource          ../lib/workspace-create.robot

*** Test Cases ***
Create Field Should Succeed
    Login With User1
    ${fieldName}=  Create Field  SrcWrksp
    Go Back To Workspace
    Rename Resource Using Context Menu  ${fieldName}  SrcWrkspRenamed

Create Element Should Succeed
    Login With User1
    ${elementName}=  Create Element  SrcWrksp
    Go Back To Workspace
    Rename Resource Using Context Menu  ${elementName}  SrcWrkspRenamed

Create Template Should Succeed
    Login With User1
    ${templateName}=  Create Template  SrcWrksp
    Go Back To Workspace
    ${newTemplateName}=  Rename Resource Using Context Menu  ${templateName}  SrcWrkspRenamed
    Set Global Variable  ${createdTemplateName}  ${newTemplateName}

Create Instance Should Succeed
    Login With User1
    ${instanceName}=  Create Instance From  ${createdTemplateName}  SrcWrksp
    Go Back To Workspace
    Rename Resource Using Context Menu  ${instanceName}  SrcWrkspRenamed metadata

Create Folder Should Succeed
    Login With User1
    ${folderName}=  Create Folder  SrcWrksp
    Rename Resource Using Context Menu  ${folderName}  SrcWrkspRenamed
