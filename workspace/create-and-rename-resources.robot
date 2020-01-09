*** Settings ***
Documentation     Create Resource.
Resource          ../resource.robot
#Suite Setup       Open Browser To Login Page
Test Setup        Open Browser To Login Page
Test Teardown     Close Browser
#Suite Teardown    Close Browser

*** Test Cases ***
Create Field Should Succeed
    Login With User1
    ${fieldName}=  Create Field  SrcWrksp

Create Element Should Succeed
    Login With User1
    ${elementName}=  Create Element  SrcWrksp

Create Template Should Succeed
    Login With User1
    ${templateName}=  Create Template  SrcWrksp
    Set Global Variable  ${createdTemplateName}  ${templateName}

Create Instance Should Succeed
    Login With User1
    ${instanceName}=  Create Instance From  ${createdTemplateName}  SrcWrksp

Create Folder Should Succeed
    Login With User1
    ${folderName}=  Create Folder  SrcWrksp
