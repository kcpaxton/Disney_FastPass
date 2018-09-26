# !/usr/bin/python3
from tkinter import *
from tkinter.ttk import *
from subprocess import Popen
from tkinter import messagebox
import sys
from subprocess import call
import os
 

parks = ["Magic Kingdom Park", "Epcot", "Disney's Hollywood Studios", "Disney's Animal Kingdom Theme Park"]

magic_kingdom_att = ["The Barnstormer", "Big Thunder Mountain Railroad", "Buzz Lightyear's Space Ranger Spin", "Dumbo the Flying Elephant", "Enchanted Tales with Belle", "Haunted Mansion", "\"it's a small world\"", "Jungle Cruise", \
"Mad Tea Party", "The Magic Carpets of Aladdin", "The Many Adventures of Winnie the Pooh", "Meet Ariel at Her Grotto", \
"Meet Cinderella and Elena at Princess Fairytale Hall", "Meet Mickey Mouse at Town Square Theater", "Meet Rapunzel and Tiana at Princess Fairytale Hall", \
"Meet Tinker Bell at Town Square Theater", "Mickey's PhilharMagic", "Monsters, Inc. Laugh Floor", "Peter Pan's Flight", "Pirates of the Caribbean", \
"Seven Dwarfs Mine Train", "Space Mountain", "Splash Mountain", "Tomorrowland Speedway", "Under the Sea ~ Journey of The Little Mermaid"]

epcot_att = ["Pixar Short Film Festival", "Frozen Ever After", "Illuminations: Reflections of Earth", "Journey Into Imagination With Figment", \
"Living with the Land", "Meet Disney Pals at the Epcot Character Spot", "Mission: SPACE", "The Seas with Nemo & Friends", "Soarin' Around the World", \
"Spaceship Earth", "Test Track", "Turtle Talk With Crush" ]

studios_att = ["Alien Swirling Saucers - Now Open!", "Beauty and the Beast-Live on Stage", "Fantasmic!", "For the First Time in Forever: A Frozen Sing-Along Celebration", \
"Indiana Jones™ Epic Stunt Spectacular!", "Muppet*Vision 3D", "Rock 'n' Roller Coaster Starring Aerosmith", "Star Tours – The Adventures Continue", \
"Slinky Dog Dash - Now Open!", "Toy Story Mania!", "The Twilight Zone Tower of Terror™", "Voyage of The Little Mermaid"]

dak_att = ["Avatar Flight of Passage", "DINOSAUR", "Expedition Everest - Legend of the Forbidden Mountain", "Festival of the Lion King", \
"Finding Nemo - The Musical", "It's Tough to be a Bug!", "Kali River Rapids", "Kilimanjaro Safaris", "Meet Favorite Disney Pals at Adventurers Outpost", \
"Na'vi River Journey", "Primeval Whirl", "Rivers of Light", "UP! A Great Bird Adventure - Now Showing"]

variables = ''

def RobotCallBack(variables):
    variables += (' -v EMAIL:'+Entry_Email.get())
    variables += (' -v PASSWORD:'+Entry_Password.get())
    variables += (' -v DATE:'+Spinbox_Date.get())
    park.set(park.get().replace(" ", "_"))
    variables += (' -v PARK:'+park.get())
    attraction.set(attraction.get().replace(" ", "_"))
    variables += (' -v ATTRACTION:'+attraction.get())
    os.system('robot -d results -E space:_' + variables +  ' FastPass.robot')

def SetAttractions(park):
    if park == "Magic Kingdom Park":
        attraction.set("1")
        OptionMenu_Attractions.set_menu("The Barnstormer", *magic_kingdom_att)
    elif park == "Epcot":
        attraction.set("2")
        OptionMenu_Attractions.set_menu("Pixar Short Film Festival", *epcot_att)
    elif park == "Disney's Hollywood Studios":
        attraction.set("3")
        OptionMenu_Attractions.set_menu("Alien Swirling Saucers - Now Open!", *studios_att)
    elif park == "Disney's Animal Kingdom Theme Park":
        attraction.set("4")
        OptionMenu_Attractions.set_menu("Avatar Flight of Passage", *dak_att)
    




#MAIN ******************************************************
top = Tk()
top.geometry("800x500")  

park = StringVar()
attraction = StringVar()

Label(top, text="Email",       font=("Helvetica", 12), anchor=W, justify=LEFT, width=12).grid(row=0)
Label(top, text="Password",    font=("Helvetica", 12), anchor=W, justify=LEFT, width=12).grid(row=1)
Label(top, text="Date (1-31)", font=("Helvetica", 12), anchor=W, justify=LEFT, width=12).grid(row=2)
Label(top, text="Park",        font=("Helvetica", 12), anchor=W, justify=LEFT, width=12).grid(row=3)
Label(top, text="Attraction",  font=("Helvetica", 12), anchor=W, justify=LEFT, width=12).grid(row=4)

Entry_Email = Entry(top, width=12)
Entry_Email.insert(END, 'kcpaxtwin@gmail.com')

Entry_Password = Entry(top, width=12)
Entry_Password.insert(END, 'TheTruestDisney99@@@')
Spinbox_Date = Spinbox(top, from_=1, to=31, width=12)
Spinbox_Date.insert(0,1)



park.set("Magic Kingdom Park")
OptionMenu_Parks = OptionMenu(top, park, "Magic Kingdom Park", *parks, command=lambda x: SetAttractions(park.get()))

attraction.set("Enchanted Tales With Belle")
OptionMenu_Attractions = OptionMenu(top, attraction, "The Barnstormer", *magic_kingdom_att)

Entry_Email.grid(row=0, column=1, sticky="ew")
Entry_Password.grid(row=1, column=1, sticky="ew")
Spinbox_Date.grid(row=2, column=1, sticky="ew")
OptionMenu_Parks.grid(row=3, column=1, sticky="ew")
OptionMenu_Attractions.grid(row=4, column=1, sticky="ew")

Button_FastPass = Button(top,text="Get Fastpass!",command=lambda: RobotCallBack(variables), width = 20)
Button_FastPass.grid(row=0, column=2, padx=(100, 10))


top.mainloop()

#************************************************************