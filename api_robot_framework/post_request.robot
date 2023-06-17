*** Settings ***
Documentation    API POST REQUEST
Library    RequestsLibrary
Library    Collections
Resource    variables.robot


*** Test Cases ***
Test Post Request with Create Session
    ${booking_dates}    Create Dictionary    
    ...    checkin=2022-12-25    checkout=2023-05-30
    ${body}    Create Dictionary    firstname=Jose    
    ...    lastname=Test    totalprice=4544    depositpaid=True
    ...    bookingdates=${booking_dates}    additionalneeds=Dine In
    Create Session    POST    ${BASE_URL}    disable_warnings=1
    ${response}    POST On Session    POST    ${IDS_ENDPOINT}    json=${body}
    Status Should Be    200

    ${id}    Set Variable    ${response.json()}[bookingid]
    Log    ${id}

    Should Be Equal    ${response.json()}[booking][firstname]    Jose
    Should Be Equal    ${response.json()}[booking][lastname]     Test
    Should Be Equal As Strings    ${response.json()}[booking][totalprice]     4544    
    Should Be Equal    ${response.json()}[booking][bookingdates][checkin]     2022-12-25 
    Should Be Equal    ${response.json()}[booking][bookingdates][checkout]    2023-05-30
    Log To Console    OVERALL RESULT ${response.json()}

Test POST REQUEST WITHOUT CREATING A SESSION
    [Documentation]    No create session involved
    [Tags]  tc2
    ${booking_dates}    Create Dictionary    
    ...    checkin=2023-06-18    checkout=2024-06-18
    ${body}    Create Dictionary    firstname=Star    
    ...    lastname=Wars    totalprice=1266    depositpaid=True
    ...    bookingdates=${booking_dates}    additionalneeds=Take out

    ${response}    POST    ${BASE_URL}${IDS_ENDPOINT}    json=${body}    expected_status=200

    Log Many    ${response.json()}

    Log To Console    ${response.json()}[bookingid]

    # Verify newly created booking id 

    ${get_response}    GET    ${BASE_URL}${IDS_ENDPOINT}/${response.json()}[bookingid]    expected_status=200

    Log Many    ${get_response.json()}

    Should Be Equal    ${get_response.json()}[firstname]    Star
    Should Be Equal    ${get_response.json()}[lastname]    Wars
    Should Be Equal As Numbers    ${get_response.json()}[totalprice]    1266

    Dictionary Should Contain Value    ${get_response.json()}[bookingdates]    2023-06-18
    Dictionary Should Contain Value    ${get_response.json()}[bookingdates]    2024-06-18