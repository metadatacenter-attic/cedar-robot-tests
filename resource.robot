*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary
#Library           Selenium2Screenshots

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

${keycloakLoginFormUsernameName}  name:username
${keycloakLoginFormPasswordName}  name:password
${keycloakLoginPageTitle}  Log in to CEDAR
${keycloakLoginPageLoginErrorText}  Invalid username or password.
${keycloakLoginFormLoginButtonId}  id:kc-login
${keycloakLoginFormFeedbackTextXpath}  xpath://span[contains(@class, 'kc-feedback-text')]

${toastyCloseButtonCss}  css:.toast .close-button
${toastySuccessCss}  css:.toast.toasty-type-success

${folderCreateDialogSaveXpath}  xpath://*[@id="new-folder-modal"]//button[contains(@class, 'btn-save')]

${searchButtonXpath}  xpath://div[contains(@class, 'navbar-header')]//a[contains(@class, 'do-search')]

${resourceMoreButtonFieldXpath}  xpath://*[@id="workspace-view-container"]//div[contains(@class, 'populate-form-boxes')]//div[contains(@class, 'resource-instance') and contains(@class, 'field')]//button[contains(@class, 'more-button')]
${resourceMoreButtonElementXpath}  xpath://*[@id="workspace-view-container"]//div[contains(@class, 'populate-form-boxes')]//div[contains(@class, 'resource-instance') and contains(@class, 'element')]//button[contains(@class, 'more-button')]
${resourceMoreButtonTemplateXpath}  xpath://*[@id="workspace-view-container"]//div[contains(@class, 'populate-form-boxes')]//div[contains(@class, 'resource-instance') and contains(@class, 'template')]//button[contains(@class, 'more-button')]
${resourceMoreButtonFolderXpath}  xpath://*[@id="workspace-view-container"]//div[contains(@class, 'populate-form-boxes')]//div[contains(@class, 'resource-instance') and contains(@class, 'folder')]//button[contains(@class, 'more-button')]

${contextMenuDeleteLinkXpath}  xpath://div[contains(@class, 'box-row-mod') and contains(@class, 'selected')]//ul[contains(@class, 'dropdown-menu')]//a[contains(@class, 'delete')]

${confirmDialogYesButtonXpath}  xpath://div[contains(@class, 'cedarSWAL')]//button[contains(@class, 'confirm')]

${leftMenuWorkspaceLinkXpath}   xpath://div[contains(@class, 'shares')]//a[contains(@class, 'share') and contains(@class, 'workspace')]

${breadcrumbPathAllXpath}    xpath://div[contains(@class, 'breadcrumbs-sb')]//span[contains(@class, 'breadcrumbs') and contains(text(), "All")]
${breadcrumbPathSearchXpath}    xpath://div[contains(@class, 'breadcrumbs-sb')]//div[contains(text(), "Search Results For:")]
${gridViewToolInGridViewModeXpath}    xpath://li[@id='grid-view-tool' and contains(@class, 'grid-view')]
${gridViewToolButtonXpath}    xpath://li[@id='grid-view-tool']//button

${topSearchInputId}      id:search
${buttonCreateId}        id:button-create
${newFolderModalId}      id:new-folder-modal
${gridViewToolId}        id:grid-view-tool

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${SERVER_BASE}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Title Should Be    ${keycloakLoginPageTitle}

Input Username
    [Arguments]    ${username}
    Input Text    ${keycloakLoginFormUsernameName}    ${username}

Input Password
    [Arguments]    ${password}
    Input Text    ${keycloakLoginFormPasswordName}    ${password}

Submit Credentials
    Click Button    ${keycloakLoginFormLoginButtonId}

Login With Credentials
    [Arguments]    ${username}    ${password}
    Input Username    ${username}
    Input Password    ${password}
    Submit Credentials
    Login Should Have Succeed

Login Should Have Succeed
    Location Should Contain    ${SERVER_BASE}
    Wait Until Element Is Visible  ${leftMenuWorkspaceLinkXpath}
    Element Should Be Visible    ${leftMenuWorkspaceLinkXpath}

