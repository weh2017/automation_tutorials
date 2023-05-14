if exists("welcome_msg.png", 30):  # verify this image if exists
    click(Pattern("new_robot_btn.png").similar(0.37))   # click this button

if exists("new_robot_header.png", 30): # verify this label if exists

    click(Pattern("robot_textfield.png").targetOffset(0,37))    # click this input textbox

type('a', Key.CTRL)   # highlight default text if exists
type(Key.DELETE)  # delete default text
type('Sikuli_test')   # Type new title of your file

click(Pattern("create_robot_btn.png").similar(0.85))  # click this button
if exists("add_new_btn.png", 30):
    click("add_new_btn.png")

wait(5)

###########################################################
# Get Image Coordinates Section
###########################################################

"preference_btn.png"

Pattern("appearance_white.png").similar(0.75).targetOffset(-71,64)

Pattern("appearance_dark.png").targetOffset(-69,77)

Pattern("appearance_auto.png").similar(0.96).targetOffset(-69,75)

