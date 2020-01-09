*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Keywords ***
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

Add Text Field
    [Arguments]  ${fieldname}    ${fieldhelptext}    ${is_required}
    Click Link  id:button-add-field-textfield

    ${fieldNameXpath}=  Get Input With Aria Label Xpath  "Enter Field Name"
    Wait Until Element Is Visible  ${fieldNameXpath}
    Wait Until Element Is Enabled  ${fieldNameXpath}

    Input Text  ${fieldNameXpath}  ${fieldname}
    ${fieldHelpXpath}=  Get Input With Aria Label Xpath  "Enter Field Help Text"
    Input Text  ${fieldHelpXpath}  ${fieldhelptext}
    Run Keyword If  ${is_required}  Set Text Field Required

Set Text Field Required
    Select Tab  "required-tab"
    Select YesNo  "yesno-required-yes"

Select Tab
    [Arguments]  ${tabname}
    Click Element  xpath://div[contains(@class, ${tabname})]

Select YesNo
    [Arguments]  ${tabname}
    Click Element  xpath://div[contains(@class, ${tabname})]