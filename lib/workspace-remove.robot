*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Keywords ***
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
    Run Keyword If  '${type}'=='instance'  Remove All Instance Resources
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

Remove All Instance Resources
    FOR    ${i}    IN RANGE    999999
    \   ${elementCount}=  Get Element Count  ${resourceMoreButtonInstanceXpath}
    \   Exit For Loop If    ${elementCount} == 0
    \   Remove First Instance Resource

Remove All Folders
    FOR    ${i}    IN RANGE    999999
    \   ${elementCount}=  Get Element Count  ${resourceMoreButtonFolderXpath}
    \   Exit For Loop If    ${elementCount} == 0
    \   Remove First Folder

Remove First Field Resource
    Sleep  0.5s
    ClickElement  ${resourceMoreButtonFieldXpath}
    Remove Resource With Open Context Menu

Remove First Element Resource
    Sleep  0.5s
    ClickElement  ${resourceMoreButtonElementXpath}
    Remove Resource With Open Context Menu

Remove First Template Resource
    Sleep  0.5s
    ClickElement  ${resourceMoreButtonTemplateXpath}
    Remove Resource With Open Context Menu

Remove First Instance Resource
    Sleep  0.5s
    ClickElement  ${resourceMoreButtonInstanceXpath}
    Remove Resource With Open Context Menu

Remove First Folder
    Sleep  0.5s
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
