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
@{USERS}
&{ATTRACTION_DICT}
${ATTRACTION_XPATH}

*** Test Cases ***
Grab Times 

    Set Dictionary

    Login

    Select Users

    Get To Fastpass Selection

    Set Attraction

    Check For Times

*** Keywords ***
Login
    Open Browser   ${URL}   Chrome

    Sleep   5s

    Input Text    loginPageUsername    ${EMAIL}

    Input Text    loginPagePassword    ${PASSWORD}

    Click Button  loginPageSubmitButton

Select Users
    Wait Until Element Is Visible     xpath://span[contains(@class,'me ng-scope')]

    #Click Element   xpath://span[contains(@class,'me ng-scope')]

    :FOR    ${i}    IN    @{USERS}
    \    Log    ${i}
    \    Wait Until Element Is Visible     xpath://span[contains(text(),'${i}')]
    \    Click Element   xpath://span[contains(text(),'${i}')]
    Log    Exited

    #Clicks the next button to move onto the date selector
    Wait Until Element Is Visible     xpath://div[contains(@class,'ng-scope button next primary')]

    Click Element    xpath://div[contains(@class,'ng-scope button next primary')]

Get To Fastpass Selection
    #Clicks on the date
    Wait Until Element Is Visible    xpath://span[contains(text(),'${DATE}')]

    Click Element    xpath://span[contains(text(),'${DATE}')]

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

    Wait Until Element Is Visible    ${ATTRACTION_XPATH}

    Click Element   ${ATTRACTION_XPATH}

    Sleep  3s


Set Attraction
    ${value}=  Get Dictionary Values  ${ATTRACTION_DICT}

    Dictionary Should Contain Key   ${ATTRACTION_DICT}   ${ATTRACTION}
    ${xpath}=  Get From Dictionary  ${ATTRACTION_DICT}  ${ATTRACTION}
    Set Suite Variable  ${ATTRACTION_XPATH}  xpath:${xpath}

