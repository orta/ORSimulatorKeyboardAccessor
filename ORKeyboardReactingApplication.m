//
//  ORKeyboardReactingApplication.m
//
//  Created by orta therox on 08/04/2013.
//  Copyright (c) 2013 Orta Therox. All rights reserved.
//
//  Based on work here: http://nacho4d-nacho4d.blogspot.co.uk/2012/01/catching-keyboard-events-in-ios.html
//            and here: https://gist.github.com/nacho4d/1592813
//
// There's a lot of useful info here: https://github.com/kennytm/iphone-private-frameworks/blob/master/GraphicsServices/GSEvent.h

#import "ORKeyboardReactingApplication.h"

#if (TARGET_IPHONE_SIMULATOR)
@interface UIEvent (private)
- (int *)_gsEvent;
@end
#endif

static ORKeyboardReactingApplication *sharedKeyboardController;

@implementation ORKeyboardReactingApplication {
    NSMutableDictionary *_callbackBlocks;
}

#define GSEVENT_TYPE 2
#define GSEVENT_FLAGS 12
#define GSEVENT_TYPE_KEYDOWN 10

- (id)init {
    self = [super init];
    if (!self) return nil;

#if (TARGET_IPHONE_SIMULATOR)
    sharedKeyboardController = self;
    _callbackBlocks = [NSMutableDictionary dictionary];
#endif

    return self;
}

- (void)sendEvent:(UIEvent *)event {
    [super sendEvent:event];

#if (TARGET_IPHONE_SIMULATOR)
    if ([event respondsToSelector:@selector(_gsEvent)]) {

        // Hardware Key events are of kind UIInternalEvent which are a
        // wrapper of GSEventRef which is wrapper of GSEventRecord

        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIView   *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
        if (firstResponder) return;

        int *eventMemory = [event _gsEvent];
        if (eventMemory) {

            int eventType = eventMemory[GSEVENT_TYPE];
            if (eventType == GSEVENT_TYPE_KEYDOWN) {

                // Since the event type is key down we can assume GSEventKey is a struct
                int eventFlags = eventMemory[GSEVENT_FLAGS];

                // Get keycode from the GSEventKey struct
                int tmp = eventMemory[15];

                // Cast to silence warnings
                UniChar *keycode = (UniChar *)&tmp;

                BOOL shiftIsHeld = (eventFlags&(1<<17))? YES : NO;
                //                BOOL commandIsHeld = (eventFlags&(1<<20))? YES : NO;

                NSString *character = [self stringFromKeycode:keycode];
                if (shiftIsHeld) {
                    character = [character uppercaseString];
                }

                for (NSString *key in _callbackBlocks.allKeys) {
                    if ([key isEqualToString:character]) {
                        dispatch_async(dispatch_get_main_queue(), ^(void) {
                            void(^callback)(void) = _callbackBlocks[key];
                            callback();
                        });
                    }
                }
            }
        }
    }
#endif
}

- (NSString *)stringFromKeycode:(UniChar *)code {
    NSInteger keyCode = code[0];

    // Just to speed up the loading WRT the amount of ifs.

    if (keyCode < 29) {
        if (keyCode== 4) return @"a";
        if (keyCode== 5) return @"b";
        if (keyCode== 6) return @"c";
        if (keyCode== 7) return @"d";
        if (keyCode== 8) return @"e";
        if (keyCode== 9) return @"f";
        if (keyCode==10) return @"g";
        if (keyCode==11) return @"h";
        if (keyCode==12) return @"i";
        if (keyCode==13) return @"j";
        if (keyCode==15) return @"k";
        if (keyCode==14) return @"l";
        if (keyCode==16) return @"m";
        if (keyCode==17) return @"n";
        if (keyCode==18) return @"o";
        if (keyCode==19) return @"p";
        if (keyCode==20) return @"q";
        if (keyCode==21) return @"r";
        if (keyCode==22) return @"s";
        if (keyCode==23) return @"t";
        if (keyCode==24) return @"u";
        if (keyCode==25) return @"w";
        if (keyCode==26) return @"x";
        if (keyCode==27) return @"y";
        if (keyCode==28) return @"z";

    } else {

        if (keyCode==30) return @"1";
        if (keyCode==31) return @"2";
        if (keyCode==32) return @"3";
        if (keyCode==33) return @"4";
        if (keyCode==34) return @"5";
        if (keyCode==35) return @"6";
        if (keyCode==36) return @"7";
        if (keyCode==37) return @"8";
        if (keyCode==38) return @"9";
        if (keyCode==39) return @"0";

        if (keyCode==43) return ORTabKey;
        if (keyCode==44) return ORSpaceKey;
        if (keyCode==53) return ORTildeKey;
        if (keyCode==42) return ORDeleteKey;
        if (keyCode==40) return OREnterKey;
        if (keyCode==41) return OREscapeKey;
        if (keyCode==54) return ORCommaKey;


        if (keyCode==82) return ORUpKey;
        if (keyCode==81) return ORDownKey;
        if (keyCode==80) return ORLeftKey;
        if (keyCode==79) return ORRightKey;
    }

    return nil;
}

+ (void)registerForCallbackOnKeyDown:(NSString *)key :(void(^)(void))callback {
    [sharedKeyboardController registerForCallbackOnKeyDown:key :callback];
}

- (void)registerForCallbackOnKeyDown:(NSString *)key :(void(^)(void))callback {
    void (^ myCopy)() = [callback copy];
    [_callbackBlocks setObject:myCopy forKey:key];
}

@end

NSString *ORUpKey = @"UP";
NSString *ORDownKey = @"DOWN";
NSString *ORLeftKey = @"LEFT";
NSString *ORRightKey = @"RIGHT";
NSString *OREnterKey = @"RETURN";
NSString *OREscapeKey = @"ESCAPE";
NSString *ORDeleteKey = @"DELETE";
NSString *ORSpaceKey = @"SPACE";
NSString *ORTabKey = @"TAB";
NSString *ORTildeKey = @"TILDE";
NSString *ORCommaKey = @"COMMA";
