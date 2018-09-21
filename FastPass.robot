*** Settings ***
Documentation     This is some basic info about the whole suite
Library             Selenium2Library
Library             OperatingSystem
#Suite Teardown      Close Browser

*** Variables ***
${PASSWORD}     password
${EMAIL}        email
${URL}          https://disneyworld.disney.go.com/fastpass-plus/select-party/

*** Test Cases ***
Grab Times
    Login

    Get To Fastpass Selection

*** Keywords ***
Login
    Open Browser   ${URL}   Chrome

    Sleep   10s

    Input Text    loginPageUsername    ${EMAIL}

    Input Text    loginPagePassword    ${PASSWORD}

    Click Button  loginPageSubmitButton

Get To Fastpass Selection

    Sleep   15s

    Click Image   Olaf
    
    Click Image   Buzz Lightyear

    Click Link    Next