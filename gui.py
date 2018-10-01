# !/usr/bin/python3'
from tkinter import ttk
from tkinter import *
from tkinter.ttk import *
from subprocess import Popen
from tkinter import messagebox
import sys
from subprocess import call
import os
import datetime
 

parks = ["Magic Kingdom Park", "Epcot", "Disney's Hollywood Studios", "Disney's Animal Kingdom Theme Park"]

magic_kingdom_att = ["The Barnstormer", "Big Thunder Mountain Railroad", "Buzz Lightyear's Space Ranger Spin", "Dumbo the Flying Elephant", "Enchanted Tales with Belle", "Haunted Mansion", "\"it's a small world\"", "Jungle Cruise", \
"Mad Tea Party", "The Magic Carpets of Aladdin", "The Many Adventures of Winnie the Pooh", "Meet Ariel at Her Grotto", \
"Meet Cinderella and Elena at Princess Fairytale Hall", "Meet Mickey Mouse at Town Square Theater", "Meet Rapunzel and Tiana at Princess Fairytale Hall", \
"Meet Tinker Bell at Town Square Theater", "Mickey's PhilharMagic", "Monsters, Inc. Laugh Floor", "Peter Pan's Flight", "Pirates of the Caribbean", \
"Seven Dwarfs Mine Train", "Space Mountain", "Splash Mountain", "Tomorrowland Speedway", "Under the Sea ~ Journey of The Little Mermaid"]

epcot_att = ["Pixar Short Film Festival", "Frozen Ever After", "IllumiNations: Reflections of Earth", "Journey Into Imagination With Figment", \
"Living with the Land", "Meet Disney Pals at the Epcot Character Spot", "Mission: SPACE", "The Seas with Nemo & Friends", "Soarin' Around the World", \
"Spaceship Earth", "Test Track", "Turtle Talk With Crush" ]

studios_att = ["Alien Swirling Saucers - Now Open!", "Beauty and the Beast-Live on Stage", "Fantasmic!", "For the First Time in Forever: A Frozen Sing-Along Celebration", \
"Indiana Jones™ Epic Stunt Spectacular!", "Muppet*Vision 3D", "Rock 'n' Roller Coaster Starring Aerosmith", "Star Tours – The Adventures Continue", \
"Slinky Dog Dash - Now Open!", "Toy Story Mania!", "The Twilight Zone Tower of Terror™", "Voyage of The Little Mermaid"]

dak_att = ["Avatar Flight of Passage", "DINOSAUR", "Expedition Everest - Legend of the Forbidden Mountain", "Festival of the Lion King", \
"Finding Nemo - The Musical", "It's Tough to be a Bug!", "Kali River Rapids", "Kilimanjaro Safaris", "Meet Favorite Disney Pals at Adventurers Outpost", \
"Na'vi River Journey", "Primeval Whirl", "Rivers of Light", "UP! A Great Bird Adventure - Now Showing"]

valid_times = [ "9:00am", "9:05am", "9:10am","9:15am","9:20am","9:25am","9:30am","9:35am","9:40am","9:45am","9:50am","9:55am",
                "10:00am", "10:05am", "10:10am","10:15am","10:20am","10:25am","10:30am","10:35am","10:40am","10:45am","10:50am","10:55am",
                "11:00am", "11:05am", "11:10am","11:15am","11:20am","11:25am","11:30am","11:35am","11:40am","11:45am","11:50am","11:55am",
                "12:00pm", "12:05pm", "12:10pm","12:15pm","12:20pm","12:25pm","12:30pm","12:35pm","12:40pm","12:45pm","12:50pm","12:55pm",
                "1:00pm", "1:05pm", "1:10pm","1:15pm","1:20pm","1:25pm","1:30pm","1:35pm","1:40pm","1:45pm","1:50pm","1:55pm",
                "2:00pm", "2:05pm", "2:10pm","2:15pm","2:20pm","2:25pm","2:30pm","2:35pm","2:40pm","2:45pm","2:50pm","2:55pm",
                "3:00pm", "3:05pm", "3:10pm","3:15pm","3:20pm","3:25pm","3:30pm","3:35pm","3:40pm","3:45pm","3:50pm","3:55pm",
                "4:00pm", "4:05pm", "4:10pm","4:15pm","4:20pm","4:25pm","4:30pm","4:35pm","4:40pm","4:45pm","4:50pm","4:55pm",
                "5:00pm", "5:05pm", "5:10pm","5:15pm","5:20pm","5:25pm","5:30pm","5:35pm","5:40pm","5:45pm","5:50pm","5:55pm",
                "6:00pm", "6:05pm", "6:10pm","6:15pm","6:20pm","6:25pm","6:30pm","6:35pm","6:40pm","6:45pm","6:50pm","6:55pm",
                "7:00pm", "7:05pm", "7:10pm","7:15pm","7:20pm","7:25pm","7:30pm","7:35pm","7:40pm","7:45pm","7:50pm","7:55pm",
                "8:00pm", "8:05pm", "8:10pm","8:15pm","8:20pm","8:25pm","8:30pm","8:35pm","8:40pm","8:45pm","8:50pm","8:55pm"]

variables = ''

widgets = []

