*** Settings ***
Documentation    API automation Robot Framework
Library    RequestsLibrary
Library    JSONLibrary
Library    String
Resource    variables.robot



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
    ${response}    GET On Session    Session    ${IDS_ENDPOINT}/1547
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

    Should Be Equal As Strings    2018-01-01    ${response.json()}[bookingdates][checkin]