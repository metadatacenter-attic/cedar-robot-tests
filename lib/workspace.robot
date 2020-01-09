*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Keywords ***
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

Switch ResourceType Filters
    [Arguments]  ${templateOn}  ${elementOn}  ${fieldOn}  ${instanceOn}
    Switch One ResourceType Filter  ${resourceTypeTemplate}  ${templateOn}  ${resourceTypeFilterTemplateOnXpath}  ${resourceTypeFilterTemplateOffXpath}
    Switch One ResourceType Filter  ${resourceTypeElement}   ${elementOn}   ${resourceTypeFilterElementOnXpath}   ${resourceTypeFilterElementOffXpath}
    Switch One ResourceType Filter  ${resourceTypeField}     ${fieldOn}     ${resourceTypeFilterFieldOnXpath}     ${resourceTypeFilterFieldOffXpath}
    Switch One ResourceType Filter  ${resourceTypeInstance}  ${instanceOn}  ${resourceTypeFilterInstanceOnXpath}  ${resourceTypeFilterInstanceOffXpath}

Switch One ResourceType Filter
    [Arguments]  ${resourceType}  ${switchTo}  ${onXpath}  ${offXpath}
    ${presentOn}=   Run Keyword And Return Status    Element Should Be Visible   ${onXpath}
    ${presentOff}=  Run Keyword And Return Status    Element Should Be Visible   ${offXpath}
    Run Keyword If  ${presentOff} and ${switchTo}  Click Element  ${offXpath}
    Run Keyword If  ${presentOn} and not ${switchTo}  Click Element  ${onXpath}

Rename Resource Using Context Menu
    [Arguments]  ${oldName}  ${newPrefix}
    Switch ResourceType Filters  True  True  True  True
    Switch To List View

    Wait Until Page Contains Element  ${topSearchInputId}

    ${searchFor}=  Catenate  SEPARATOR=  "  ${oldName}  "

    Input Text  ${topSearchInputId}  ${searchFor}
    ClickElement  ${searchButtonXpath}

    Wait Until Page Contains Element  ${breadcrumbPathSearchXpath}

    ClickElement  ${resourceMoreButtonGenericXpath}

    Wait Until Element Is Visible  ${contextMenuRenameLinkXpath}
    Wait Until Element Is Enabled  ${contextMenuRenameLinkXpath}
    Click Element  ${contextMenuRenameLinkXpath}

    Sleep  0.5s

    Wait Until Element Is Visible  ${renameModalHeaderXpath}
    Wait Until Element Is Enabled  ${renameModalHeaderXpath}

    ${newName}=  Create Test Resource Title  ${newPrefix}
    Input Text  ${renameModalInputXpath}  ${newName}

    Click Element  ${renameModalSaveButtonXpath}

    Wait Until Page Contains Element  ${toastyCloseButtonCss}
    Element Should Be Visible  ${toastySuccessCss}
    Click Element  ${toastyCloseButtonCss}

    [return]  ${newName}

Go Back To Workspace
    Click Element  ${editorHeaderBackButtonXpath}