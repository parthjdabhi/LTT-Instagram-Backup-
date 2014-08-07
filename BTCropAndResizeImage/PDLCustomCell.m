//
//  PDLCustomCell.m
//  Example3
//
//  Created by Dinh Luong on 7/22/26 H.
//  Copyright (c) 26 Heisei Dinh Luong. All rights reserved.
//

#import "PDLCustomCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation PDLCustomCell
@synthesize labelDate;
@synthesize labelTitle;
@synthesize labelUser;
@synthesize bigImageView;
@synthesize smallImageView;
@synthesize indicator;
@synthesize progressBar;
@synthesize heightOfCell;
- (void)awakeFromNib
{
    [bigImageView addSubview:indicator];
    [smallImageView addSubview:_avatarIndicator];
    [self addSubview:smallImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // this comment for test
    
    
}

-(void) initiallizFromdictAtIndex:(PDLPhotos *) object andIndex:(NSIndexPath *)indexPath{

    labelUser.text  = [object username];
    labelTitle.text = [object title];
    labelDate.text  = object.dateTaken;
    
    [smallImageView setImageWithURL:
               [NSURL URLWithString:[object avatar]]
                   placeholderImage:[UIImage imageNamed: @""]
                            options:kNilOptions
                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [_avatarIndicator stopAnimating];
        [_avatarIndicator setHidden:YES];
    }];
    
    smallImageView.layer.cornerRadius = 4.0;
    smallImageView.layer.masksToBounds = YES;
      [bigImageView setImageWithURL:
               [NSURL URLWithString:
[object bigPhoto]] placeholderImage:[UIImage imageNamed:@""]
                            options:0
                           progress:^(NSUInteger receivedSize, long long expectedSize)
    {
        
        float number = (float)receivedSize/(float)expectedSize;
        progressBar.progress = number;
        [indicator startAnimating];
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        
        [indicator stopAnimating];
        indicator.hidden = YES;
        progressBar.hidden = YES;
        
    }
     ];
   
    
    int width = [object width].intValue;
    int height = [object height].intValue;
    
    if (width < 320)
    {
        heightOfCell =  height+50;
    }
    
    float factor = (float)height/(float)width;
    
    heightOfCell = (int)((320.0*factor)+50);
}

@end
