##ORSimulatorKeyboardAccessor

Use your keyboard in the iOS simulator with a pleasant API. 

Set this to be the default UIApplication class in your main.m - when you use
your app within the simulator you will have the ability to perform actions
when you use the keyboard without the need for a textfield.

To use a custom UIApplication subclass you need to change the third argument
to the main method to be this `ORKeyboardReactingApplication`. You can reliably leave that in for release as any non-simulator builds will only compile to an empty UIApplication subclass.

``` objc
 int main(int argc, char *argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv,
            NSStringFromClass([ORKeyboardReactingApplication class]),
            NSStringFromClass([ORAppDelegate class]));
    }
 }
```

Then in your application:

```objc
  // Block syntax
  [ORKeyboardReactingApplication registerForCallbackOnKeyDown:@"a" :^{
      NSLog(@"Hey there 'a' - how're you doing?");
  }];
  
  // Target-Action syntax  
  [ORKeyboardReactingApplication registerForSelectorOnKeyDown:@"d" target:self action:@selector(switchDColours)];
```

And you're done.

####Todo list
Would love PRs with these features

* Find a way to do key up instead of on key down.
* Allow the API to have repeating vs non-repeating calls
* Allow a range of inputs like 0-9
* Using shift = capital version
* Support for command / alt