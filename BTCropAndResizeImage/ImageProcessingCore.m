//
//  ImageProcessingCore.m
//  ArtCameraPro
//
//  Created by phonex on 7/27/14.
//  Copyright (c) 2014 DanielDuong. All rights reserved.
//

#import "ImageProcessingCore.h"
#import "UIImage+FiltrrCompositions.h"
#import "GPUImage.h"
#import "testViewController.h"
@implementation ImageProcessingCore

//NSMutableDictionary *allEditFilter;
//CIFilter *lighten,*sharpen,*contrast;
UIImageOrientation orientation; // New!
GPUImageBrightnessFilter *lighten;
GPUImageContrastFilter *contrast;
GPUImageSharpenFilter *sharpen;
GPUImageExposureFilter *exposure;
GPUImageSaturationFilter *saturation;
GPUImageVignetteFilter *vignette;
NSArray *editFilterName ;NSArray *filterValue;

@synthesize allEditFilter;
//int countInit=0;
-(void) initVarialbe
{
    editFilterName = @[@"Brightness", @"Sharpeness",
                       @"Contrast",@"Exposure",@"Saturation",@"Vignette",@"Effect"];
    filterValue = @[[NSNumber numberWithFloat:0.0],
                    [NSNumber numberWithFloat:0.0],
                    [NSNumber numberWithFloat:1.0],
                    [NSNumber numberWithFloat:0.0],
                    [NSNumber numberWithFloat:1.0],
                    [NSNumber numberWithFloat:2.0],
                    [NSNumber numberWithInt:0]];
    allEditFilter = [NSMutableDictionary dictionaryWithObjects:filterValue forKeys:editFilterName];
    
}

