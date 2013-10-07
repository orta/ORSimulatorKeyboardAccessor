//
//  ORKeyboardReactingApplication.h
//
//  Created by orta therox on 08/04/2013.
//  Copyright (c) 2013 Orta Therox. All rights reserved.

#import <UIKit/UIKit.h>

/**

 @abstract Set this to be the default UIApplication class in your main.m - when you use
   your app within the simulator you will have the ability to perform actions
   when you use the keyboard for input.

 @discussion To use a custom UIApplication subclass you need to change the third argument
   to the main method to be this class.

 <pre>

 int main(int argc, char *argv[]) {
   @autoreleasepool {
     return UIApplicationMain(argc, argv,
                              NSStringFromClass([ORKeyboardReactingApplication class]),
                              NSStringFromClass([ORAppDelegate class]));
   }
 }

 </pre>

 At the moment there is no attempt done to ensure there is no conflicts with UITextFields.
 This will change in the future.

 For more advanced usage, please see the <a
 href="https://github.com/orta/ORSimulatorKeyboardAccessor">ORSimulatorKeyboardAccessor Readme</a>.

 */

@interface ORKeyboardReactingApplication : UIApplication

/// Register a callback, the blocks are stored in a dictionary based on
/// the key. Caveat: Does not support capitals.

+ (void)registerForCallbackOnKeyDown:(NSString *)key :(void(^)(void))callback;

/// Register to get a target-action based callback from a key.
/// Will weakly reference the target.

+ (void)registerForSelectorOnKeyDown:(NSString *)key target:(id)target action:(SEL)selector;

@end

/// Keys for special keys.

extern NSString *ORUpKey;
extern NSString *ORDownKey;
extern NSString *ORLeftKey;
extern NSString *ORRightKey;
extern NSString *OREnterKey;
extern NSString *OREscapeKey;
extern NSString *ORDeleteKey;
extern NSString *ORSpaceKey;
extern NSString *ORTabKey;
extern NSString *ORTildeKey;
extern NSString *ORCommaKey;