Login Should Have Failed
    Location Should Contain    ${LOGIN_BASE}
    Until Element Is Visible    ${keycloakLoginFormFeedbackTextXpath}
    Page Should Contain    ${keycloakLoginPageLoginErrorText}

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
    ${ret}=  Catenate  SEPARATOR=  id:button-create-  ${type}
    [return]  ${ret}

Get Artifact Title Input Id
    [Arguments]    ${type}
    ${ret}=  Catenate  SEPARATOR=  id:${type}  -name
    [return]  ${ret}

Get Artifact Description Input Id
    [Arguments]    ${type}
    ${ret}=  Catenate  SEPARATOR=  id:${type}  -description
    [return]  ${ret}

Get Artifact Save Button Id
    [Arguments]    ${type}
    ${ret}=  Catenate  SEPARATOR=  id:button-save-  ${type}
    [return]  ${ret}

Get Input With Aria Label Xpath
    [Arguments]  ${fieldlabel}
    ${ret}=  Catenate  SEPARATOR=  xpath://input[@aria-label=  ${fieldlabel}  ]
    [return]  ${ret}

Create Nonfolder Resource
    [Arguments]    ${type}  ${title}  ${description}
    Wait Until Page Contains Element  ${buttonCreateId}
    Wait Until Element Is Enabled  ${buttonCreateId}
    Click Element  ${buttonCreateId}
    ${createButtonId}=  Get Artifact Create Button Id  ${type}
    Wait Until Page Contains Element  ${createButtonId}
    Click Element  ${createButtonId}

    ${titleId}=  Get Artifact Title Input Id  ${type}
    ${descriptionId}=  Get Artifact Description Input Id  ${type}
    Wait Until Element Is Enabled  ${titleId}
    Wait Until Element Is Enabled  ${descriptionId}

    Sleep  0.5s
    Set Focus To Element   ${titleId}

    Input Text  ${titleId}  ${title}
    Input Text  ${descriptionId}  ${description}

    Run Keyword If  '${type}'=='template'  Add TextField  Text field name  Text Field Description  "True"

    ${saveButtonId}=  Get Artifact Save Button Id  ${type}
    Wait Until Element Is Enabled  ${saveButtonId}
    Click Element  ${saveButtonId}

    Wait Until Page Contains Element  ${toastyCloseButtonCss}
    Element Should Be Visible  ${toastySuccessCss}
    Click Element  ${toastyCloseButtonCss}

Create Folder Resource
    [Arguments]    ${type}  ${title}
    Wait Until Page Contains Element  ${buttonCreateId}
    Wait Until Element Is Enabled  ${buttonCreateId}
    Click Element  ${buttonCreateId}
    ${createButtonId}=  Get Artifact Create Button Id  ${type}
    Wait Until Page Contains Element  ${createButtonId}
    Click Element  ${createButtonId}

    ${titleId}=  Get Artifact Title Input Id  ${type}
    Wait Until Element Is Visible  ${newFolderModalId}
    Wait Until Element Is Enabled  xpath://input[@ng-model="folder.folder.name"]

    Sleep  0.5s
    Input Text  xpath://input[@ng-model="folder.folder.name"]  ${title}


    Wait Until Element Is Enabled  ${folderCreateDialogSaveXpath}
    Click Element  ${folderCreateDialogSaveXpath}

    Wait Until Page Contains Element  ${toastyCloseButtonCss}
    Element Should Be Visible  ${toastySuccessCss}
    Click Element  ${toastyCloseButtonCss}

Remove All Resources By Search
    [Arguments]    ${type}  ${prefix}
    Wait Until Page Contains Element  ${topSearchInputId}

    ${searchFor}=  Catenate  ${defaultTitle}  ${prefix}
    Input Text  ${topSearchInputId}  ${searchFor}
    ClickElement  ${searchButtonXpath}

    Wait Until Page Contains Element  ${breadcrumbPathSearchXpath}

    Run Keyword If  '${type}'=='field'  Remove All Field Resources
    Run Keyword If  '${type}'=='element'  Remove All Element Resources
    Run Keyword If  '${type}'=='template'  Remove All Template Resources
    Run Keyword If  '${type}'=='folder'  Remove All Folders

