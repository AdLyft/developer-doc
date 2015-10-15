
# iOS AdLyft Integration Guide

This document will walk you through the process of setting up AdLyft in an iOS
application. To view a working example application with AdLyft implemented
and properly configured see here : https://github.com/AdLyft/ios-example

If any of this is confusing or you notice an error or would like further detail
on a part please email me at dawsonreid@adlyft.com

## Contents

- [Including AdLyft in your project](#including-adlyft-in-your-project)
- [AdLyft Project Settings](#adlyft-project-settings)
     *  [Link Binary with Libraries](#link-binary-with-libraries)
     *  [Configure Other Linker Flag](#configure-other-linker-flag) 
- [Initializing AdLyft](#initializing-adlyft) 
- [Triggering interactive advertisements](#triggering-interactive-advertisements) 
- [Listening for events](#listening-for-events)
- [Check for AdLyft Error Object](#check-for-adlyft-error-object)
- [Returning from AdLyft](#returning-from-adlyft)
    * [Reward Object](#reward-object)
    * [Result Object](#result-object)

## Including AdLyft in your project

To include AdLyft to your project you must first obtain the framework and
bundle (the AdLyft components). For now there is no download location for these
because we are working directly with a select group of publishers.

Once you have obtained the AdLyft components you must include them in your
project. The framework should be added to your Linked Frameworks and Libraries
by dragging and dropping into this section under your projects General config
tab as shown here :

![iOS Linked Framework Example](/images/ios-linked-frameworks.png)

The framework should then automatically show up in your projects file tree as
shown here :

![iOS Project File Tree with Framework](/images/ios-project-tree-with-framework.png)

Next you must add the AdLyft bundle to your project. This can be done by
dragging and dropping it into your projects file tree :

![iOS Project File Tree with Framework and Bundle](/images/ios-project-tree-with-framework-and-bundle.png)

Once the bundle has been added confirm it has been added to your project's
Build Phases > Copy Bundle Resources phace.

![iOS Copy Bundle Resources Phase](/images/ios-copy-bundle-resources-phase.png)

## AdLyft Project Settings

#### Link Binary with Libraries

The following frameworks must be included in **Build Phases** of the project 
Target under the category **Link Binary with Libraries**

![iOS Copy Bundle Resources Phase](/images/ios-link-binary-with-libraries.png)

#### Configure Other Linker Flag

Adlyft uses several custom categories. For these categories to be loaded properly 
from within a framework the `Other Linker Flags` in the build settings of the 
application target must include `-ObjC`.

![iOS Copy Bundle Resources Phase](/images/ios-objc-linker-flags.png)

## Initializing AdLyft

AdLyft must be initialized with a GID (key) and secret. This GID and secret is 
specific to your application and is generated when you register an application
though the AdLyft web portal. For information on creating a new application
through the AdLyft web portal see here :

The initialization code in Objective-C :

```objective-c
(void) [[ADLAdLyftController alloc] initWithGID:@"example-gid"
                                      andSecret:@"example-secret"];
```

The initialization code in Swift :

```swift
_ = try ADLAdLyftController(GID:"example-gid", andSecret:"example-secret")                
```

**Note :** AdLyft uses a variant of HMAC based authentication and the secret is
never transmitted over the network.

## Triggering Interactive Advertisements

AdLyft may be triggered with a single line of code and a callback as follows :
Method for calling AdLyft from Objective-C

```objective-c
[ADLAdLyftController.instance triggerOnView:self.view
                            withRewardByKey:@"Your Reward Key" 
                               withCallback:^(ADLReward *reward, ADLResult *results){
    NSLog(@"AdLyft returned.");
}];
```

Method for calling AdLyft from Swift : 

```swift
ADLAdLyftController.instance().triggerOnView(self.view, withRewardByKey:"Your Reward Key",
                                                           withCallback:{ reward, results in
    print("AdLyft returned.")
})
```

The view supplied to the `ADLAdLyftController` is prevented from receiving user
interaction via `view.userInteractionEnabled = NO;`. If this is a problem please
let me know (dawsonreid@adlyft.com).

**Pro Tip :** Disable the hide the button to trigger AdLyft when there are no ads 
available!

## Listening for Events

Events are used to inform when AdLyft has (or does not have) ads available.
The events also inform when media starts playing (such as a video or song) so 
that you may pause or reduce the volume of any media (background music) they 
is currently playing.

Events may be recieved by either conforming to the `ADLEventDelegate.h` protocol
or listening for events through the `NSNotificationCeneter`. 

`ADLEventDelegate` : 

![iOS Copy Bundle Resources Phase](/images/ios-AppDelegateH-ADLEventDelegates.png)

After implementing delegate methods set this line of code in your project's `AppDelegate.h` : 

```objective-c
ADLAdLyftController.instance.delegate = self;
```

or in Swift : 

```swift
ADLAdLyftController.instance().delegate = self
```

## Check for AdLyft Error Object

The Adlyft error object is initialized in `ADLAdLyftController` with the purpose of checking Adlyft works properly or not.It is used to indicate to the publisher when an error occurs in the AdLyft SDK. It should be checked by the publisher before displaying AdLyft.

For Example:
    * Authentication Fail in AppDelegate 
    
    The initialization code for AdLyft in objective-C is:

```objective-c
  (void) [[ADLAdLyftController alloc]initWithGID:@"example-gid"
                                       andSecret:@"example-secret"];
```
 The initialization code for AdLyft in swift is:

```swift
  let adlyftControllerObject = try ADLAdLyftController (GID:"example-gid", andSecret:"example-secret")
```

To handle error if authentication is not correct one must implement error handling to catch AdLyft error before displaying AdLyft

```objective-c
@try {
    (void) [[ADLAdLyftController alloc] initWithGID:@"example-gid"
                                          andSecret:@"example-secret"];
    ADLAdLyftController.instance.delegate = self;
} @catch(NSException *exception) {
    NSLog(@"ADLAdLyftController exception : %@", exception);
}
```

## Returning from AdLyft

When AdLyft is complete the completion block is called and provided an
`ADLReward` and `ADLResult` object.

### Reward Object
Rewards are what the user completes interactions to earn. These rewards can be either :
    * Consumable
    * Non-Consumable
Rewards are created by clicking the Create Reward button located in the top right of the campaign details view in AdLyft.
![iOS Copy Bundle Resources Phase](/images/portal/create-reward-button.png)


This will then open a modal

![iOS Copy Bundle Resources Phase](/images/portal/create-reward-modal.png)

All of the fields are currently required and the cost or ratio must be greater than 0.
The key is what is used in your application to trigger AdLyft to open on a view. Once created it can not be changed. All other fields can be updated.

### Result Object
Result Object is used to get total quantity of consumable rewards. which further can be shown in our user interface.
