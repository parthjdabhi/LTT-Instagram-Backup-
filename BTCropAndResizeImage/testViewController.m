//
//  testViewController.m
//  CoreImageTest
//
//  Created by phonex on 7/16/14.
//  Copyright (c) 2014 lifetime. All rights reserved.
//

#import "testViewController.h"
#import "UIImage+FiltrrCompositions.h"
#import "resizeImage.h"
#import "ShareViewController.h"
#import "UIImage+Extra.h"
#import "ImageProcessingCore.h"
#import "mutilpleScreen.h"

#define SCREEN_WIDTH 120
#define SCREEN_HEIGHT 72

@interface testViewController ()

@end

@implementation testViewController{
    UIImage *imageToResize;
}

//@auhtor phonex

int resolutionDisplay=0;
//case edit button(switch bright,sharpness etc.....)
int caseEditButton,caseEffectButton;
//count effect used 0= no effect
int countEditUsed=0,countEffectUsed=0;
UIImage *beginUIImage,*imgViewAfterEditImage,*imgViewAfterEffectImage;//use to contain the temp imageview image
NSMutableDictionary *viewEditFilterDict;
//@author phonex
//Array for ScrollView
NSArray *imageFilterScroll;
NSArray *titleFilterScroll;
UIButton *btnEffectImage,*btnEditImage;
//array for edit scroll view
NSArray *imageEditScroll;
UIButton *btnSingleEffect,*btnSingleEdit;
UILabel *effectLabel;
UIImageView *imageSideBarNormal;


ImageProcessingCore *imageEditProcessing ;
@synthesize navigationView,imageSliderView,imageView;
@synthesize imageSlider;
@synthesize effectScrollView,editScrollView;
@synthesize imageToFilter;

@synthesize lkImageToCrop;
@synthesize lkBoundView;
@synthesize lkChooseType;
@synthesize lkViewController;
@synthesize lkBack;
@synthesize lkImageShare;
@synthesize lkHeight;