-(UIImage *)editImageProcessing:(UIImage *)imageViewController withAmount:(float)intensity editTag:(int ) tag countInit:(int) countInit{
    
    if (countInit==0) {
        [self initVarialbe];
    }
    
    GPUImagePicture *inputPicture = [[GPUImagePicture alloc] initWithImage:imageViewController smoothlyScaleOutput:NO];
    
    
    lighten = [[GPUImageBrightnessFilter alloc] init];
    contrast = [[GPUImageContrastFilter alloc] init];
    sharpen = [[GPUImageSharpenFilter alloc] init];
    exposure=[[GPUImageExposureFilter alloc] init];
    saturation = [[GPUImageSaturationFilter alloc ] init];
    vignette =[[GPUImageVignetteFilter alloc ]init];
    
    
    //   UIColor *color=
    //    vignette.vignetteColor=[UIColor whiteColor];
    UIImage *outputUIImage;
    //    imageCIEditProcessing = [CIImage imageWithCGImage:imageViewController.CGImage];
    switch (tag) {
        case 2:
            [allEditFilter setObject: [NSNumber numberWithFloat:intensity] forKey:@"Brightness"];
            //            NSLog(@"%@",allEditFilter);
            
            NSLog(@"gia tri float bright %f",[[allEditFilter objectForKey:@"Brightness"] floatValue ]);
            lighten.brightness=[[allEditFilter objectForKey:@"Brightness"] floatValue];
            sharpen.sharpness=[[allEditFilter objectForKey:@"Sharpeness"] floatValue];
            contrast.contrast=[[allEditFilter objectForKey:@"Contrast"] floatValue];
            exposure.exposure=[[allEditFilter objectForKey:@"Exposure"] floatValue];
            saturation.saturation=[[allEditFilter objectForKey:@"Saturation"] floatValue];
            
            vignette.vignetteEnd=[[allEditFilter objectForKey:@"Vignette"] floatValue];
            
            
            [inputPicture addTarget:lighten];
            [lighten addTarget:sharpen];
            [sharpen addTarget:exposure];
            [exposure addTarget:saturation];
            [saturation addTarget:vignette];
            [vignette addTarget:contrast];
            [inputPicture processImage];
            [contrast useNextFrameForImageCapture];
            
            break;
        case 3:
            [allEditFilter setObject: [NSNumber numberWithFloat:intensity] forKey:@"Sharpeness"];
            //            NSLog(@"%@",allEditFilter);
            lighten.brightness=[[allEditFilter objectForKey:@"Brightness"] floatValue];
            sharpen.sharpness=[[allEditFilter objectForKey:@"Sharpeness"] floatValue];
            contrast.contrast=[[allEditFilter objectForKey:@"Contrast"] floatValue];
            exposure.exposure=[[allEditFilter objectForKey:@"Exposure"] floatValue];
            saturation.saturation=[[allEditFilter objectForKey:@"Saturation"] floatValue];
            vignette.vignetteEnd=[[allEditFilter objectForKey:@"Vignette"] floatValue];
            
            
            [inputPicture addTarget:lighten];
            [lighten addTarget:sharpen];
            [sharpen addTarget:exposure];
            [exposure addTarget:saturation];
            [saturation addTarget:vignette];
            [vignette addTarget:contrast];
            [inputPicture processImage];
            [contrast useNextFrameForImageCapture];
            
            
            break;
        case 4:
            [allEditFilter setObject: [NSNumber numberWithFloat:intensity] forKey:@"Contrast"];
            //            NSLog(@"%@",allEditFilter);
            lighten.brightness=[[allEditFilter objectForKey:@"Brightness"] floatValue];
            sharpen.sharpness=[[allEditFilter objectForKey:@"Sharpeness"] floatValue];
            contrast.contrast=[[allEditFilter objectForKey:@"Contrast"] floatValue];
            exposure.exposure=[[allEditFilter objectForKey:@"Exposure"] floatValue];
            saturation.saturation=[[allEditFilter objectForKey:@"Saturation"] floatValue];
            vignette.vignetteEnd=[[allEditFilter objectForKey:@"Vignette"] floatValue];
            
            
            [inputPicture addTarget:lighten];
            [lighten addTarget:sharpen];
            [sharpen addTarget:exposure];
            [exposure addTarget:saturation];
            [saturation addTarget:vignette];
            [vignette addTarget:contrast];
            [inputPicture processImage];
            [contrast useNextFrameForImageCapture];
            
            
            break;
            
        case 5:
            [allEditFilter setObject: [NSNumber numberWithFloat:intensity] forKey:@"Exposure"];
            //            NSLog(@"%@",allEditFilter);
            lighten.brightness=[[allEditFilter objectForKey:@"Brightness"] floatValue];
            sharpen.sharpness=[[allEditFilter objectForKey:@"Sharpeness"] floatValue];
            contrast.contrast=[[allEditFilter objectForKey:@"Contrast"] floatValue];
            exposure.exposure=[[allEditFilter objectForKey:@"Exposure"] floatValue];
            saturation.saturation=[[allEditFilter objectForKey:@"Saturation"] floatValue];
            vignette.vignetteEnd=[[allEditFilter objectForKey:@"Vignette"] floatValue];
            
            
            [inputPicture addTarget:lighten];
            [lighten addTarget:sharpen];
            [sharpen addTarget:exposure];
            [exposure addTarget:saturation];
            [saturation addTarget:vignette];
            [vignette addTarget:contrast];
            [inputPicture processImage];
            [contrast useNextFrameForImageCapture];
            
            
            break;
        case 6:
            
            [allEditFilter setObject: [NSNumber numberWithFloat:intensity] forKey:@"Saturation"];
            //            NSLog(@"%@",allEditFilter);
            lighten.brightness=[[allEditFilter objectForKey:@"Brightness"] floatValue];
            sharpen.sharpness=[[allEditFilter objectForKey:@"Sharpeness"] floatValue];
            contrast.contrast=[[allEditFilter objectForKey:@"Contrast"] floatValue];
            exposure.exposure=[[allEditFilter objectForKey:@"Exposure"] floatValue];
            saturation.saturation=[[allEditFilter objectForKey:@"Saturation"] floatValue];
            vignette.vignetteEnd=[[allEditFilter objectForKey:@"Vignette"] floatValue];
            
            
            [inputPicture addTarget:lighten];
            [lighten addTarget:sharpen];
            [sharpen addTarget:exposure];
            [exposure addTarget:saturation];
            [saturation addTarget:vignette];
            [vignette addTarget:contrast];
            [inputPicture processImage];
            [contrast useNextFrameForImageCapture];
            
            break;
            
            
        case 7:
            
            [allEditFilter setObject: [NSNumber numberWithFloat:-intensity] forKey:@"Vignette"];
            //            NSLog(@"%@",allEditFilter);
            lighten.brightness=[[allEditFilter objectForKey:@"Brightness"] floatValue];
            sharpen.sharpness=[[allEditFilter objectForKey:@"Sharpeness"] floatValue];
            contrast.contrast=[[allEditFilter objectForKey:@"Contrast"] floatValue];
            exposure.exposure=[[allEditFilter objectForKey:@"Exposure"] floatValue];
            saturation.saturation=[[allEditFilter objectForKey:@"Saturation"] floatValue];
            vignette.vignetteEnd=[[allEditFilter objectForKey:@"Vignette"] floatValue];
            
            
            [inputPicture addTarget:lighten];
            [lighten addTarget:sharpen];
            [sharpen addTarget:exposure];
            [exposure addTarget:saturation];
            [saturation addTarget:vignette];
            [vignette addTarget:contrast];
            [inputPicture processImage];
            [contrast useNextFrameForImageCapture];
            
            
            break;
        default:
            break;
    }
    
    
    
    
    outputUIImage = [contrast imageFromCurrentFramebufferWithOrientation:UIImageOrientationUp];
    
    return outputUIImage;
}


