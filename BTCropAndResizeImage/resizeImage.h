//
//  resizeImage.h
//  BTCropAndResizeImage
//
//  Created by MAC on 7/16/14.
//  Copyright (c) 2014 DanielDuong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface resizeImage : NSObject
{
    NSData *thumbnailImageData;
    UIImage *resized;
}

- (UIImage *)resizeImage:(UIImage *)image width:(CGFloat)widthResize height:(CGFloat)heightResize;
- (NSData *)thumbnailImageData;

@end
