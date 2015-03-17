//
//  MapViewDelegate.m
//  Bcycle
//
//  Created by rising on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Annotations.h"

@implementation ViewController (MKMapViewDelegate)

#pragma mark - map view delegate methods.

- (MKPinAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
	// if pin is the user's location pin, return to use default view.
	if(annotation == map.userLocation)
		return nil;
	
	NSString *PinIdentifier = @"Location";
	MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:PinIdentifier];
	
	if(!annotationView)	{
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:PinIdentifier];
		
		// display when it is tapped.
		annotationView.canShowCallout = YES;
	}
	
	return annotationView;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
	return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKPinAnnotationView *)view
{
	if(dockView.hidden) {
		// animate table view and button.
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDuration:0.4];
		
		[dockView setHidden:NO];
		[dockView setFrame:CGRectMake(0, 370, 320, 90)];
		
		[UIView commitAnimations];
	}
	else {
		[balloonTimer invalidate];
	}
	
	Annotations *pin = view.annotation;
	
	dockName.text = pin.title;
	dockStatus.text = [NSString stringWithFormat:@"%@/%@", pin.bikesAvailable, pin.docksTotal];
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
	if(balloonTimer)
		[balloonTimer invalidate];
	
	balloonTimer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(closeDockView:) userInfo:nil repeats:NO];
}

- (void)closeDockView:(NSTimer *)timer
{
	// animate table view and button.
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.4];
	
	[dockView setFrame:CGRectMake(0, 460, 320, 0)];
	
	[UIView commitAnimations];
	
	double delayInSeconds = 0.4;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[dockView setHidden:YES];
	});
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
}


@end
