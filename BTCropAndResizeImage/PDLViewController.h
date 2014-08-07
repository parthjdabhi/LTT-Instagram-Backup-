//
//  PDLViewController.h
//  Example3
//
//  Created by Dinh Luong on 7/22/26 H.
//  Copyright (c) 26 Heisei Dinh Luong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDLViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate,NSURLConnectionDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *onLoadIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableData *receivedData;
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSURLConnection *conn1;
@property (nonatomic,strong) NSURLConnection *conn2;
- (IBAction)reloadData:(id)sender;
- (IBAction)DeleteCache:(id)sender;


//author dvduongth
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end
