*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER_BASE}      https://cedar.metadatacenter.orgx
${LOGIN_BASE}       https://auth.metadatacenter.orgx/auth/realms/CEDAR/login-actions/authenticate
${BROWSER}          Chrome
${DELAY}            0 seconds
${VALID USER}       test1@test.com
${VALID PASSWORD}   test1

${defaultTitle}     TestTitle
${defaultDescription}  TestDescription

${resourceTypeElement}  element
${resourceTypeField}  field
${resourceTypeTemplate}  template
${resourceTypeFolder}  folder

${toastyCloseButtonCss}  .toast .close-button
${toastySuccessCss}  .toast.toasty-type-success

${folderCreateDialogSaveXpath}  //*[@id="new-folder-modal"]//button[contains(@class, 'btn-save')]

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${SERVER_BASE}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    Log in to CEDAR

Input Username
    [Arguments]    ${username}
    Input Text    name:username    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    name:password    ${password}

Submit Credentials
    Click Button    Log in

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

Login Should Have Failed
    Location Should Contain    ${LOGIN_BASE}
    Wait Until Page Contains    CEDAR
    Page Should Contain    Invalid username or password.

Create Field
    [Arguments]    ${name}
    ${fieldTitle}=  Create Test Resource Title  ${name}
    ${fieldDescription}=  Create Test Resource Description  ${name}
    Create Resource  ${resourceTypeField}  ${fieldTitle}  ${fieldDescription}

Create Element
    [Arguments]    ${name}
    ${elementTitle}=  Create Test Resource Title  ${name}
    ${elementDescription}=  Create Test Resource Description  ${name}
    Create Resource  ${resourceTypeElement}  ${elementTitle}  ${elementDescription}

Create Template
    [Arguments]    ${name}
    ${templateTitle}=  Create Test Resource Title  ${name}
    ${templateDescription}=  Create Test Resource Description  ${name}
    Create Resource  ${resourceTypeTemplate}  ${templateTitle}  ${templateDescription}

Create Folder
    [Arguments]    ${name}
    ${folderTitle}=  Create Test Resource Title  ${name}
    ${folderDescription}=  Create Test Resource Description  ${name}
    Create Resource  ${resourceTypeFolder}  ${folderTitle}  ${folderDescription}

Create Test Resource Title
    [Arguments]    ${name}
    ${RandomInt}=  Evaluate  random.randint(1,9999999999)  modules=random
    ${ret}=  Catenate  ${defaultTitle}  ${name}  ${RandomInt}
    [return]  ${ret}

Create Test Resource Description
    [Arguments]    ${name}
    ${RandomInt}=  Evaluate  random.randint(1,9999999999)  modules=random
    ${ret}=  Catenate  ${defaultDescription}  ${name}  ${RandomInt}
    [return]  ${ret}

Create Resource
    [Arguments]    ${type}  ${title}  ${description}
    Run Keyword If  '${type}'=='folder'  Create Folder Resource  ${type}  ${title}
    Run Keyword If  '${type}'!='folder'  Create Nonfolder Resource  ${type}  ${title}  ${description}

Get Artifact Create Button Id
    [Arguments]    ${type}
    ${ret}=  Catenate  SEPARATOR=  button-create-  ${type}
    [return]  ${ret}

Get Artifact Title Input Id
    [Arguments]    ${type}
    ${ret}=  Catenate  SEPARATOR=  ${type}  -name
    [return]  ${ret}

Get Artifact Description Input Id
    [Arguments]    ${type}
    ${ret}=  Catenate  SEPARATOR=  ${type}  -description
    [return]  ${ret}

Get Artifact Save Button Id
    [Arguments]    ${type}
    ${ret}=  Catenate  SEPARATOR=  button-save-  ${type}
    [return]  ${ret}

Create Nonfolder Resource
    [Arguments]    ${type}  ${title}  ${description}
    Wait Until Page Contains Element  id:button-create
    Wait Until Element Is Enabled  id:button-create
    Click Element  id:button-create
    ${createButtonId}=  Get Artifact Create Button Id  ${type}
    Wait Until Page Contains Element  id:${createButtonId}
    Click Element  id:${createButtonId}

    ${titleId}=  Get Artifact Title Input Id  ${type}
    ${descriptionId}=  Get Artifact Description Input Id  ${type}
    Wait Until Element Is Enabled  id:${titleId}
    Wait Until Element Is Enabled  id:${descriptionId}

    Sleep  0.5s
    Set Focus To Element   id:${titleId}

    Input Text  id:${titleId}  ${title}
    Input Text  id:${descriptionId}  ${description}

    ${saveButtonId}=  Get Artifact Save Button Id  ${type}
    Wait Until Element Is Enabled  id:${saveButtonId}
    Click Element  id:${saveButtonId}

    Wait Until Page Contains Element  css:${toastyCloseButtonCss}
    Element Should Be Visible  css:${toastySuccessCss}
    Click Element  css:${toastyCloseButtonCss}

Create Folder Resource
    [Arguments]    ${type}  ${title}
    Wait Until Page Contains Element  id:button-create
    Wait Until Element Is Enabled  id:button-create
    Click Element  id:button-create
    ${createButtonId}=  Get Artifact Create Button Id  ${type}
    Wait Until Page Contains Element  id:${createButtonId}
    Click Element  id:${createButtonId}

    ${titleId}=  Get Artifact Title Input Id  ${type}
    Wait Until Element Is Visible  id:new-folder-modal
    Wait Until Element Is Enabled  xpath://input[@ng-model="folder.folder.name"]

    Sleep  0.5s
    Input Text  xpath://input[@ng-model="folder.folder.name"]  ${title}


    Wait Until Element Is Enabled  xpath:${folderCreateDialogSaveXpath}
    Click Element  xpath:${folderCreateDialogSaveXpath}

    Wait Until Page Contains Element  css:${toastyCloseButtonCss}
    Element Should Be Visible  css:${toastySuccessCss}
    Click Element  css:${toastyCloseButtonCss}