- (void)viewDidLoad
{
    
    //author dvduongth
    if (IS_IOS7) {
        if (IS_IPHONE_5) {
            NSLog(@"is retina4 ios7 statusbar 20");
            CGRect theFrame;
            //get frame from toolbar to set new location
            theFrame= [_navigationbar frame];
            theFrame.origin.y = 20;
            _navigationbar.frame = theFrame;
            theFrame = [imageView frame];
            theFrame.origin.y = 64;
            imageView.frame = theFrame;
            resolutionDisplay=1;
        } else{
            NSLog(@"is retina3.5 ios7 statusbar 20");//retina3.5 ios7 //retina4 ios7  -------------3.5inch iOS7
            CGRect theFrame;
            //get frame from toolbar to set new location
            theFrame= [_navigationbar frame];
            theFrame.origin.y = 20;
            _navigationbar.frame = theFrame;
            theFrame = [imageView frame];
            theFrame.origin.y = 64;
            imageView.frame = theFrame;
            resolutionDisplay=0;
        }
    }else {
        NSLog(@"ios6"); //480x320
        
        resolutionDisplay=0;
        
    }
    
    imageToResize= lkImageToCrop;
    int a = lkBack;
    
    if (a == 10) {
        imageView.image = lkImageShare;
    }else{
        imageView.image = [self cropImageMethod:[self resizeImage]];
    }
    
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [super viewDidLoad];
    beginUIImage=imageView.image;
    imageEditProcessing =[[ImageProcessingCore alloc] init];
    
    //@author phonex
    //create matrix filter
    NSArray *editFilterName2= [NSArray arrayWithObjects:@"BRIGHTNESS", @"SHARPEN",
                               @"CONTRAST",@"WARMTH",@"SATURATION",@"VIGNETTE",@"Effect",nil];
    
    
    //create a effect scrollview
    imageFilterScroll = [NSArray arrayWithObjects:@"original.jpg",@"e1.png",@"e2.png",@"e3.png",@"e4.png",@"e5.png",@"e6.png",@"e7.png",@"e8.png",@"e9.png",@"e10.png",@"e11.png", nil];
    titleFilterScroll =[NSArray arrayWithObjects:@"Original",@"Effect 1",@"Effect 2",@"Effect 3",@"Effect 4",@"Effect 5",@"Effect 6",@"Effect 7",@"Effect 8",@"Effect 9",@"Effect 10",@"Effect 11", nil];
    
    int leftMargin = 0;
    for (int i = 0; i < [imageFilterScroll count]; i++)
    {
        
        btnSingleEffect= [UIButton buttonWithType:UIButtonTypeCustom];
        btnSingleEffect.frame=CGRectMake(leftMargin+10, 10, SCREEN_WIDTH-50, SCREEN_HEIGHT-22);
        NSString *cacheImage = [NSString stringWithFormat:@"%@",[imageFilterScroll objectAtIndex:i]];
        UIImage *niceImage = [UIImage imageNamed:cacheImage];
        btnSingleEffect.tag=i+2;
        [btnSingleEffect setBackgroundImage:niceImage forState:UIControlStateNormal];
        [effectScrollView addSubview:btnSingleEffect];
        
        if(i<[imageFilterScroll count]-1){
            UIImageView *tempImageView=[[UIImageView alloc] initWithFrame:CGRectMake(leftMargin+94,0,0.3,80)
                                        ];
            tempImageView.image=[UIImage imageNamed:@"upload-background2.png"];
            [effectScrollView addSubview:tempImageView];
        }
        
        effectLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin-14, 60, 120, 20)
                       ];
        effectLabel.tag=i+12;
        [effectLabel setTextAlignment:NSTextAlignmentCenter];
        [effectLabel setBackgroundColor:[UIColor clearColor]];
        [effectLabel setText:[titleFilterScroll objectAtIndex:i]];
        [effectLabel setFont:[UIFont fontWithName:@"Noteworthy-Light" size:14]];
        [effectLabel setTextColor:[UIColor whiteColor]];
        [effectScrollView addSubview:effectLabel];
        leftMargin += SCREEN_WIDTH-20;
        [btnSingleEffect addTarget:self action:@selector(effectFilterSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    CGSize contentSize = CGSizeMake(leftMargin, SCREEN_HEIGHT);
    [self.effectScrollView setContentSize: contentSize];
    
    //create a edit scroll view
    if(resolutionDisplay==1){
    [editScrollView setFrame:CGRectMake(0,590, 320, 90)];
    }else{
    [editScrollView setFrame:CGRectMake(0,590, 320, 90)];
    }
        imageEditScroll = [NSArray arrayWithObjects:@"brightnesstool@2x.png",@"sharpentool@2x.png",@"contrasttool@2x.png",@"temptool@2x.png",@"saturationtool@2x.png",@"focustool@2x.png",nil];
    leftMargin=0;
    for (int i = 0; i < [editFilterName2 count]-1; i++)
    {
        
        btnSingleEdit= [UIButton buttonWithType:UIButtonTypeCustom];
        btnSingleEdit.frame=CGRectMake(leftMargin+20, 10, SCREEN_WIDTH-80, SCREEN_HEIGHT-32);
        
        NSString *cacheImage = [NSString stringWithFormat:@"%@",[imageEditScroll objectAtIndex:i]];
        
        UIImage *niceImage = [UIImage imageNamed:cacheImage];
        btnSingleEdit.tag=i+2;
        [btnSingleEdit setBackgroundImage:niceImage forState:UIControlStateNormal];
        [editScrollView addSubview:btnSingleEdit];
        
        if(i<[editFilterName2 count]-2){
            UIImageView *tempImageView=[[UIImageView alloc] initWithFrame:CGRectMake(leftMargin+80,0,0.3,90)
                                        ];
            tempImageView.image=[UIImage imageNamed:@"upload-background2.png"];
            [editScrollView addSubview:tempImageView];
        }
        
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(leftMargin-8, 57, 100, 28)
                          ];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:[editFilterName2 objectAtIndex:i]];
        [label setFont:[UIFont fontWithName:@"Noteworthy-Light" size:10]];
        [label setTextColor:[UIColor whiteColor]];
        [editScrollView addSubview:label];
        leftMargin += SCREEN_WIDTH-40;
        [btnSingleEdit addTarget:self action:@selector(editFilterSelected:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
        imageSideBarNormal=[[UIImageView alloc] initWithFrame:CGRectMake(i*80,78,80,2)
                            ];
        imageSideBarNormal.image=[UIImage imageNamed:@"sidebar-background-normal.png"];
        [editScrollView addSubview:imageSideBarNormal];
        imageSideBarNormal.tag=30+i;
    }
    CGSize contentEditSize = CGSizeMake(leftMargin, SCREEN_HEIGHT);
    [self.editScrollView setContentSize: contentEditSize];
    effectScrollView.hidden=NO;
    editScrollView.hidden=YES;
    
    
    
    //create navigation view
    btnEffectImage=[UIButton buttonWithType:UIButtonTypeCustom];
    btnEffectImage.frame=CGRectMake(100, 5, 25, 30);
    btnEditImage=[UIButton buttonWithType:UIButtonTypeCustom];
    btnEditImage.frame=CGRectMake(200, 15, 25, 22);
    UIImage *effectImage=[UIImage imageNamed:@"filtertoolactive@2x.png"];
    UIImage *editImage=[UIImage imageNamed:@"edit-enhancetool@2x.png"];
    [btnEffectImage setBackgroundImage:effectImage forState:UIControlStateNormal];
    [btnEffectImage addTarget:self action:@selector(effectImage:) forControlEvents:UIControlEventTouchUpInside];
    [btnEditImage setBackgroundImage:editImage forState:UIControlStateNormal];
    [btnEditImage addTarget:self action:@selector(editImage:) forControlEvents:UIControlEventTouchUpInside];
    [navigationView addSubview:btnEffectImage];
    [navigationView addSubview:btnEditImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void) effectFilterSelected:(id)sender{
    //int caseEffectButton=[sender tag];
    //countEffectUsed=1;
    if(caseEffectButton==0){
        caseEffectButton=[sender tag];
        UILabel *label = (UILabel *)[self.view viewWithTag:10+caseEffectButton];
        [label setTextColor:[UIColor colorWithRed:(73/255.f) green:(153/255.f) blue:(213/255.f) alpha:1.0f]];
        
    }
    else{
        NSLog(@"bien label @%d",caseEffectButton);
        UILabel *label = (UILabel *)[self.view viewWithTag:10+caseEffectButton];
        [label setTextColor:[UIColor whiteColor]];
        caseEffectButton=[sender tag];
        UILabel *label2 = (UILabel *)[self.view viewWithTag:10+caseEffectButton];
        [label2 setTextColor:[UIColor colorWithRed:(73/255.f) green:(153/255.f) blue:(213/255.f) alpha:1.0f]];
    }
    countEffectUsed=1;
    UIImage *tempEffectImage,*tempEffectImage2;
    tempEffectImage2=beginUIImage;
    
    if (countEditUsed==0) {
        tempEffectImage=beginUIImage;
    }
    else{
        
        tempEffectImage=imgViewAfterEditImage;
        countEffectUsed=0;
    }
    
    if(caseEffectButton==2){
        
        imageView.image=beginUIImage;
        countEffectUsed=0;
        countEditUsed=0;
        for(int i=0;i<6;i++){
            UIImageView *tempSideBar = (UIImageView *)[self.view viewWithTag:30+i];
            tempSideBar.image=[UIImage imageNamed:@"sidebar-background-normal.png"];
        }
    }
    
    else{
        UIActivityIndicatorView *activityIndicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 320,280)];
        [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        //    activityIndicator.center=[self tableView].center;
        [ activityIndicator setColor:[UIColor colorWithRed:(73/255.f) green:(153/255.f) blue:(230/255.f) alpha:1.0f]];
        [imageView addSubview:activityIndicator];
        [activityIndicator startAnimating];
        dispatch_queue_t backgroundQueue = dispatch_queue_create("image effect processing", 0);
        dispatch_queue_t backgroundQueue2= dispatch_queue_create("image effect processin2g2", 0);
        
        dispatch_async(backgroundQueue, ^{
            
            UIImage *tempImage=[imageEditProcessing effectImageProcessing:tempEffectImage editTag:caseEffectButton];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityIndicator stopAnimating];
                imageView.image=tempImage;
            });
            dispatch_async(backgroundQueue2, ^{
                imgViewAfterEffectImage=[imageEditProcessing effectImageProcessing:tempEffectImage2 editTag:caseEffectButton];
            });
            //imgViewAfterEffectImage=[imageEditProcessing effectImageProcessing:tempEffectImage2 editTag:caseEffectButton];
        });
    }
    
}

