ORSimulatorKeyboardAccessor
===========================

Use your keyboard in the iOS simulator with a blocks based API.

Set this to be the default UIApplication class in your main.m - when you use
your app within the simulator you will have the ability to perform actions
when you use the keyboard for input.

To use a custom UIApplication subclass you need to change the third argument
to the main method to be this class.


``` objc
 int main(int argc, char *argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv,
            NSStringFromClass([ORKeyboardReactingApplication class]),
            NSStringFromClass([ORAppDelegate class]));
    }
 }
```

Then in your view controllers:

```objc
  [ORKeyboardReactingApplication registerForCallbackOnKeyDown:@"a" :^{
      NSLog(@"Hey there 'a' - how're you doing?");
  }];
```

####Todo list
Would love PRs with these features

* Ensure no clashes with UITextfield 
* Find a way to do Key Up
* Allow the API to have repeating vs non-repeating calls
* Listen for navigation controller changes and remove any methods related
* Using shift = capital version
* Support for command / alt