
# iOS AdLyft Integration Guide

This document will walk you through the process of setting up AdLyft in an iOS
application. To view a working example application with AdLyft implemented
and properly configured see here : https://github.com/AdLyft/ios-example

If any of this is confusing or you notice an error or would like further detail
on a part please email me at dawsonreid@adlyft.com

## Contents

- Including AdLyft in your project
- Initializing AdLyft
- Triggering AdLyft

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

## Initializing AdLyft

AdLyft must be initialized with a GID (key) and secret. This GID and secret is
specific to your application and is generated when you register an application
though the AdLyft web portal. For information on creating a new application
through the AdLyft web portal see here :

The initialization code :

```objective-c
  (void) [[ADLAdLyftController alloc]
          initWithGID:@"example-gid"
          andSecret:@"example-secret"];
```

**Note :** AdLyft uses a variant of HMAC based authentication and the secret is
**secret** and never transmitted over the network.

## Triggering AdLyft

AdLyft may be triggered with a single line of code and a callback as follows :

```objective-c
  [ADLAdLyftController.instance triggerOnView:self.view
                               withRewardByKey:@"Your Reward Key"
                                  withCallback:
     ^(ADLReward *reward, ADLResult *results) {
          NSLog(@"AdLyft returned.");
      }];
```

The view supplied to the `ADLAdLyftController` is prevented from receiving user
interaction via `view.userInteractionEnabled = NO;`. If this is a problem please
let me know (dawsonreid@adlyft.com).

## Returning from AdLyft

When AdLyft is complete the supplication block is called and provided an
`ADLReward` and `ADLResult` object.
