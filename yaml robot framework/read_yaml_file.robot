*** Settings ***
Variables   mysample.yaml


*** Test Cases ***
Read Simple
    Read Data From Yaml File

Read List
    Read Data In A List

Read Dictionary
    Read Data In Dictionary

Get Child Selenium
    Get Data Selenium

Get Child From Child
   Get Builtin Child

*** Keywords ***
Read Data From Yaml File
    Log To Console   Read Name From yaml file "${name}"
    Log To Console   Read Description From yaml file "${description}"

Read Data In A List
    FOR  ${item}  IN  @{listing}
        Log To Console   \n${item}
    END

Read Data In Dictionary
    # &{DATA}  Create Dictionary   a=one   b=two   c=three

    ${list}  Create List   ${dictionary}

    FOR  ${item}  IN  @{list}
        Log To Console    ${item['b']}
    END
    Log Many   ${dictionary['b']}
    # IF YOU WANT TO GET EACH OF THE DATA FROM THE LIST, YOU CAN DO LIKE THIS.
    
Get Data Selenium
    Log To Console  ${robot.selenium}

Get Builtin Child
    Log To Console   ${robot.builtin.create}