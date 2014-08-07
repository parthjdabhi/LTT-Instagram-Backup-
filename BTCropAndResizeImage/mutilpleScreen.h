//
//  mutilpleScreen.h
//  ThucTap_INSTAGRAM
//
//  Created by MAC on 8/6/14.
//  Copyright (c) 2014 DanielDuong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mutilpleScreen : NSObject
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IOS7 ((floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1))
#define IS_LANDSCAPE ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)
#define IS_RETINA ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))

+(BOOL)is_ipad;
+(BOOL)is_iphone;
+(BOOL)is_iphone_5;
+(BOOL)is_iphone_4;
+(BOOL)is_ios7;
+(BOOL)is_landscape;
+(BOOL)is_retina;

@end
