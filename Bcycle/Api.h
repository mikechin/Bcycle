//
//  Api.h
//  Bcycle
//
//  Created by rising on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Api : NSObject {
	NSURLConnection *_conn;
	NSMutableData *_responseData;
}

@property (assign, nonatomic) NSDictionary *data;
@property (assign, nonatomic) BOOL isQuerying;

- (void)q:(NSString *)query;
- (void)cancel;

@end
