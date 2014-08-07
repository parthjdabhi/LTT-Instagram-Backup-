//
//  resizeImage.m
//  BTCropAndResizeImage
//
//  Created by MAC on 7/16/14.
//  Copyright (c) 2014 DanielDuong. All rights reserved.
//

#import "resizeImage.h"

@implementation resizeImage

-(UIImage *)resizeImage:(UIImage *)image width:(CGFloat)widthResize height:(CGFloat)heightResize
{
    UIGraphicsBeginImageContext(CGSizeMake(widthResize, heightResize));
    [image drawInRect:CGRectMake(0, 0, widthResize, heightResize)];
    resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resized;
}
-(NSData *)thumbnailImageData
{
    thumbnailImageData = UIImageJPEGRepresentation(resized, 1.0);
    return thumbnailImageData;
}

@end