-(UIImage *)effectImageProcessing:(UIImage *)imageViewController editTag:(int ) tag{
    switch (tag) {
            
        case 3:
            imageViewController=[imageViewController e1];
            
            [allEditFilter setObject:[NSNumber numberWithInt:1] forKey:@"Effect"];
            break;
        case 4:
            imageViewController=[imageViewController  e2];
            
            [allEditFilter setObject: [NSNumber numberWithInt:2] forKey:@"Effect"];
            break;
        case 5:
            [allEditFilter setObject: [NSNumber numberWithInt:3] forKey:@"Effect"];
            imageViewController=[imageViewController e3];
            
            
            break;
        case 6:
            [allEditFilter setObject: [NSNumber numberWithInt:4] forKey:@"Effect"];
            imageViewController=[imageViewController e4];
            
            break;
        case 7:
            [allEditFilter setObject: [NSNumber numberWithInt:5] forKey:@"Effect"];
            imageViewController=[imageViewController  e5];
            
            break;
        case 8:
            [allEditFilter setObject: [NSNumber numberWithInt:6] forKey:@"Effect"];
            imageViewController=[imageViewController  e6];
            
            break;
        case 9:
            [allEditFilter setObject: [NSNumber numberWithInt:7] forKey:@"Effect"];
            imageViewController=[imageViewController  e7];
            //            imageView.image=imageViewController;
            break;
        case 10:
            [allEditFilter setObject: [NSNumber numberWithInt:8] forKey:@"Effect"];
            imageViewController=[imageViewController  e8];
            //            imageView.image=imageViewController;
            break;
        case 11:
            [allEditFilter setObject: [NSNumber numberWithInt:9] forKey:@"Effect"];
            imageViewController=[imageViewController  e9];
            //            imageView.image=imageViewController;
            break;
        case 12:
            [allEditFilter setObject: [NSNumber numberWithInt:10] forKey:@"Effect"];
            imageViewController=[imageViewController e10];
            //            imageView.image=imageViewController;
            break;
        case 13:
            [allEditFilter setObject: [NSNumber numberWithInt:11] forKey:@"Effect"];
            imageViewController=[imageViewController e11];
            //            imageView.image=imageViewController;
            break;
            
        default:
            break;
            
    }
    return imageViewController;
    
}
@end
