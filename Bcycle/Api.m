//
//  Api.m
//  Bcycle
//
//  Created by rising on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Api.h"

#define kDataHost @"http://api.bcycle.com/services/mobile.svc/"

@implementation Api

@synthesize data = _data;
@synthesize isQuerying = _isQuerying;

- (void)q:(NSString *)query
{
	if(_isQuerying)
		return;
	
	_isQuerying = NO;
	
	query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kDataHost, query]];
	[self startBackground:url];
}

- (void)cancel
{
	if(_isQuerying) {
		[_conn cancel];
		_isQuerying = NO;
	}
}

- (void)startBackground:(NSURL *)url
{
	_isQuerying = YES;
	
	_responseData = [NSMutableData data];
	
	// Setup and start async download
	NSURLRequest *_req = [NSURLRequest requestWithURL:url];
	_conn = [[NSURLConnection alloc] initWithRequest:_req delegate:self];        
}

- (void)parseResponse
{
	NSError *error = nil;
	NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];

	_data = [[dict objectForKey:@"d"] objectForKey:@"list"];
	
	NSLog(@"%@", _data);
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"kBData" object:nil];
	
	_isQuerying = NO;
}

#pragma mark - connection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	[_responseData setLength: 0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)cdata
{
	[_responseData appendData:cdata];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	[self parseResponse];
}

@end
