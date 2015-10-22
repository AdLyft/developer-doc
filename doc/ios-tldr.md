# iOS AdLyft Integration Guide TL;DR

A more detailed guide on implementing the AdLyft iOS SDK may be found here :
https://github.com/AdLyft/ios-example

----

#### Step 1 : Including AdLyft in your project

Add AdLyft to your project by dragging and dropping the framework into the
Xcode [Project Navigator](https://developer.apple.com/library/ios/recipes/xcode_help-structure_navigator/articles/About_the_Project_Navigator.html).
Then navigate to the to the projects `Build Phases` and add the
`AdLyft.framework` to the `Link with Binaries and Libraries` and the
`AdLyft.bundle` to the `Copy Bundle Resources`.

#### Step 2 : AdLyft Project Settings

Add the following frameworks to the `Build Phases` > `Link with Binaries and Libraries` :

![iOS Copy Bundle Resources Phase](https://raw.githubusercontent.com/AdLyft/developer-doc/master/images/ios-link-binary-with-libraries.png)

and add `-ObjC` to the `Build Settings` > `Other Linker Flags`

#### Step 3 : Initializing AdLyft

Paste the following code into the `AppDelegate`'s `didFinishLaunching`
method, substituting the GID and Secret generated for the applicaiton
in the AdLyft portal :

```objective-c
(void) [[ADLAdLyftController alloc] initWithGID:@"example-gid"
                                      andSecret:@"example-secret"];
```

or in Swift :

```swift
_ = try ADLAdLyftController(GID:"example-gid", andSecret:"example-secret")      
```

#### Step 4 : Triggering Interactive Advertisements

AdLyft may be triggered as follows :

```objective-c
[ADLAdLyftController.instance triggerOnView:self.view
                            withRewardByKey:@"Your Reward Key"
                               withCallback:^(ADLReward *reward, ADLResult *results){
    NSLog(@"AdLyft returned.");
}];
```

or in Swift :

```swift
ADLAdLyftController.instance().triggerOnView(self.view, withRewardByKey:"Your Reward Key",
                                                           withCallback:{ reward, results in
    print("AdLyft returned.")
})
```

**Happy Hacking ;)**

----

A more detailed guide on implementing the AdLyft iOS SDK may be found here :
https://github.com/AdLyft/ios-example
