*** Settings ***
Documentation    Handling Alerts
Library        SeleniumLibrary
Suite Setup    Open Browser    ${URL_ALERTS}
Suite Teardown    Close Browser


*** Variables ***
${URL_ALERTS}    https://demoqa.com/alerts
${CLICK_ONE_BTN}    //button[@id="alertButton"]


*** Keywords ***

Alert Me One
    Click Element    ${CLICK_ONE_BTN}
    Sleep  3

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