Remove All Field Resources
    FOR    ${i}    IN RANGE    999999
    \   ${elementCount}=  Get Element Count  ${resourceMoreButtonFieldXpath}
    \   Exit For Loop If    ${elementCount} == 0
    \   Remove First Field Resource

Remove All Element Resources
    FOR    ${i}    IN RANGE    999999
    \   ${elementCount}=  Get Element Count  ${resourceMoreButtonElementXpath}
    \   Exit For Loop If    ${elementCount} == 0
    \   Remove First Element Resource

Remove All Template Resources
    FOR    ${i}    IN RANGE    999999
    \   ${elementCount}=  Get Element Count  ${resourceMoreButtonTemplateXpath}
    \   Exit For Loop If    ${elementCount} == 0
    \   Remove First Template Resource

Remove All Folders
    FOR    ${i}    IN RANGE    999999
    \   ${elementCount}=  Get Element Count  ${resourceMoreButtonFolderXpath}
    \   Exit For Loop If    ${elementCount} == 0
    \   Remove First Folder

Remove First Field Resource
    ClickElement  ${resourceMoreButtonFieldXpath}
    Remove Resource With Open Context Menu

Remove First Element Resource
    ClickElement  ${resourceMoreButtonElementXpath}
    Remove Resource With Open Context Menu

Remove First Template Resource
    ClickElement  ${resourceMoreButtonTemplateXpath}
    Remove Resource With Open Context Menu

Remove First Folder
    ClickElement  ${resourceMoreButtonFolderXpath}
    Remove Resource With Open Context Menu

Remove Resource With Open Context Menu
    Wait Until Element Is Visible  ${contextMenuDeleteLinkXpath}
    Wait Until Element Is Enabled  ${contextMenuDeleteLinkXpath}
    Click Element  ${contextMenuDeleteLinkXpath}

    Sleep  0.5s

    Wait Until Element Is Visible  ${confirmDialogYesButtonXpath}
    Wait Until Element Is Enabled  ${confirmDialogYesButtonXpath}
    Click Element  ${confirmDialogYesButtonXpath}

    Sleep  1s

Go To Workspace View
    Wait Until Element Is Visible  ${leftMenuWorkspaceLinkXpath}
    Click Element  ${leftMenuWorkspaceLinkXpath}
    Wait Until Element Is Visible  ${breadcrumbPathAllXpath}

Switch To List View
    Wait Until Element Is Visible  ${gridViewToolId}
    ${present}=  Run Keyword And Return Status    Element Should Be Visible   ${gridViewToolInGridViewModeXpath}
    Run Keyword If    ${present}    Switch To List View Really

Switch To List View Really
    Click Element  ${gridViewToolButtonXpath}

Add Text Field
    [Arguments]  ${fieldname}    ${fieldhelptext}    ${is_required}
    Click Link  id:button-add-field-textfield

    ${fieldNameXpath}=  Get Input With Aria Label Xpath  "Enter Field Name"
    Wait Until Element Is Visible  ${fieldNameXpath}
    Wait Until Element Is Enabled  ${fieldNameXpath}

    Input Text  ${fieldNameXpath}  ${fieldname}
    ${fieldHelpXpath}=  Get Input With Aria Label Xpath  "Enter Field Help Text"
    Input Text  ${fieldHelpXpath}  ${fieldhelptext}
    Run Keyword If  ${is_required} == 'True'  Set Text Field Required

#Input Field Name By Label
#    [Arguments]  ${fieldlabel}    ${fieldvalue}
#    Input Text  xpath://input[@aria-label=${fieldlabel}]    ${fieldvalue}

Set Text Field Required
    Select Tab  "required-tab"
    Select YesNo  "yesno-required-yes"

Select Tab
    [Arguments]  ${tabname}
    Click Element  xpath://div[contains(@class, ${tabname})]

Select YesNo
    [Arguments]  ${tabname}
    Click Element  xpath://div[contains(@class, ${tabname})]
