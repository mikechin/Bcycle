//
//  ViewController.h
//  Bcycle
//
//  Created by rising on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MenuViewController.h"
#import "Api.h"

@interface ViewController : UIViewController < MKMapViewDelegate >
{
	MenuViewController *menuView;
	
	IBOutlet MKMapView *map;
	IBOutlet UIView *mapView;
	
	IBOutlet UIView *dockView;
	IBOutlet UILabel *dockName;
	IBOutlet UILabel *dockStatus;
	
	IBOutlet UIView *loadingView;
	
	IBOutlet UIButton *menuButton;
	
	Api *api;
	NSTimer *balloonTimer;
}

- (void)showMenu;

@end
