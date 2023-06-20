*** Settings ***
Documentation    PUT REQUEST API ROBOT FRAMEWORK
Library    RequestsLibrary
Library    Collections
Resource    variables.robot
Suite Setup    Admin Access

*** Test Cases ***
Sending Test Request
    Test Post Request
    Test Modify Request
    Test Get Request To Verify    ${set_id}    
    ...    ${final_update}[firstname]   
    ...    ${final_update}[lastname]
    ...    ${final_update}[totalprice]
    ...    ${final_update}[bookingdates]
    ...    ${final_update}[bookingdates]

*** Keywords ***
Test Post Request
    ${booking_dates}    Create Dictionary    checkin=01-25-2023
    ...    checkout=11-02-2023
    ${body}    Create Dictionary    firstname=Jean  lastname=Grey
    ...  totalprice=456789   bookingdates=${booking_dates}
    ...    depositpaid=false   additionalneeds= Take out
    ${post_response}    POST    ${BASE_URL}${IDS_ENDPOINT}
    ...    json=${body}    expected_status=200
    
    Log    ${post_response.json()}

    ${set_id}    Set Variable    ${post_response.json()}[bookingid]

    Test Get Request To Verify    ${set_id}
    ...    ${post_response.json()}[booking][firstname]    
    ...    ${post_response.json()}[booking][lastname]    
    ...    ${post_response.json()}[booking][totalprice]    
    ...    ${post_response.json()}[booking][bookingdates] 
    ...    ${post_response.json()}[booking][bookingdates]
    
    Set Suite Variable    ${set_id}
    Log To Console   BOOKING ID IS ${set_id}

Test Get Request To Verify
    [Arguments]    ${id}    ${fname}    ${lname}    ${tprice}    ${checkin}
    ...    ${checkout}
    ${get_response}    GET    ${BASE_URL}${IDS_ENDPOINT}/${id}    
    ...    expected_status=200

    Log  ${get_response.json()}


    Should Be Equal    ${fname}    ${get_response.json()}[firstname]
    Should Be Equal    ${lname}    ${get_response.json()}[lastname]
    Should Be Equal As Numbers    ${tprice}    
    ...    ${get_response.json()}[totalprice]
    Dictionary Should Contain Value    ${get_response.json()} 
    ...    ${checkin}   
    Dictionary Should Contain Value    ${get_response.json()}   
    ...    ${checkout} 


Test Modify Request
    ${booking_dates}    Create Dictionary
    ...    checkin=${UPDATE_CHECKIN}    checkout=${UPDATE_CHECKOUT}
    ${body}    Create Dictionary    firstname=${UPDATE_FIRSTNAME}
    ...    lastname=${UPDATE_LASTNAME}    
    ...    totalprice=${UPDATE_TOTALPRICE}
    ...    depositpaid=${UPDATE_DEPOSITPAID}
    ...    bookingdates=${booking_dates}
    ...    additionalneeds=${UPDATE_ADD}
    
    ${header}    Create Dictionary    Cookie=token\=${set_token}
    ${put_response}    PUT    ${BASE_URL}${IDS_ENDPOINT}/${set_id}
    ...    headers=${header}  json=${body}    expected_status=200
    
    ${final_update}    Set Variable    ${put_response.json()}

    Log    ${put_response.json()}
    Log To Console    UPDATED RESPONSE ${put_response.json()}
    Set Suite Variable    ${final_update}
Admin Access

    ${body}    Create Dictionary    username=admin    password=password123

    ${auth_response}    POST    ${BASE_URL}/auth    json=${body}
    ...    expected_status=200
    
    Log  ${auth_response.json()}

    ${set_token}    Set Variable    ${auth_response.json()}[token]

    Set Suite Variable    ${set_token}