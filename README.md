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

At the moment there is no attempt done to ensure there is no conflicts with UITextFields.
This will change in the future.