Set Dictionary

    Set Suite Variable    &{ATTRACTION_DICT}   The Barnstormer=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/barnstormer-starring-the-great-goofini/barnstormer-starring-great-goofini-00.jpg?1523278381325']
    ...   Big Thunder Mountain Railroad=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/big-thunder-mountain-railroad/big-thunder-mountain-railroad-00.jpg?1523286871423']
    ...   Buzz Lightyear's Space Ranger Spin=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/buzz-lightyears-space-ranger-spin/buzz-lightyear-space-ranger-spin-00.jpg?1530323596579']
    ...   Dumbo the Flying Elephant=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/dumbo-the-flying-elephant/dumbo-the-flying-elephant-00.jpg?1523278383456']
    ...   Enchanted Tales with Belle=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/character-experience/magic-kingdom/enchanted-tales-with-belle/enchanted-tales-with-belle-00.jpg?1523278414963']
    ...   Haunted Mansion=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/the-haunted-mansion/haunted-mansion-00.jpg?1532713339557']
    ...   "it's a small world"=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/its-a-small-world/its-a-small-world-00.jpg?1522984489697']
    ...   Jungle Cruise=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/gallery/attractions/magic-kingdom/jungle-cruise/jungle-cruise-gallery09.jpg?1523279986493']
    ...   Mad Tea Party=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/mad-tea-party/mad-tea-party-00.jpg?1523278576306']
    ...   The Magic Carpets of Aladdin=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/the-magic-carpets-of-aladdin/magic-carpets-of-aladdin-00.jpg?1523285656374']
    ...   The Many Adventures of Winnie the Pooh=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/the-many-adventures-of-winnie-the-pooh/many-adventures-of-winnie-the-pooh-00.jpg?1523279371447']
    ...   Meet Ariel at Her Grotto=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/character-experience/magic-kingdom/character-meet-ariel-grotto-fantasyland/meet-ariel-character-grotto-16x9.jpg?1521045100651']
    ...   Meet Cinderella and Elena at Princess Fairytale Hall=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/character-experience/magic-kingdom/character-meet-cinderella-fairytale-hall/character-meet-cinderella-fairytale-hall-00.jpg?1521044331750']
    ...   Meet Mickey Mouse at Town Square Theater=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/character-experience/magic-kingdom/character-meet-mickey-mouse-town-square/mickey-mouse-at-town-square-theater-00.jpg?1521044540660']
    ...   Meet Rapunzel and Tiana at Princess Fairytale Hall=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/character-experience/magic-kingdom/character-meet-rapunzel-fairytale-hall/character-meet-rapunzel-fairytale-hall-00.jpg?1531413061412']
    ...   Meet Tinker Bell at Town Square Theater=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/character-experience/magic-kingdom/character-meet-tinker-bell-town-square/character-meet-tinker-bell-town-square-00.jpg?1520707953921']
    ...   Mickey's PhilharMagic=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/mickeys-philharmagic/mickeys-philharmagic-00.jpg?1523279551316']
    ...   Monsters, Inc. Laugh Floor=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/monsters-inc-laugh-floor/monsters-inc-laugh-floor-00.jpg?1523279611257']
    ...   Peter Pan's Flight=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/peter-pans-flight/peter-pan-flight-00.jpg?1532556661376']
    ...   Pirates of the Caribbean=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/pirates-of-the-caribbean/pirates-of-the-caribbean-00.jpg?1523279926382']
    ...   Seven Dwarfs Mine Train=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/7-dwarfs-mine-train/7-dwarfs-mine-train-00.jpg?1532712871810']
    ...   Space Mountain=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/space-mountain/space-mountain-00.jpg?1532556721497']
    ...   Splash Mountain=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/splash-mountain/splash-mountain-00.jpg?1523279821610']
    ...   Tomorrowland Speedway=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/tomorrowland-speedway/tomorrowland-speedway-00.jpg?1523630536703']
    ...   Under the Sea ~ Journey of The Little Mermaid=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/magic-kingdom/under-the-sea-journey-of-the-little-mermaid/under-the-sea-journey-of-the-little-mermaid-new-00.jpg?1524779101354']  

    ...   Pixar Short Film Festival=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/epcot/disney-pixar-short-film-festival/disney-pixar-short-film-festival-00.jpg?1530323716315']
    ...   Frozen Ever After=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/Disney Assets/assets_dprd/Production/disney-world/attractions/epcot/frozen-ever-after-olaf-anna-elsa-16x9.jpg?1532713068252']
    ...   Illuminations: Reflections of Earth=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/epcot/illuminations-reflections-of-earth/illuminations-reflections-of-earth-00.jpg?1537217176775']
    ...   Journey Into Imagination With Figment=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/epcot/journey-into-imagination-with-figment/journey-into-imagination-with-figment-00.jpg?1520710405631']
    ...   Living with the Land=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/epcot/living-with-the-land/living-with-the-land-00.jpg?1521043165541']
    ...   Meet Disney Pals at the Epcot Character Spot=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/character-experience/epcot/character-meet-mickey-and-friends/character-meet-mickey-and-friends-00.jpg?1522185091301']
    ...   Mission: SPACE=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/epcot/mission-space/mission-space-00.jpg?1530537646465']
    ...   The Seas with Nemo & Friends=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/epcot/the-seas-with-nemo-and-friends/seas-with-nemo-and-friends-00.jpg?1525136596553']
    ...   Soarin' Around the World=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/epcot/soarin/soarin-06.jpg?1530026611434']
    ...   Spaceship Earth=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/epcot/spaceship-earth/spaceship-earth-00.jpg?1521043609539']
    ...   Test Track=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/epcot/test-track/test-track-presented-by-chevrolet-00.jpg?1521043373554']
    ...   Turtle Talk With Crush=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/epcot/turtle-talk-with-crush/turtle-talk-with-crush-00.jpg?1525123801303']

    ...   Alien Swirling Saucers - Now Open!=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/disney-world/attractions/hollywood-studios/alien-swirling-saucers/toy-story-aliens-swirliing-saucers-entrance-16x9.jpg?1535042102008']
    ...   Beauty and the Beast-Live on Stage=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/hollywood-studios/beauty-and-the-beast-live-on-stage/beauty-and-the-beast-live-on-stage-06.jpg?1532713366874']
    ...   Fantasmic!=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/hollywood-studios/fantasmic/fantasmic-00-new.jpg?1527786136252']
    ...   For the First Time in Forever: A Frozen Sing-Along Celebration=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/hollywood-studios/frozen-sing-along-celebration/summer-update-00.jpg?1521044295781']
    ...   Indiana Jones™ Epic Stunt Spectacular!=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/hollywood-studios/indiana-jones-epic-stunt-spectacular/indiana-jones-epic-stunt-spectacular-00.jpg?1520709197071']
    ...   Muppet*Vision 3D=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/gallery/attractions/hollywood-studios/muppet-vision-3d/muppet-vision-3d-update-16x9.jpg?1520710465353']
    ...   Rock 'n' Roller Coaster Starring Aerosmith=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/hollywood-studios/rock-n-roller-coaster-starring-aerosmith/rock-and-roller-coaster-starring-aerosmith-00.jpg?1532713291589']
    ...   Star Tours – The Adventures Continue=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/hollywood-studios/star-tours-the-adventures-continue/star-tours-00.jpg?1531239451612']
    ...   Toy Story Mania!=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/hollywood-studios/toy-story-mania/toy-story-mania-00.jpg?1535059952173']
    ...   The Twilight Zone Tower of Terror™=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/hollywood-studios/the-twilight-zone-tower-of-terror/twilight-zone-tower-of-terror-00.jpg?1521043753871']
    ...   Voyage of The Little Mermaid=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/hollywood-studios/voyage-of-the-little-mermaid/voyage-of-the-little-mermaid-00.jpg?1520709718453']
    ...   Slinky Dog Dash - Now Open!=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/disney-world/destinations/hollywood-studios/toy-story-land/toy-story-slinky-dog-ride-16x9.jpg?1536263611958']

    ...   Avatar Flight of Passage=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/animal-kingdom/flight-of-passage/flight-of-passage-in-ride-16x9.jpg?1532712796731']
    ...   DINOSAUR=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/animal-kingdom/dinosaur/dinosaur-00.jpg?1534441321508']
    ...   Expedition Everest - Legend of the Forbidden Mountain=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/animal-kingdom/expedition-everest/expedition-everest-day-00.jpg?1534441636646']
    ...   Festival of the Lion King=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/animal-kingdom/festival-of-the-lion-king/festival-of-the-lion-king-gallery00.jpg?1534376161848']
    ...   Finding Nemo - The Musical=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/animal-kingdom/finding-nemo-the-musical/finding-nemo-the-musical-gallery00.jpg?1522863781546']
    ...   It's Tough to be a Bug!=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/animal-kingdom/its-tough-to-be-a-bug/its-tough-to-be-a-bug-00.jpg?1534441861581']
    ...   Kali River Rapids=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/animal-kingdom/kali-river-rapids/kali-river-rapids-07.jpg?1534441951537']
    ...   Kilimanjaro Safaris=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/animal-kingdom/kilimanjaro-safaris/kilimanjaro-safaris-00.jpg?1534442086591']
    ...   Meet Favorite Disney Pals at Adventurers Outpost=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/animal-kingdom/character-meet-disney-pals-adventurers-outpost/character-meet-disney-pals-adventurers-outpost-00.jpg?1527616741452']
    ...   Na'vi River Journey=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/animal-kingdom/navi-river-journey/pandora-navi-river-journey-full-boat-16x9.jpg?1531920136462']
    ...   Primeval Whirl=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/attractions/animal-kingdom/primeval-whirl/primeval-whirl-00.jpg?1534442161532']
    ...   Rivers of Light=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/animal-kingdom/rivers-of-light/rivers-of-light-boats-16x9.jpg?1527617656380']
    ...   UP! A Great Bird Adventure - Now Showing=//img[@ng-src\='https://secure.cdn1.wdpromedia.com/resize/mwImage/1/460/260/75/dam/wdpro-assets/parks-and-tickets/entertainment/animal-kingdom/up-great-bird-adventure/wdw-birds-16x9.jpg?1533149401632']dom/up-great-bird-adventure/wdw-birds-16x9.jpg?1533149401632']dom/up-great-bird-adventure/wdw-birds-16x9.jpg?1533149401632']

    ${value}=  Get Dictionary Values  ${ATTRACTION_DICT}