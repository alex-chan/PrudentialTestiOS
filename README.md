# PrudentialTestiOS-Climber

## Background 

This is a demo project for  Prudential interview assignment 

There are only two pages in this project, LoginPage and MainPage

in the LoginPage, once email and password are valid, tap input button, it should navigate to MainPage, which show the climber's steps today

## MVVM architecture 

I use MVVM architecture here, and RxSwift/RxCocoa to do UI bi-direction bindings

LoginPage(LoginViewController)<----->LoginViewModel<---->User

LoginViewController: the View layer, it did two things:

1. binding UI
2. handle navigations if login succeed

LoginViewModel: the ViewModel lay, it's the center place, it did three things:

1. do networking requests
2. send events to UI and handle UI updates
3. fullfil the User model

User: the Model layer, it's nothing other than a regular model that defines a user

Once logged in, LoginViewController present the next MainPage, the MainPage only contains local data, no network requests

## 3rd-party libraries

* RxSwift/RxCocoa: the RFP libaray that drive the whole project
* Moya: it depends and wraps Alamofire, which is a networking request, make the request more RFP
* Moya-ObjectMapper: it maps the networking response to model automically
* Toast: A toast libaray like Android
* GOPCircleProgressView: A Objective-C UI library I wrote last year, it happens it can be used here to draw circle 
   
## Known issues

1. Launch scrren is not fullfiled with image
2. slice up and down when textfield changed







