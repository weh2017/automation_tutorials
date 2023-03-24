*** Settings ***
Documentation    Handling Alerts
Library        SeleniumLibrary
Suite Setup    Open Browser    ${URL_ALERTS}
Suite Teardown    Close Browser


*** Variables ***
${URL_ALERTS}    https://demoqa.com/alerts
${CLICK_ONE_BTN}    //button[@id="alertButton"]
${CONFIRM_BTN}      //button[@id="confirmButton"]
${RESULT_CONFIRM}    //span[@id="confirmResult"]


*** Keywords ***

Alert Me One
    Click Element    ${CLICK_ONE_BTN}
    Sleep  3

Alert Me Confirm
    Click Element    ${CONFIRM_BTN}

*** Test Cases ***
TEST01_HANDLING ALERTS
    [Tags]    test1
    Alert Me One
    Sleep  3
    Handle Alert
    Alert Should Not Be Present

TEST02_ALERT SHOULD BE PRESENT
    [Tags]    test2
    Alert Me One
    Alert Should Be Present    You clicked a button
    Alert Should Not Be Present

TEST03_HANDLING ALERTS WITH CONFIRMATION MESSAGE
    [Tags]    test3
    Alert Me Confirm
    Handle Alert    DISMISS
    ${msg}    Get Text   ${RESULT_CONFIRM}

    IF  '${msg}' == 'You selected Ok'
        Run Keywords    Wait Until Page Contains    You selected Ok
        ...    AND    Log To Console    USER SELECTED : OK
    ELSE
        Run Keywords
        ...    Wait Until Page Contains    You selected Cancel
        ...  AND
        ...    Log To Console    USER SELECTED : CANCEL
    END
    Alert Should Not Be Present

TEST04_ALERT SHOULD BE PRESENT WITH CONFIRMATION MESSAGE
    [Tags]    test4
    Alert Me Confirm
    Alert Should Be Present    Do you confirm action?
    ${msg}    Get Text   ${RESULT_CONFIRM}

    IF  '${msg}' == 'You selected Ok'
        Run Keywords    Wait Until Page Contains    You selected Ok
        ...    AND    Log To Console    USER SELECTED : OK
    ELSE
        Run Keywords
        ...    Wait Until Page Contains    You selected Cancel
        ...  AND
        ...    Log To Console    USER SELECTED : CANCEL
    END
    Alert Should Not Be Present