//
//  Annotations.m
//  Bcycle
//
//  Created by rising on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Annotations.h"

@implementation Annotations

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize bikesAvailable = _bikesAvailable;
@synthesize docksAvailable = _docksAvailable;
@synthesize docksTotal = _docksTotal;

- (id)initWithAnnotation:(CLLocationCoordinate2D)newCoordinate title:(NSString *)title
{
	self = [super init];
	if(self) {
		_coordinate = newCoordinate;
		_title = [[NSString alloc] initWithString:title];
	}
	return self;
}

@end
