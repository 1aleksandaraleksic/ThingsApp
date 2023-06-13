# ThingsApp

This little app demonstrate my current skills and understanding of development process app with Swift.

## About app
ThingsApp are builded in UIKit framework with architectural pattern MVVM. That also include some of external dependencies like: Alamofire (https://github.com/Alamofire/Alamofire) and Toast-Swift (https://github.com/scalessec/Toast).

The purpose of app is to show episodes from the series Rick and Morty with caracters in each of them.
Api used for this demo is: https://rickandmortyapi.com/

In app on home page is possible to put a comment on each of episode. This comment will be saved localy in CoreData with id of episode and comment. 
That gives ability that the next time user returns to the app can see the already posted comment.
Some of the views are drawn using UIBezierPath, that the required design can be implemented.
Animation of some views and actions are also implemented.

## Posilbe improvments

App can be improved to store all of objects that are fetched from api, so that can bring App to work in offline mode (without Internet connection)

## SCREENSHOTS

<img src="https://github.com/1aleksandaraleksic/ThingsApp/assets/39316387/5b494ba6-3859-472f-9e81-739745e30309" alt="home" width="200"/>
<img src="https://github.com/1aleksandaraleksic/ThingsApp/assets/39316387/84b2f9d8-e1c5-4a60-a631-dd05a8e0ac91" alt="home_comment" width="200"/>
<img src="https://github.com/1aleksandaraleksic/ThingsApp/assets/39316387/1be97019-7292-4725-b175-3b0edd16e168" alt="home_input" width="200"/>

<img src="https://github.com/1aleksandaraleksic/ThingsApp/assets/39316387/223102b0-e33f-43bf-a8e0-2de014270626" alt="home_selection" width="200"/>
<img src="https://github.com/1aleksandaraleksic/ThingsApp/assets/39316387/a36240a0-d7e3-4521-b6d3-522c30295a59" alt="detail" width="200"/>
<img src="https://github.com/1aleksandaraleksic/ThingsApp/assets/39316387/e2298391-2906-4098-a237-36f1ec4684a1" alt="detail_characters" width="200"/>
