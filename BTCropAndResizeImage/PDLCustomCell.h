//
//  PDLCustomCell.h
//  Example3
//
//  Created by Dinh Luong on 7/22/26 H.
//  Copyright (c) 26 Heisei Dinh Luong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDLPhotos.h"
@interface PDLCustomCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *labelUser;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *avatarIndicator;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIImageView *smallImageView;
@property int heightOfCell;

-(void) initiallizFromdictAtIndex : (PDLPhotos *)object andIndex:(NSIndexPath *) indexPath;
@end
