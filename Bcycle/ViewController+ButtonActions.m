//
//  ViewController+ButtonActions.m
//  Bcycle
//
//  Created by rising on 6/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController+ButtonActions.h"

@implementation ViewController (ButtonActions)

- (IBAction)menuAction:(id)sender
{
	NSLog(@"action!");
}

- (IBAction)menuPan:(UIPanGestureRecognizer *)recognizer
{
	CGPoint translation = [recognizer translationInView:self.view];
	
	if(translation.x < 0)
		mapView.tag = -1;
	else if(translation.x > 0)
		mapView.tag = 1;

	CGRect mapFrame = mapView.frame;
	[mapView setFrame:CGRectMake(mapFrame.origin.x+translation.x, mapFrame.origin.y, mapFrame.size.width, mapFrame.size.height)];
	[recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
	
	NSLog(@"%d", mapView.tag);
	NSLog(@"%f", mapFrame.origin.x);

	if(recognizer.state == UIGestureRecognizerStateEnded) {
		// right.
		if(menuView.view.tag == 0) {
			if(mapFrame.origin.x >= 30.0 && mapView.tag < 0) {
				menuView.view.tag = 1;
			}			
		}
		// left.
		else if(menuView.view.tag == 1) {
			if(mapFrame.origin.x <= 240.0 && mapView.tag > 0) {
				menuView.view.tag = 0;
			}			
		}
		
		[self showMenu];
	}
}

@end