-(void) editFilterSelected:(id)sender{
    if (resolutionDisplay==1) {
            [imageSliderView setFrame:CGRectMake(0,490, 320, 90)];
    }else
    {
            [imageSliderView setFrame:CGRectMake(0,480, 320, 90)];
    }
    editScrollView.hidden=YES;
    imageSliderView.hidden=NO;
    
    int btEditFilterTag=[sender tag];
    switch (btEditFilterTag) {
        case 2:
            imageSlider.maximumValue=0.5;
            imageSlider.minimumValue=-0.5;
            imageSlider.value=[[viewEditFilterDict objectForKey:@"Brightness"] floatValue];
            
            caseEditButton=2;
            
            
            break;
        case 3:
            imageSlider.maximumValue=1;
            imageSlider.minimumValue=-1;
            imageSlider.value=[[viewEditFilterDict objectForKey:@"Sharpeness"] floatValue];
            
            caseEditButton=3;
            
            
            break;
            
            
        case 4:
            imageSlider.minimumValue=0.0;
            imageSlider.maximumValue=2.0;
            imageSlider.value=[[viewEditFilterDict objectForKey:@"Contrast"] floatValue];
            
            caseEditButton=4;
            
            break;
        case 5:
            caseEditButton =5;
            imageSlider.minimumValue=-1.0;
            imageSlider.maximumValue=2.0;
            imageSlider.value=[[viewEditFilterDict objectForKey:@"Exposure"] floatValue];
            break;
        case 6:
            caseEditButton =6;
            imageSlider.minimumValue=0.0;
            imageSlider.maximumValue=2.0;
            imageSlider.value=[[viewEditFilterDict objectForKey:@"Saturation"] floatValue];
            
            break;
            
        case 7:
            caseEditButton =7;
            imageSlider.minimumValue=-2.0;
            imageSlider.maximumValue=-0.5;
            imageSlider.value=[[viewEditFilterDict objectForKey:@"Vignette"] floatValue];
            break;
        default:
            break;
    }
    
}

