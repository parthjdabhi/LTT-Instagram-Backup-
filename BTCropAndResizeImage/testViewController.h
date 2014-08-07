//
//  testViewController.h
//  CoreImageTest
//
//  Created by phonex on 7/16/14.
//  Copyright (c) 2014 lifetime. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "ViewController.h"
@interface testViewController : UIViewController<UINavigationControllerDelegate,UITextFieldDelegate,UIActionSheetDelegate,UIAlertViewDelegate>




@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UISlider *imageSlider;
@property (weak, nonatomic) IBOutlet UIScrollView *effectScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *editScrollView;
@property (weak, nonatomic) IBOutlet UIView *navigationView;
@property (weak, nonatomic) IBOutlet UIView *imageSliderView;
@property (strong, nonatomic) UIImage *imageToFilter;
@property (strong, nonatomic) NSData *DataResaultFilter;

@property (strong, nonatomic) UIView *lkBoundView;
@property (strong, nonatomic) UIImage *lkImageToCrop;
@property (nonatomic) NSInteger lkChooseType;
@property (strong, nonatomic) ViewController *lkViewController;
@property (nonatomic) int lkBack;
@property (strong, nonatomic) UIImage * lkImageShare;
@property (nonatomic) CGFloat lkHeight;
@property (nonatomic) BOOL lkDownStatus;

- (IBAction)changeSliderValue:(id)sender;
- (IBAction)backCropViewController:(id)sender;

//author dvduongth
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationbar;


@end
