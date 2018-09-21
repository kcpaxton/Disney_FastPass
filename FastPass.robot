*** Settings ***
Documentation     This is some basic info about the whole suite
Library             Selenium2Library
Library             OperatingSystem

*** Variables ***
${PASSWORD}     password
${EMAIL}        email

*** Test Cases ***
Grab Times
    Open Browser   https://disneyworld.disney.go.com/login/?appRedirect=/   Chrome

    Input Text    loginPageUsername    ${EMAIL}

    Input Text    loginPagePassword    ${PASSWORD}

    Click Button  loginPageSubmitButton

    Close Browser


*** Keywords ***
