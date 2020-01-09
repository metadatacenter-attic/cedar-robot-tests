*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Keywords ***
Create Field
    [Arguments]    ${name}
    ${fieldTitle}=  Create Test Resource Title  ${name}
    ${fieldDescription}=  Create Test Resource Description  ${name}
    Create Resource  ${resourceTypeField}  ${fieldTitle}  ${fieldDescription}
    [return]  ${fieldTitle}

Create Element
    [Arguments]    ${name}
    ${elementTitle}=  Create Test Resource Title  ${name}
    ${elementDescription}=  Create Test Resource Description  ${name}
    Create Resource  ${resourceTypeElement}  ${elementTitle}  ${elementDescription}
    [return]  ${elementTitle}

Create Template
    [Arguments]    ${name}
    ${templateTitle}=  Create Test Resource Title  ${name}
    ${templateDescription}=  Create Test Resource Description  ${name}
    Create Resource  ${resourceTypeTemplate}  ${templateTitle}  ${templateDescription}
    [return]  ${templateTitle}

Create Folder
    [Arguments]    ${name}
    ${folderTitle}=  Create Test Resource Title  ${name}
    ${folderDescription}=  Create Test Resource Description  ${name}
    Create Resource  ${resourceTypeFolder}  ${folderTitle}  ${folderDescription}
    [return]  ${folderTitle}

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

    Run Keyword If  '${type}'=='template'  Add TextField  Text Field Name  Text Field Description  True

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

Create Instance From
    [Arguments]    ${templateName}  ${name}
    ${instanceTitle}=  Create Test Resource Title  ${name}
    ${instanceDescription}=  Create Test Resource Description  ${name}

    Switch To List View
    Switch ResourceType Filters  True  False  False  False

    Wait Until Page Contains Element  ${topSearchInputId}

    ${searchFor}=  Catenate  SEPARATOR=  "  ${templateName}  "

    Input Text  ${topSearchInputId}  ${searchFor}
    ClickElement  ${searchButtonXpath}

    Wait Until Page Contains Element  ${breadcrumbPathSearchXpath}

    ClickElement  ${resourceMoreButtonTemplateXpath}

    Wait Until Element Is Visible  ${contextMenuPopulateLinkXpath}
    Wait Until Element Is Enabled  ${contextMenuPopulateLinkXpath}
    Click Element  ${contextMenuPopulateLinkXpath}

    Sleep  0.5s

    Wait Until Page Contains  ${templateName}
    Click Element  ${instanceFormFirstAnswerXpath}
    Wait Until Element Is Visible  ${instanceFormValidationXpath}
    Input Text  ${instanceFormFirstAnswerOpenedXpath}  Abcd

    ${saveButtonId}=  Get Artifact Save Button Id  metadata
    Wait Until Element Is Enabled  ${saveButtonId}
    Click Element  ${saveButtonId}

    Wait Until Page Contains Element  ${toastyCloseButtonCss}
    Element Should Be Visible  ${toastySuccessCss}
    Click Element  ${toastyCloseButtonCss}

    ${createdInstanceName}=  Get Element Attribute  ${documentTitleDivXpath}  uib-tooltip
    [return]  ${createdInstanceName}
