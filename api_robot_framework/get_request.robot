*** Settings ***
Documentation    API automation Robot Framework
Library    RequestsLibrary
Library    JSONLibrary
Library    String


*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com
${IDS_ENDPOINT}    /booking


*** Test Cases ***
Get All IDs
    [Tags]    tc1
    Create Session    Session    ${BASE_URL}    disable_warnings=1
    ${response}    GET On Session    Session    ${IDS_ENDPOINT}
    Status Should Be    200

    Log To Console  ${response.content}

Get Book ID
    [Tags]    tc2
    Create Session    Session    ${BASE_URL}    disable_warnings=1
    ${response}    GET On Session    Session    ${IDS_ENDPOINT}/400
    Status Should Be    200

    Log To Console  ${response.content}

    ${convert}    Convert String To Json    ${response.content}

    ${value}    Get Value From Json    ${convert}    $.totalprice

    ${string}    Convert To String    ${value}

    ${final_value}    Remove String Using Regexp    ${string}    ['\\[\\]]

    Log To Console    FINAL VALUE : ${final_value}

Get Book ID without Session
    [Tags]    tc3
    ${response}    GET    ${BASE_URL}${IDS_ENDPOINT}/400   expected_status=200

    Log  ${response.json()}
    Log  ${response.json()}[bookingdates][checkin]

    Should Be Equal As Strings    Smith    ${response.json()}[bookingdates][checking]