- (IBAction)changeSliderValue:(id)sender {
    //
    
    
    UIImage *beginImage2;UIImage *beginImage;
    
    float slideValue = imageSlider.value;
    NSLog(@"gia tri slider %f va case edit button %d",slideValue,caseEditButton);
    NSLog(@"gia tri count effect %d",countEffectUsed);
    beginImage2 = beginUIImage;
    
    if(countEffectUsed==0){
        beginImage = beginUIImage;
        
    }
    else{
        beginImage=imgViewAfterEffectImage;
        
    }
    //ImageProcessingCore *imageEditProcessing =[[ImageProcessingCore alloc] init];
    
    imageView.image= [imageEditProcessing editImageProcessing:beginImage withAmount:slideValue editTag:caseEditButton countInit:countEditUsed];
    
    imgViewAfterEditImage=[imageEditProcessing editImageProcessing:beginImage2 withAmount:slideValue editTag:caseEditButton countInit:countEditUsed];//
    
    countEditUsed=1;
}



- (void) editImage:(id)sender{
    //    [editScrollView setAlpha:0.f];
    CGRect animationUpFrame;
    CGRect animationDownFrame;
    if (resolutionDisplay==0) {
         animationUpFrame=CGRectMake(0, 400, editScrollView.frame.size.width, editScrollView.frame.size.height);
         animationDownFrame=CGRectMake(effectScrollView.frame.origin.x, 500, editScrollView.frame.size.width, editScrollView.frame.size.height);
    }else if (resolutionDisplay==1)
    {
         animationUpFrame=CGRectMake(0, 488, editScrollView.frame.size.width, editScrollView.frame.size.height);
         animationDownFrame=CGRectMake(effectScrollView.frame.origin.x, 588, editScrollView.frame.size.width, editScrollView.frame.size.height);
    }
  
    //    animationFrame.origin.y -=100;e
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionTransitionCurlDown animations:^{
        
        effectScrollView.frame=animationDownFrame;
    }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.75f delay:0.f options:UIViewAnimationOptionTransitionCurlUp animations:^{
                             //        [editScrollView setAlpha:0.f];
                             editScrollView.frame=animationUpFrame;
                         }
                                          completion:nil];
                     }];
    UIImage *editImage=[UIImage imageNamed:@"enhancetoolactive@2x.png"];
    UIImage *effectImage=[UIImage imageNamed:@"edit-filtertool@2x.png"];
    [btnEffectImage setBackgroundImage:effectImage forState:UIControlStateNormal];
    [btnEditImage setBackgroundImage:editImage forState:UIControlStateNormal];
    imageSliderView.hidden=YES;
    effectScrollView.hidden=NO;
    editScrollView.hidden=NO;
    
    NSArray *editFilterName = @[@"Brightness", @"Sharpeness",
                                @"Contrast",@"Exposure",@"Saturation",@"Vignette",@"Effect"];
    
    NSArray *filterValue = @[[NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:1.0],
                             [NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:1.0],
                             [NSNumber numberWithFloat:-2.0],
                             [NSNumber numberWithInt:0]];
    
    NSMutableDictionary *tempDict=[NSMutableDictionary dictionaryWithObjects:filterValue forKeys:editFilterName];;
    if(countEditUsed==0){
        viewEditFilterDict = [NSMutableDictionary dictionaryWithObjects:filterValue forKeys:editFilterName];
    }
    else{
        viewEditFilterDict=imageEditProcessing.allEditFilter;
        float tempValue=[[imageEditProcessing.allEditFilter objectForKey:@"Vignette"] floatValue];
        if(tempValue >0){
            tempValue=-tempValue;
        }
        
        [viewEditFilterDict setObject:[NSNumber numberWithFloat:tempValue] forKey:@"Vignette"];
        
        NSLog(@"temp dict%@",tempDict);
        for(int i=0;i<6;i++){
            UIImageView *tempSideBar = (UIImageView *)[self.view viewWithTag:30+i];
            if ([[viewEditFilterDict objectForKey:[editFilterName objectAtIndex:i]] floatValue]!=[[tempDict objectForKey:[editFilterName objectAtIndex:i]] floatValue]) {
                tempSideBar.image=[UIImage imageNamed:@"sidebar-background.png"];
            }
            else{
                tempSideBar.image=[UIImage imageNamed:@"sidebar-background-normal.png"];
            }
            
        }
    }
    NSLog(@"%@",viewEditFilterDict);
    
    
    
    
}