def RobotCallBack(variables):
    variables += (' -v EMAIL:'+Entry_Email.get())
    variables += (' -v PASSWORD:'+Entry_Password.get())
    variables += (' -v NEXT_MONTH:'+(str(next_month.get())))
    variables += (' -v DATE:'+Spinbox_Date.get())
    park.set(park.get().replace(" ", "_"))
    variables += (' -v PARK:'+park.get())
    attraction.set(attraction.get().replace(" ", "_"))
    variables += (' -v ATTRACTION:'+attraction.get())
    variables += (' -v INCLUDE_SELF:'+(str(include_self.get())))
    variables += (' -v EARLIEST_TIME:'+(str(GetTimeBeginIndex())))
    variables += (' -v LATEST_TIME:'+(str(GetTimeEndIndex())))
    variables = AppendUsersToVariables(variables)
    os.system('robot -d results -E space:_' + variables +  ' FastPass.robot')

def AppendUsersToVariables(variables):
    i=0
    for val in widgets:
        variables += (' -v USER'+str(i)+':'+val.get())
        i += 1
    variables += (' -v NUMBER_OF_USERS:'+str(len(widgets)))
    return variables

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

def AddUser():
    Label(top, text="User "+str(len(widgets)) , font=("Helvetica", 12), anchor=W, justify=LEFT, width=12).grid(row=current_row.get())
    Entry_User = Entry(top, width=12)
    Entry_User.grid(row=current_row.get(), column=1, sticky="ew")
    widgets.append(Entry_User)
    current_row.set(current_row.get()+1)

def GetTimeBeginIndex():
    index = -1
    while index < len(valid_times):
        index += 1
        if valid_times[index] == Combobox_TimeBegin.get():
            return index
            
    
def GetTimeEndIndex():
    index = -1
    while index < len(valid_times):
        index += 1
        if valid_times[index] == Combobox_TimeEnd.get():
            return index
            





#MAIN ******************************************************
top = Tk()
top.geometry("500x250")  

park = StringVar()
time_begin = StringVar()
time_end = StringVar()
attraction = StringVar()
include_self = BooleanVar()
next_month = BooleanVar()
current_row = IntVar()

Time_Frame = Frame(top)

Label(top, text="Email",       font=("Helvetica", 12), anchor=W, justify=LEFT, width=15).grid(row=0)
Label(top, text="Password",    font=("Helvetica", 12), anchor=W, justify=LEFT, width=15).grid(row=1)
Label(top, text="Next Month?", font=("Helvetica", 12), anchor=W, justify=LEFT, width=15).grid(row=2)
Label(top, text="Date (1-31)", font=("Helvetica", 12), anchor=W, justify=LEFT, width=15).grid(row=3)
Label(top, text="(9:00am - 8:00pm)",  font=("Helvetica", 12), anchor=W, justify=LEFT, width=15).grid(row=4)
Label(top, text="Park",        font=("Helvetica", 12), anchor=W, justify=LEFT, width=15).grid(row=5)
Label(top, text="Attraction",  font=("Helvetica", 12), anchor=W, justify=LEFT, width=15).grid(row=6)
Label(top, text="Include Self?",  font=("Helvetica", 12), anchor=W, justify=LEFT, width=15).grid(row=7)

Entry_Email = Entry(top, width=12)
Entry_Email.insert(END, 'kcpaxtwin@gmail.com')

Entry_Password = Entry(top, width=12, show="*")
Entry_Password.insert(END, 'TheTruestDisney99@@@')

next_month.set(False)
CheckButton_Month = Checkbutton(top, text="Check to scan fastpass for next month", variable=next_month)

Spinbox_Date = Spinbox(top, from_=1, to=31, width=12)
Spinbox_Date.insert(0,1)

Combobox_TimeBegin = Combobox(Time_Frame,  state="readonly",  values=(valid_times), width=8)
Combobox_TimeBegin.current(0)
Combobox_TimeEnd = Combobox(Time_Frame,  state="readonly", values=(valid_times), width=8)
Combobox_TimeEnd.current(len(valid_times)-1)

include_self.set(True)
CheckButton_IncludeSelf = Checkbutton(top, text="Include me in fastpass selection", variable=include_self)

park.set("Magic Kingdom Park")
OptionMenu_Parks = OptionMenu(top, park, "Magic Kingdom Park", *parks, command=lambda x: SetAttractions(park.get()))

attraction.set("Enchanted Tales With Belle")
OptionMenu_Attractions = OptionMenu(top, attraction, "The Barnstormer", *magic_kingdom_att)

Button_AddUser = Button(top,text="Add User To Party",command=AddUser, width = 20)

Button_FastPass = Button(top,text="Get Fastpass!",command=lambda: RobotCallBack(variables), width = 20)

Time_Frame.grid(row=4, column=1, sticky="nsew")

Entry_Email.grid(row=0, column=1, sticky="ew")
Entry_Password.grid(row=1, column=1, sticky="ew")
CheckButton_Month.grid(row=2, column=1, sticky="ew")
Spinbox_Date.grid(row=3, column=1, sticky="ew")
Combobox_TimeBegin.pack(side="left")
Label(top, text="through",font=("Helvetica", 8), anchor=W, justify=CENTER, width=7).grid(row=4, column=1)
Combobox_TimeEnd.pack(side="right")
OptionMenu_Parks.grid(row=5, column=1, sticky="ew")
OptionMenu_Attractions.grid(row=6, column=1, sticky="ew")
CheckButton_IncludeSelf.grid(row=7, column=1, sticky="ew")

Button_AddUser.grid(row=29, column=0, columnspan=2, sticky="ew")
Button_FastPass.grid(row=30, column=0, columnspan=2, sticky="ew")

current_row.set(8)

top.mainloop()

#************************************************************