//
//  PDLPhotos.h
//  Example3
//
//  Created by Dinh Luong on 7/22/26 H.
//  Copyright (c) 26 Heisei Dinh Luong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PDLPhotos : NSObject
@property (strong,nonatomic) NSString *ids;
@property (strong, nonatomic) NSString *avatar;
@property (strong, nonatomic) NSString *username;
@property (strong,nonatomic) NSString *dateTaken;
@property (strong, nonatomic) NSString  *title;
@property (strong, nonatomic) NSString *bigPhoto;
@property (retain, nonatomic) NSNumber *width;
@property (retain,nonatomic) NSNumber *height;
-(id) initFromDictionary : (NSMutableDictionary *) dictionary;
@end
