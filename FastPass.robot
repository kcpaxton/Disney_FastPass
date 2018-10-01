*** Settings ***
Documentation     This is some basic info about the whole suite
Library             Selenium2Library   timeout=60s
Library             OperatingSystem
Library             Collections

#Suite Teardown      Close Browser
*** Variables ***
${PASSWORD}          password
${EMAIL}             email
${URL}               https://disneyworld.disney.go.com/fastpass-plus/select-party/
${DATE}              22
${PARK}              Magic Kingdom Park
${ATTRACTION}        attraction   
${present}           False
${USERS_FIRST_NAME}  Kyle
@{USERS}             Derrick  Hello
${INCLUDE_SELF}      True
${NEXT_MONTH}        False
${EARLIEST_TIME}     9:00
${LATEST_TIME}       8:55
@{VALID_TIMES}       9:00     9:05     9:10    9:15    9:20    9:25    9:30    9:35    9:40    9:45    9:50    9:55   
                ...  10:00    10:05    10:10   10:15   10:20   10:25   10:30   10:35   10:40   10:45   10:50   10:55   
                ...  11:00    11:05    11:10   11:15   11:20   11:25   11:30   11:35   11:40   11:45   11:50   11:55   
                ...  12:00    12:05    12:10   12:15   12:20   12:25   12:30   12:35   12:40   12:45   12:50   12:55   
                ...  1:00     1:05     1:10    1:15    1:20    1:25    1:30    1:35    1:40    1:45    1:50    1:55   
                ...  2:00     2:05     2:10    2:15    2:20    2:25    2:30    2:35    2:40    2:45    2:50    2:55   
                ...  3:00     3:05     3:10    3:15    3:20    3:25    3:30    3:35    3:40    3:45    3:50    3:55   
                ...  4:00     4:05     4:10    4:15    4:20    4:25    4:30    4:35    4:40    4:45    4:50    4:55   
                ...  5:00     5:05     5:10    5:15    5:20    5:25    5:30    5:35    5:40    5:45    5:50    5:55   
                ...  6:00     6:05     6:10    6:15    6:20    6:25    6:30    6:35    6:40    6:45    6:50    6:55   
                ...  7:00     7:05     7:10    7:15    7:20    7:25    7:30    7:35    7:40    7:45    7:50    7:55   
                ...  8:00     8:05     8:10    8:15    8:20    8:25    8:30    8:35    8:40    8:45    8:50    8:55

${ATTRACTION_XPATH}
${NUMBER_OF_USERS}   0

*** Test Cases ***
Grab Times 

    Prerequisites 

    Login

    Select Users

    Get To Fastpass Selection

    Check For Times

*** Keywords ***
Prerequisites
    ${updated_times}   Get Slice From List  ${VALID_TIMES}    ${EARLIEST_TIME}    ${LATEST_TIME}
    Convert To List   ${updated_times}
    Set Suite Variable   @{VALID_TIMES}   @{updated_times}


Login
    Open Browser   ${URL}   Chrome

    Wait Until Element Is Visible     loginPageUsername

    Input Text    loginPageUsername    ${EMAIL}

    Input Text    loginPagePassword    ${PASSWORD}

    Click Button  loginPageSubmitButton

Select Users
    Wait Until Element Is Visible     xpath://span[contains(@class,'me ng-scope')]

    Run Keyword If  '${INCLUDE_SELF}' == 'False'
    ...         Click Element   xpath://span[contains(@class,'me ng-scope')]

    :FOR    ${i}    IN RANGE    ${NUMBER_OF_USERS}
    \    Log    ${USER${i}}
    \    Wait Until Element Is Visible     xpath://span[contains(text(),'${USER${i}}')]
    \    Click Element   xpath://span[contains(text(),'${USER${i}}')]
    Log    Exited

    #Clicks the next button to move onto the date selector
    Wait Until Element Is Visible     xpath://div[contains(@class,'ng-scope button next primary')]

    Click Element    xpath://div[contains(@class,'ng-scope button next primary')]

Get To Fastpass Selection
    [Documentation]   If NextMonth then we change the current month to the next month and then we select the specified date.

    Wait Until Element Is Visible    xpath://span[@class='icon next']
    Run Keyword If    '${NEXT_MONTH}' == 'True'    Click Element    xpath://span[@class='icon next']
 
    #Clicks on the date
    Wait Until Element Is Visible    //span[.//text() = '${DATE}']

    Click Element    //span[.//text() = '${DATE}']

    #Clicks on the specified park
    #Hard work around due to xpath inconsistencies.
    Run Keyword If  "Hollywood" in "${PARK}"   Select Park Double Quotes
    ...    ELSE IF  "Animal" in "${PARK}"     Select Park Double Quotes
    ...    ELSE IF  "Magic" in "${PARK}"      Select Park Single Quotes
    ...    ELSE IF  "Epcot" in "${PARK}"     Select Park Single Quotes


Select Park Double Quotes
    [Documentation]   This keyword is used to select animal kingdom and hollywood studios
    Wait Until Element Is Visible    xpath://h3[contains(text(),"${PARK}")]

    Click Element    xpath://h3[contains(text(),"${PARK}")]

Select Park Single Quotes
    [Documentation]   This keyword is used to select magick kingdom and epcot
    Wait Until Element Is Visible    xpath://h3[contains(text(),'${PARK}')]

    Click Element    xpath://h3[contains(text(),'${PARK}')] 

Check For Times
    [Documentation]   This keyword scans clicks the attraction, scans the available times and selects the earliest correct time
    :FOR    ${i}    IN RANGE    999999
    \    Log    ${i}
    \    Choose Attraction
    \    Wait Until Element Is Visible    xpath://a[@id='viewMyPlansLink']
    \    ${unavailable}=  Run Keyword And Return Status    Element Should Be Visible   //span[@class='unavailabilityInformation ng-binding ng-scope']
    \    ${present}=     Run Keyword Unless      ${unavailable}         Scan Times
    \    Run Keyword Unless    ${present}    Click Element   xpath://div[@class='ng-scope button back secondary']
    \    Exit For Loop If    ${present}
    Log    Exited

    #Confirm Selection
    Wait Until Element Is Visible    xpath://div[@class='ng-scope button confirm tertiary']

    Click Element   xpath://div[@class='ng-scope button confirm tertiary']

Scan Times
    [Documentation]   Scans the available times and selects the earliest correct time
    :FOR    ${time}    IN   @{VALID_TIMES}
    \       ${present}=  Run Keyword And Return Status    Element Should Be Visible   xpath://span[contains(text(),'${time}')]
    \       Run Keyword If    ${present}    Click Element   xpath://span[contains(text(),'${time}')] 
    \       Exit For Loop If    ${present}
    [return]   ${present}

Choose Attraction
    [Documentation]    Selects the specified attraction.

    Wait Until Element Is Visible    //div[contains(text(),'${ATTRACTION}')]

    Click Element   //div[contains(text(),'${ATTRACTION}')]

    
