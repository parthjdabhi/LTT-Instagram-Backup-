//
//  ShareViewController.m
//  ThucTap_INSTAGRAM
//
//  Created by MAC on 7/23/14.
//  Copyright (c) 2014 DanielDuong. All rights reserved.
//

#import "ShareViewController.h"
#import "testViewController.h"
#import "mutilpleScreen.h"
@interface ShareViewController ()

@end

@implementation ShareViewController
{
    bool saveEnable;

}



@synthesize lkImage,imageView,textView;
@synthesize lkBack, lkViewControllerFromFilter;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //author dvduongth
    if (IS_IOS7) {
        if (IS_IPHONE_5) {
            NSLog(@"is retina4 ios7 statusbar 20");
            CGRect theFrame;
            //get frame from toolbar to set new location
            theFrame= [_navigationbar frame];
            theFrame.origin.y = 20;
            _navigationbar.frame = theFrame;
            
            theFrame = [_viewMain frame];
            theFrame.origin.y = 64;
            _viewMain.frame = theFrame;
            
        } else{
            NSLog(@"is retina3.5 ios7 statusbar 20");//retina3.5 ios7 //retina4 ios7  -------------3.5inch iOS7
            CGRect theFrame;
            //get frame from toolbar to set new location
            theFrame= [_navigationbar frame];
            theFrame.origin.y = 20;
            _navigationbar.frame = theFrame;

            theFrame = [_viewMain frame];
            theFrame.origin.y = 64;
            _viewMain.frame = theFrame;
            
        }
    }else {
        NSLog(@"ios6"); //480x320

        
    }
    saveEnable = true;
    
    imageView.image = lkImage;
    textView.delegate = self;
    [textView setText:@""];
    [textView setPlaceholder:@"Capption in here. Writte here to share with friends"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//set keboard and return button
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [textView resignFirstResponder];
}

-(BOOL)textViewShouldReturn:(UITextView *)textView
{
    if (self.textView) {
        [self.textView resignFirstResponder];
    }

    return NO;
}

//share to select
#pragma mark share
-(void)shareToInternet:(NSInteger )serviceType
{
    
    NSString *string ;
    switch (serviceType) {
        case 1:{
            
            string = @"Configure an account Facebook in setting";

            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
                composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [composeViewController addImage:imageView.image];
                //textview
                [composeViewController setInitialText:textView.text];
                
                [self presentViewController:composeViewController animated:YES completion:NULL];

            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Account Found" message:string delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alert setAlertViewStyle:UIAlertViewStyleDefault];
                [alert show];
            }

        }
            break;
        case 2:
            string = @"Configure an account Twitter in setting";
        {
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
                composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [composeViewController addImage:imageView.image];
                //textview
                [composeViewController setInitialText:textView.text];

                //textField
                
                [self presentViewController:composeViewController animated:YES completion:NULL];
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Account Found" message:string delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alert setAlertViewStyle:UIAlertViewStyleDefault];
                [alert show];
            }
        }
            break;
        
        case 3:
            string = @"Configure an account SinaWeibo in setting";
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
                composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
                [composeViewController addImage:imageView.image];
                //textview
                [composeViewController setInitialText:textView.text];

                //textField
                
                [self presentViewController:composeViewController animated:YES completion:NULL];
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Account Found" message:string delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
                [alert setAlertViewStyle:UIAlertViewStyleDefault];
                [alert show];
            }
            break;
            
        case 4:
        {
            UIAlertView *LTTTeam8_Upload = [[UIAlertView alloc] initWithTitle:@"UPLOAD TO LTTTeam8_SERVER" message:@"Action for UPLOAD" delegate:self cancelButtonTitle:@"CANCEL" otherButtonTitles:@"UPLOAD", nil];
            [LTTTeam8_Upload setAlertViewStyle:UIAlertViewStyleDefault];
            [LTTTeam8_Upload show];
            break;
        }
        default:
            NSLog(@"None");
            break;
    }

}


//action save image to camera roll
- (IBAction)saveToCameraRollClicked:(id)sender {
    if (saveEnable) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]init];
        actionSheet.delegate = self;
        [actionSheet addButtonWithTitle:@"Save To Camera Roll"];
        //put cancel button the last one
        [actionSheet addButtonWithTitle:@"Cancel"];
        actionSheet.cancelButtonIndex=actionSheet.numberOfButtons -1;
        [actionSheet showInView:[self.view window]];
    }else{
        UIAlertView *message = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Image was exist. Because you've saved it. Try again with an other image." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [message show];
    }
    
    
}

#pragma mark UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Save To Camera Roll"]) {
    if (buttonIndex == 0){
        //save photo
        UIImage *image = imageView.image;
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedPhotosAlbum:didFinishSavingWithError: contextInfo:), nil);
    }
}
-(void)imageSavedPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *message;
    NSString *title;
    if (!error) {
        title = @"";
        message = @"Your Photo was saved to the camera Roll.";
        saveEnable = false;
        
    }else{
        title = @"";
        message = [error description];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}
- (IBAction)FacebookClicked:(id)sender {
    [self shareToInternet:1];
}
- (IBAction)TwitterClicked:(id)sender {
    [self shareToInternet:2];
}
- (IBAction)SinaWeiboClicked:(id)sender {
    [self shareToInternet:3];
}
- (IBAction)LTTTeam8Clicked:(id)sender {
    [self shareToInternet:4];
}

//author dvduongth
//back to filter
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    testViewController *destination = segue.destinationViewController;
    destination.lkBack = 10;
    destination.lkImageShare = imageView.image;
    destination.lkViewController = lkViewControllerFromFilter;
}


@end







