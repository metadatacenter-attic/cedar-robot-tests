*** Settings ***
Documentation     A resource file with reusable variables.
Library           SeleniumLibrary

*** Variables ***
${SERVER_BASE}        https://cedar.metadatacenter.orgx
${LOGIN_BASE}         https://auth.metadatacenter.orgx/auth/realms/CEDAR/login-actions/authenticate
${BROWSER}            Chrome
${DELAY}              0 seconds
${VALID USER 1}       test1@test.com
${VALID PASSWORD 1}   test1
${VALID USER 2}       test2@test.com
${VALID PASSWORD 2}   test2

${defaultTitle}     TestTitle
${defaultDescription}  TestDescription

${resourceTypeElement}  element
${resourceTypeField}  field
${resourceTypeTemplate}  template
${resourceTypeInstance}  instance
${resourceTypeFolder}  folder

${keycloakLoginFormUsernameName}  name:username
${keycloakLoginFormPasswordName}  name:password
${keycloakLoginPageTitle}  Log in to CEDAR
${keycloakLoginPageLoginErrorText}  Invalid username or password.
${keycloakLoginFormLoginButtonId}  id:kc-login
${keycloakLoginFormFeedbackTextXpath}  xpath://span[contains(@class, 'kc-feedback-text')]

${toastyCloseButtonCss}  css:.toast .close-button
${toastySuccessCss}  css:.toast.toasty-type-success

${folderCreateDialogSaveXpath}  xpath://*[@id='new-folder-modal']//button[contains(@class, 'btn-save')]

${searchButtonXpath}  xpath://div[contains(@class, 'navbar-header')]//a[contains(@class, 'do-search')]

${resourceMoreButtonFieldXpath}  xpath://*[@id='workspace-view-container']//div[contains(@class, 'populate-form-boxes')]//div[contains(@class, 'resource-instance') and contains(@class, 'field')]//button[contains(@class, 'more-button')]
${resourceMoreButtonElementXpath}  xpath://*[@id='workspace-view-container']//div[contains(@class, 'populate-form-boxes')]//div[contains(@class, 'resource-instance') and contains(@class, 'element')]//button[contains(@class, 'more-button')]
${resourceMoreButtonTemplateXpath}  xpath://*[@id='workspace-view-container']//div[contains(@class, 'populate-form-boxes')]//div[contains(@class, 'resource-instance') and contains(@class, 'template')]//button[contains(@class, 'more-button')]
${resourceMoreButtonInstanceXpath}  xpath://*[@id='workspace-view-container']//div[contains(@class, 'populate-form-boxes')]//div[contains(@class, 'resource-instance') and contains(@class, 'instance')]//button[contains(@class, 'more-button')]
${resourceMoreButtonFolderXpath}  xpath://*[@id='workspace-view-container']//div[contains(@class, 'populate-form-boxes')]//div[contains(@class, 'resource-instance') and contains(@class, 'folder')]//button[contains(@class, 'more-button')]
${resourceMoreButtonGenericXpath}  xpath://*[@id='workspace-view-container']//div[contains(@class, 'populate-form-boxes')]//div[contains(@class, 'resource-instance')]//button[contains(@class, 'more-button')]

${contextMenuDeleteLinkXpath}  xpath://div[contains(@class, 'box-row-mod') and contains(@class, 'selected')]//ul[contains(@class, 'dropdown-menu')]//a[contains(@class, 'delete')]
${contextMenuPopulateLinkXpath}  xpath://div[contains(@class, 'box-row-mod') and contains(@class, 'selected')]//ul[contains(@class, 'dropdown-menu')]//a[contains(@class, 'populate')]
${contextMenuRenameLinkXpath}  xpath://div[contains(@class, 'box-row-mod') and contains(@class, 'selected')]//ul[contains(@class, 'dropdown-menu')]//a[contains(@class, 'rename')]

${confirmDialogYesButtonXpath}  xpath://div[contains(@class, 'cedarSWAL')]//button[contains(@class, 'confirm')]

${leftMenuWorkspaceLinkXpath}   xpath://div[contains(@class, 'shares')]//a[contains(@class, 'share') and contains(@class, 'workspace')]

${breadcrumbPathAllXpath}    xpath://div[contains(@class, 'breadcrumbs-sb')]//span[contains(@class, 'breadcrumbs') and contains(text(), 'All')]
${breadcrumbPathSearchXpath}    xpath://div[contains(@class, 'breadcrumbs-sb')]//div[contains(text(), 'Search Results For:')]
${gridViewToolInGridViewModeXpath}    xpath://li[@id='grid-view-tool' and contains(@class, 'grid-view')]
${gridViewToolButtonXpath}    xpath://li[@id='grid-view-tool']//button

${resourceTypeFilterTemplateOnXpath}     xpath://div[contains(@class, 'filter-type')]//div[contains(@class, 'template-selected')]
${resourceTypeFilterTemplateOffXpath}    xpath://div[contains(@class, 'filter-type')]//div[contains(@class, 'template-deselected')]
${resourceTypeFilterElementOnXpath}      xpath://div[contains(@class, 'filter-type')]//div[contains(@class, 'element-selected')]
${resourceTypeFilterElementOffXpath}     xpath://div[contains(@class, 'filter-type')]//div[contains(@class, 'element-deselected')]
${resourceTypeFilterFieldOnXpath}        xpath://div[contains(@class, 'filter-type')]//div[contains(@class, 'field-selected')]
${resourceTypeFilterFieldOffXpath}       xpath://div[contains(@class, 'filter-type')]//div[contains(@class, 'field-deselected')]
${resourceTypeFilterInstanceOnXpath}     xpath://div[contains(@class, 'filter-type')]//div[contains(@class, 'instance-selected')]
${resourceTypeFilterInstanceOffXpath}    xpath://div[contains(@class, 'filter-type')]//div[contains(@class, 'instance-deselected')]

${instanceFormFirstAnswerXpath}  xpath://div[contains(@class, 'answer')]
${instanceFormFirstAnswerOpenedXpath}  xpath://input[contains(@class, 'form-control')]
${instanceFormValidationXpath}  xpath://div[contains(@class, 'validation')]
${renameModalHeaderXpath}  xpath://*[@id='renameModalHeader']
${renameModalInputXpath}  xpath://input[@id='rename-modal-name-input']
${renameModalSaveButtonXpath}  xpath://button[@id='rename-modal-save-button']
${editorHeaderBackButtonXpath}  xpath://div[contains(@class, 'navbar-header')]//div[contains(@class, 'back-arrow-click')]

${documentTitleDivXpath}  xpath://div[contains(@class, 'document-title')]

${topSearchInputId}      id:search
${buttonCreateId}        id:button-create
${newFolderModalId}      id:new-folder-modal
${gridViewToolId}        id:grid-view-tool
