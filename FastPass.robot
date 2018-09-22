*** Settings ***
Documentation     This is some basic info about the whole suite
Library             Selenium2Library   timeout=10s
Library             OperatingSystem
#Suite Teardown      Close Browser

*** Variables ***
${PASSWORD}     password
${EMAIL}        email
${URL}          https://disneyworld.disney.go.com/fastpass-plus/select-party/
${DATE}         22
${PARK}         Magic Kingdom Park
${ENCHANTED_TALES}   //img[@ng-src='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/character-experience/magic-kingdom/enchanted-tales-with-belle/enchanted-tales-with-belle-00.jpg?1523278414963']
${TEST_TRACK}   //img[@ng-src='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/epcot/test-track/test-track-presented-by-chevrolet-00.jpg?1521043373554'] 
${present}      False
*** Test Cases ***
Grab Times
    Login

    Get To Fastpass Selection

    Check For Times

*** Keywords ***
Login
    Open Browser   ${URL}   Chrome

    Sleep   10s

    Input Text    loginPageUsername    ${EMAIL}

    Input Text    loginPagePassword    ${PASSWORD}

    Click Button  loginPageSubmitButton

Get To Fastpass Selection

    Sleep   15s

    #Click Image   Olaf
    
    #Click Image   Buzz Lightyear

    #Clicks the next button to move onto the date selector
    Wait Until Element Is Visible     xpath://div[@class='ng-scope button next primary']

    Click Element    xpath://div[@class='ng-scope button next primary']

    #Clicks on the date
    Wait Until Element Is Visible    xpath://span[contains(text(),'${DATE}')]

    Click Element    xpath://span[contains(text(),'${DATE}')]

    #Clicks on the specified park
    Wait Until Element Is Visible    xpath://h3[contains(text(),'${PARK}')]

    Click Element    xpath://h3[contains(text(),'${PARK}')]

Check For Times
    :FOR    ${i}    IN RANGE    999999
    \    Log    ${i}
    \    Choose Attraction
    \    ${present}=  Run Keyword And Return Status    Element Should Be Visible   xpath://div[@class='experienceAvailability']//div[2]
    \    Run Keyword If    ${present}    Click Element   xpath://div[@class='experienceAvailability']//div[2]
    \    ...         ELSE  Click Element   xpath://div[@class='ng-scope button back secondary']
    \    Exit For Loop If    ${present}
    Log    Exited

    #Confirm Selection
    #Wait Until Element Is Visible    xpath://div[@class='ng-scope button confirm tertiary']

    #Click Element   xpath://div[@class='ng-scope button confirm tertiary']

Choose Attraction
    #Clicks the specified Attraction
    Wait Until Element Is Visible    xpath:${TEST_TRACK}

    Click Element   xpath:${TEST_TRACK}

    Sleep  3s