- (void) effectImage:(id)sender{
    CGRect animationDownFrame;CGRect animationUpFrame;
    if (resolutionDisplay==0) {
        animationDownFrame=CGRectMake(0,500, editScrollView.frame.size.width, editScrollView.frame.size.height);
        animationUpFrame=CGRectMake(effectScrollView.frame.origin.x, 400, editScrollView.frame.size.width, editScrollView.frame.size.height);
    }else if (resolutionDisplay==1)
    {
        animationDownFrame=CGRectMake(0,588, editScrollView.frame.size.width, editScrollView.frame.size.height);
        animationUpFrame=CGRectMake(effectScrollView.frame.origin.x, 488, editScrollView.frame.size.width, editScrollView.frame.size.height);
    
    }
    
    //    animationFrame.origin.y -=100;e
    [UIView animateWithDuration:0.2f delay:0.f options:UIViewAnimationOptionTransitionCurlDown animations:^{
        editScrollView.frame=animationDownFrame;
        
        
    }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.75f delay:0.f options:UIViewAnimationOptionTransitionCurlUp animations:^{
                             //        [editScrollView setAlpha:0.f];
                             effectScrollView.frame=animationUpFrame;
                         }
                                          completion:nil];
                     }];
    UIImage *editImage=[UIImage imageNamed:@"edit-enhancetool@2x.png"];
    UIImage *effectImage=[UIImage imageNamed:@"filtertoolactive@2x.png"];
    [btnEffectImage setBackgroundImage:effectImage forState:UIControlStateNormal];
    [btnEditImage setBackgroundImage:editImage forState:UIControlStateNormal];
    imageSliderView.hidden=YES;
    effectScrollView.hidden=NO;
    editScrollView.hidden=NO;
}







//-------------------------------------------
//crop image
/*
 dvduongth copyright 2014
 */

