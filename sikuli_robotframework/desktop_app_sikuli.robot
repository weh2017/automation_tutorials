*** Settings ***
Documentation     Sikuli with Robot Framework Automation
Library         SikuliLibrary    #mode=NEW
Suite Setup    Run Keywords  Start Sikuli Process  AND  Read All Images
# Suite Teardown    Run Keywords    Close Application  ${OPEN_APP}   AND  Stop Remote Server
Suite Teardown    Stop Remote Server


*** Variables ***
${IMAGE_PATH}        desktop_app_image.sikuli
${OPEN_APP}          "C:/Users/ASUS/AppData/Local/automation-studio/Automation Studio.exe"    #Location of the Application
${WELCOME_LOGO}      welcome_msg.png
${NEW_BTN}           new_robot_btn.png
${ROBOT_HEADER}        new_robot_header.png
${ROBOT_TEXTFIELD}    robot_textfield.png
${CREATE_BTN}         create_robot_btn.png
${ADD_NEW_BTN}        add_new_btn.png
${PREF_BTN}           preference_btn.png
${APP_AUTO}           appearance_auto.png
${APP_WHITE}          appearance_white.png
${APP_DARK}           appearance_dark.png
*** Test Cases ***
Execute Sikuli Script
    Open RoboCorp App
    # Navigate App                        #ENABLE THIS IF YOU WANT TO USE
    Extract Coordinates From the Image  #ENABLE THIS IF YOU WANT TO USE
    # Get Text From The Image             #ENABLE THIS IF YOU WANT TO USE
    # Capture Location And Generate Image

*** Keywords ***
Read All Images
    Add Image Path    ${IMAGE_PATH}

Open RoboCorp App
    Open Application    ${OPEN_APP}

Navigate App
    Wait Until Screen Contain    ${WELCOME_LOGO}    10
    Click    ${NEW_BTN}
    Wait Until Screen Contain    ${ROBOT_HEADER}    10
    Click    ${ROBOT_TEXTFIELD}
    Type With Modifiers    a   CTRL    #to highlight the existing text
    Press Special Key    DELETE    # delete existing text
    Input Text    ${ROBOT_TEXTFIELD}    Sikuli_Robot
    Click  ${CREATE_BTN}
    Wait Until Screen Contain    ${ADD_NEW_BTN}    10
    Click    ${ADD_NEW_BTN}

Extract Coordinates From the Image
    Wait Until Screen Contain    ${WELCOME_LOGO}    10
    Wait Until Screen Contain    ${PREF_BTN}    10
    # Preferences button 
    ${pref_coordinates}    Get Image Coordinates    ${PREF_BTN}
    Log To Console    Preferences button coordinates ${pref_coordinates}
    Click Region    ${pref_coordinates}  0  5

    ${image_target}   Create List   ${APP_WHITE}  ${APP_DARK}  ${APP_AUTO}

    FOR  ${target}  IN  @{image_target}
        Wait Until Screen Contain    ${target}    10
        ${coor}  Get Image Coordinates    ${target}
        Log To Console   ${target} coordinates : ${coor}
        Click Region    ${coor}  0  5
    END

Get Text From The Image
    Set Ocr Text Read    image=True
    ${text}  Get Text   ${NEW_BTN}
    Should Contain    ${text}  New


Capture Location And Generate Image
    ${coor}    Create List  746    263    401    35
    Highlight Region    ${coor}    2

    ${coor}    Create List  634    183    635    50
    Highlight Region    ${coor}    2

    ${coor}    Create List  177    124    195    62
    Highlight Region    ${coor}    2

    ${coor}    Create List  175    221    135    42
    Highlight Region    ${coor}    2