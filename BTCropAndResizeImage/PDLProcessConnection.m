//
//  PDLConnection.m
//  Example3
//
//  Created by Dinh Luong on 7/29/26 H.
//  Copyright (c) 26 Heisei Dinh Luong. All rights reserved.
//

#import "PDLProcessConnection.h"

@implementation PDLProcessConnection
@synthesize receivedData = _receivedData;
@synthesize token = _token;
@synthesize photos = _photos;
@synthesize conn1 = _conn1;
@synthesize conn2 = _conn2;

-(id) init{
    _receivedData = [[NSMutableData alloc] init];
    _token = [[NSString alloc] init];
    [self startConnection];
    return self;
    
}
-(void) startConnection {
    NSString *postString = [NSString stringWithFormat:@"http://beta.pashadelic.com/api/v1/sessions.json?username=dinhluong92&password=dinhluong92"];
    NSMutableURLRequest *_request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    [_request setHTTPMethod:@"POST"];
    _conn1 = [[NSURLConnection alloc] initWithRequest:_request delegate:self startImmediately:YES];
    [_conn1 start];
}


-(NSMutableArray *) getDataFromObject:(PDLProcessConnection *)processConnection
{

    return processConnection.photos;

}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [_receivedData setLength:0.0];

}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_receivedData appendData:data];

}

-(void) connectionDidFinishLoading:(NSURLConnection *)connection{

    if (connection == _conn1) {
        NSError *er = nil;
        NSMutableDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:_receivedData options:kNilOptions error:&er];
        NSDictionary *secondDict = [dataDictionary objectForKey:@"data"];
        _token= [secondDict objectForKey:@"auth_token"];
        NSString *postString = [NSString stringWithFormat:@"http://beta.pashadelic.com/api/v1/countries/1233/photos.json"];
        NSMutableURLRequest *_request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:postString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        [_request setHTTPMethod:@"GET"];
        [_request setValue:_token  forHTTPHeaderField:@"X-AUTH-TOKEN"];
        _conn2 = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
        [_conn2 start];
        [_conn1 cancel];
    }
    if (connection == _conn2) {
        NSError *er = nil;
        NSMutableDictionary *finalData = [NSJSONSerialization JSONObjectWithData:_receivedData options:kNilOptions error:&er];
        NSMutableDictionary *dataDict = [finalData objectForKey:@"data"];
        NSMutableArray *dataArray = [dataDict objectForKey:@"photos"];
        _photos = [[NSMutableArray alloc] init];
        for (int i = 0; i < dataArray.count; i++) {
            NSMutableDictionary *dictTemp = [dataArray objectAtIndex:i];
            PDLPhotos *newObject = [[PDLPhotos alloc] initFromDictionary: dictTemp];
            [_photos addObject:newObject];
    }

    }

}
@end
