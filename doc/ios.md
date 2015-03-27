
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
