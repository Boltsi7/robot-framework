*** Settings ***
Resource        resource.robot
Library         ../AppLibrary.py
Test Setup      Input New Command And Create User

*** Test Cases ***
Register With Valid Username And Password
    Input Credentials    kalle    kalle12345
    Output Should Contain    Logged in

Register With Already Taken Username And Valid Password
    Create User          kalle    kalle12345
    Input Credentials    kalle    kalle12345
    Output Should Contain    Username is already taken

Register With Too Short Username And Valid Password
    Input Credentials    ka       kalle12345
    Output Should Contain    Invalid username

Register With Enough Long But Invalid Username And Valid Password
    Input Credentials    ka!le    kalle12345
    Output Should Contain    Invalid username

Register With Valid Username And Too Short Password
    Input Credentials    kalle    kal12
    Output Should Contain    Invalid password

Register With Valid Username And Long Enough Password Containing Only Letters
    Input Credentials    kalle    kallekalle
    Output Should Contain    Invalid password


*** Keywords ***
Input New Command And Create User
    Create User    kalle    kalle12345
    Input Login Command

Input Login Command
    Input    login
    Input    New Command

Input Credentials
    [Arguments]    ${username}    ${password}
    Input    ${username}
    Input    ${password}
    Run Application