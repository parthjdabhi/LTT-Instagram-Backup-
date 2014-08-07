//
//  ViewController.h
//  BTCropAndResizeImage
//
//  Created by MAC on 7/16/14.
//  Copyright (c) 2014 DanielDuong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UINavigationBarDelegate,UIAlertViewDelegate,UIActionSheetDelegate>
{
    UIImagePickerController *ImagePicker;
}

@property (strong,nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *boundView;
@property (strong, nonatomic) UIImage *lkBackImage;
@property (strong, nonatomic) UITabBarController *lkTabBar;
@property (weak, nonatomic) IBOutlet UIView *viewBound;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBarCrop;

@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (nonatomic) CGFloat height;

-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;

//author dvduongth
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationbar;
@end
