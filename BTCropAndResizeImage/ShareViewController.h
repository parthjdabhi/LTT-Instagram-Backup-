//
//  ShareViewController.h
//  ThucTap_INSTAGRAM
//
//  Created by MAC on 7/23/14.
//  Copyright (c) 2014 DanielDuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "SSTextView.h"
#import "ViewController.h"

@interface ShareViewController : UIViewController<UIActionSheetDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    SLComposeViewController *composeViewController;
}


@property(strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet SSTextView *textView;

@property(strong, nonatomic) UIImage *lkImage;
@property (strong, nonatomic) ViewController *lkViewControllerFromFilter;
@property (nonatomic) NSInteger lkBack;


//author dvduongth
@property (strong, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationbar;
@end
