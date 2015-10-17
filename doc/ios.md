
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
- [Checking for Errors](#checking-for-errors)
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

## Checking for Errors

The AdLyft controller exposes an error object. This object is set when an error occurs internal to 
AdLyft that cannot be recovered from. This should not be a problem 90% of the time, though may occur
for reasons such as : 

- authentication fails
- something exploded

You should always check the AdLyft error object before triggering AdLyft :     

```objective-c
if (!ADLAdLyftController.instance.error) {
    NSLog("Its not safe to open AdLyft :/");
} else {
    [ADLAdLyftController.instance triggerOnView:self.view withRewardByKey:"Coin Rewards", 
        withCallback:^(ADLReward *reward, ADLResult *result) { 
            NSLog("Returned from AdLyftController");
    }];
}
```

or in Swift : 

```swift
if ADLAdLyftController.instance().error != nil {
    print("Its not safe to open AdLyft :/")
} else {
    ADLAdLyftController.instance().triggerOnView(self.view, withRewardByKey:"Coin Rewards", 
        withCallback: { reward, results in
            print("Returned from AdLyftController")
    })
}
```

## Returning from AdLyft

When AdLyft is complete the completion block is called and provided an `ADLReward` and `ADLResult` object.

### ADLReward

Rewards are what the user completes interactions to earn. These rewards can be either :
    
    * Consumable
    * Non-Consumable

### ADLResult

The result object contains the total quantity of consumable rewards or a `BOOL` indicating if the non
consumable reward was earned. 
