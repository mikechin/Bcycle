//
//  Annotations.h
//  Bcycle
//
//  Created by rising on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Annotations : NSObject < MKAnnotation >

@property (strong, nonatomic) NSNumber *bikesAvailable;
@property (strong, nonatomic) NSNumber *docksAvailable;
@property (strong, nonatomic) NSNumber *docksTotal;

- (id)initWithAnnotation:(CLLocationCoordinate2D)newCoordinate title:(NSString *)title;

@end