- (UIImage *) cropImageMethod:(UIImage *)imageResizedToCrop
{
    UIImage *croppedImage;
    
    float topEdgePosition = CGRectGetMinY(lkBoundView.frame);
    
    CGRect croppedRect;
    
    //   CGFloat variableToCropHeight = (imageResizedToCrop.size.height/410.0);
    
    if (_lkDownStatus) {
        croppedRect = CGRectMake(0, topEdgePosition - 64, 320, 320);
    }else{
    croppedRect = CGRectMake(0, topEdgePosition - 44, 320, 320);
    }
    CGImageRef tmp = CGImageCreateWithImageInRect([imageResizedToCrop CGImage], croppedRect);
    croppedImage = [UIImage imageWithCGImage:tmp];
    CGImageRelease(tmp);
    
    
    NSData *CroppedImageData = UIImageJPEGRepresentation(croppedImage, 1.0);
    NSData *imageData = UIImageJPEGRepresentation(imageResizedToCrop, 1.0);
    
    
    NSInteger imageToCropDataSize = imageData.length;
    
    NSLog(@"original size %d Bytes", imageToCropDataSize);
    NSLog(@"Resault crop size %d Bytes", CroppedImageData.length);
    
    return croppedImage;
}


//resizeImage for storage
- (UIImage *) resizeImage {
    UIImage *imageResault;
    //call resize image class
    resizeImage *imageResize = [[resizeImage alloc]init];
    imageResault = [imageResize resizeImage:imageToResize width:320 height:lkHeight];
    NSData *resizedImageData = [imageResize thumbnailImageData];
    
    
    //    imageView.image = [UIImage imageWithData:resizedImageData];
    
    //    if (lkChooseType ==1) {
    //        imageView.center =CGPointMake(imageView.frame.size.width/2, imageView.frame.size.height/2);
    //        imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    //    }
    
    
    // imageView.image = [imageView.image fixOrientation];
    //hien thi kich thuoc sau khi resize
    NSInteger resizedImageDataSize = resizedImageData.length;
    NSLog(@"resized size %d Bytes", resizedImageDataSize);
    NSLog(@"resault resize width %f height %f", imageResault.size.width,imageResault.size.height);
    return imageResault;
    
}

// truyen du lieu sang share view
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShareView"]) {
        ShareViewController *destination = segue.destinationViewController;
        destination.lkImage = imageView.image;
        destination.lkViewControllerFromFilter = lkViewController;
        
    }
    //    if ([segue.identifier isEqualToString:@"BackCrop"]) {
    //
    //        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Did u really want to back crop view controller" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    //        [av show];
    //        countEditUsed=0;
    //        countEffectUsed=0;
    ////        beginUIImage=imageView.image;
    //        NSLog(@"Back to crop");
    //        ViewController *destination = segue.destinationViewController;
    //        destination.lkBackImage = lkViewController.imageView.image;
    //        destination.lkTabBar = lkViewController.tabBarController;
    //
    //    }
}

- (IBAction)backCropViewController:(id)sender {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"DISCARD EDITS?" message:@"If you go back now,your image edits will be discarded(Bạn sẽ mất ảnh đã chỉnh sửa)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [av show];
    //    ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"cropViewController"];
    //    [self.navigationController pushViewController:controller animated:YES];
    //   [self presentViewController:controller animated:YES completion:nil];
    //    controller.lkBackImage = lkViewController.imageView.image;
    //    controller.lkTabBar = lkViewController.tabBarController;
    //    ViewController *destination = segue.destinationViewController;
    //    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main.storyboard"
    //                                                             bundle: nil];
    //    ViewController *controller = (ViewController*)[mainStoryboard
    //                                                             instantiateViewControllerWithIdentifier: @"ViewController"];
    //    [self presentViewController:controller animated:YES completion:nil];
    
}

//--------------------------------
//@author dvduongth
-(BOOL)hidesBottomBarWhenPushed
{
    return YES;
}


//---------


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1){
        NSLog(@"vào dc 1 của alertview");
        ViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"cropViewController"];
        [self.navigationController pushViewController:controller animated:YES];
        [self presentViewController:controller animated:YES completion:nil];
        controller.lkBackImage = lkViewController.imageView.image;
        controller.lkTabBar = lkViewController.tabBarController;
        countEditUsed=0;
        countEffectUsed=0;
    }
    
}
@end
