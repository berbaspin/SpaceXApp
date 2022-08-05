#  SpaceXApp

## App Previews ##
<img src="https://github.com/berbaspin/SpaceXApp/blob/main/SpaceXApp/Resources/Assets.xcassets/Main.imageset/Main.png" width="200">   <img src="https://github.com/berbaspin/SpaceXApp/blob/main/SpaceXApp/Resources/Assets.xcassets/Launches.imageset/Launches.png" width="200">   <img src="https://github.com/berbaspin/SpaceXApp/blob/main/SpaceXApp/Resources/Assets.xcassets/Settings.imageset/Settings.png" width="200">

## Requirements ##


### Build an iOS app ###
The application shows information about SpaceX rockets and a list of their launches.
API links: [ rockets ]( https://api.spacexdata.com/v4/rockets ), [ launches ]( https://api.spacexdata.com/v4/launches )

#### Screens: ####

**Rockets**

This is the start screen of the application.
Since there are several rockets, we suggest using the Page Control as navigation between them.
At the top of the screen is a random image of a space rocket and its name.
The next horizontal block is an information that indicates the name of the parameter, value and unit of measure:
* height
* diameter
* weight
* payload for id "leo" (Low Earth Orbit)
Then the following information needs to be displayed vertically:
* date of first launch
* country
* launch cost
* first stage - number of engines
* first stage - the amount of fuel in tons
* first stage - combustion time in seconds
* second stage - number of engines
* second stage - amount of fuel in tons
* second stage - combustion time in seconds
At the bottom of the screen, a "Show launches" button is shown, clicking on this button takes you to the next screen.
 
**Launches**

 A table that displays the name of the space rocket and a list of its launches.
For each rocket launch we show:
* launch name
* date
* icon of successful/unsuccessful launch

**Settings**

Provide a button opposite the name of the rocket on the screen 1, when pressed, we present the Settings modally.
This screen allows to select units of measurement for the following parameters:
 height
* diameter
* weight
* payload
After closing the Settings screen, the selected units of measurement should be applied to the corresponding parameters on the main screen with the list of missiles.
Implement saving user settings and apply them on subsequent launches of the application

## Workflow ##

* RxSwift
* MVVM
* Auto Layout Programmatically
* Networking (Moya)
* UserDefaults
* Follow Gitflow
