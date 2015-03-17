//
//  ViewController.m
//  Bcycle
//
//  Created by rising on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Annotations.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self) {
		api = [[Api alloc] init];
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// load screen.
	[loadingView setHidden:NO];
	[self.view bringSubviewToFront:loadingView];
	
	// wait for notification that data has been received and call selector.
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(populate:) name:@"kBData" object:nil];
	[api q:@"ListKiosks"];
	
	// instantiate menu view.
	menuView = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
	[menuView.view setFrame:CGRectMake(0, 0, 270, 460)];
	[self.view insertSubview:menuView.view belowSubview:mapView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)populate:(NSNotification *)notification
{
	// remove notification observer.
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"kBData" object:nil];
	
	[self centerMap];
	
	// loop every location. every. location.
	for(NSDictionary *locationData in api.data) {
		if([[[locationData objectForKey:@"Address"] objectForKey:@"City"] isEqualToString:@"Denver"]) {
			CLLocationCoordinate2D location;
			location.latitude = [[[locationData objectForKey:@"Location"] objectForKey:@"Latitude"] doubleValue];
			location.longitude = [[[locationData objectForKey:@"Location"] objectForKey:@"Longitude"] doubleValue];

			Annotations *pin = [[Annotations alloc] initWithAnnotation:location title:[locationData objectForKey:@"Name"]];
			pin.bikesAvailable = [locationData objectForKey:@"BikesAvailable"];
			pin.docksAvailable = [locationData objectForKey:@"DocksAvailable"];
			pin.docksTotal = [locationData objectForKey:@"TotalDocks"];
			
			[map addAnnotation:pin];
		}
	}

	// load screen.
	[self.view sendSubviewToBack:loadingView];
	[loadingView setHidden:YES];	
}

- (void)centerMap
{
	CLLocationCoordinate2D location;
	location.latitude = 39.735046;
	location.longitude = -104.960632;
	
	MKCoordinateRegion region = MKCoordinateRegionMake(location, MKCoordinateSpanMake(0.1, 0.1));
	[map setRegion:region];
}

- (void)showMenu
{
	float x = 0;
	if(menuView.view.tag == 0) {
		x = 270;
		
		menuView.view.tag = 1;
	}
	else if(menuView.view.tag == 1) {
		x = 0;

		menuView.view.tag = 0;
	}
	
	CGRect mapFrame = mapView.frame;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.1];
	[mapView setFrame:CGRectMake(x, mapFrame.origin.y, mapFrame.size.width, mapFrame.size.height)];	
	[UIView commitAnimations];
}

#pragma mark - screen rotation.

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	}
	else {
	    return YES;
	}
}

@end
