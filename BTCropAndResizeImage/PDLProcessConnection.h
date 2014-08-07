//
//  PDLConnection.h
//  Example3
//
//  Created by Dinh Luong on 7/29/26 H.
//  Copyright (c) 26 Heisei Dinh Luong. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "PDLConnection.h"
#import "PDLPhotos.h"
@interface PDLProcessConnection : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (nonatomic,strong) NSMutableData *receivedData;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSMutableArray *photos;
@property (nonatomic,strong) NSURLConnection *conn1;
@property (nonatomic,strong) NSURLConnection *conn2;
-(id) init;

-(void) startConnection;

-(NSMutableArray *) getDataFromObject : (PDLProcessConnection *) processConnection;

@end
