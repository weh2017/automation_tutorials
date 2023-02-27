*** Settings ***
Documentation    Switch Browser and Switch Window Test

Library    SeleniumLibrary


*** Variables ***
${GOOGLE}    https://www.google.com/
${YAHOO}     https://www.yahoo.com/
${YAHOO_TXTFIELD}   id=ybar-sbq
${YAHOO_SEARCH_BTN}    id=ybar-search
${RF_LINK}        robotframework.org
${RESOURCES}      name=go-to-Resources
*** Test Cases ***
TC1_SWITCH BROWSER TEST
    [Tags]    TC1
    Open Browser   ${GOOGLE}
    Location Should Be    ${GOOGLE}
    Open Browser   ${YAHOO}   alias=second
    Location Should Be  ${YAHOO}
    Switch Browser  1
    Page Should Contain    Gmail
    Switch Browser    second
    Page Should Contain     Mail

TC2_SWITCH WINDOW
    Open Browser    ${YAHOO}    chrome
    Input Text    ${YAHOO_TXTFIELD}    robot framework
    Click Element    ${YAHOO_SEARCH_BTN}
    Wait Until Page Contains    Robot Framework
    Click Link    ${RF_LINK}
    Switch Window    NEW
    Wait Until Element Is Visible   ${RESOURCES}
    Click Element  ${RESOURCES}
    Sleep  5
    Switch Window    MAIN