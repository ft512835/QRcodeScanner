//
//  ShareCheckinViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 02/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "ShareCheckinViewController.h"

@interface ShareCheckinViewController ()
- (void) animateUserArrow;
@end

@implementation ShareCheckinViewController
@synthesize mapView, locationIndicatorButton, locationIndicatorArrow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Checkin";
    mapView=[[MKMapView alloc]init];
    [mapView setDelegate:self];
    [self.view addSubview:mapView];
    
    locationIndicatorButton=[[UIButton alloc]init];
    [locationIndicatorButton setBackgroundImage:[UIImage imageNamed:@"ball.png"] forState:UIControlStateNormal];
    [locationIndicatorButton setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [locationIndicatorButton addTarget:self action:@selector(findUserOnMap) forControlEvents:UIControlEventTouchUpInside];
    [mapView addSubview:locationIndicatorButton];
    
    Sharebutton=[[UIButton alloc]init];
    [Sharebutton setTitle:@"Share Current location" forState:UIControlStateNormal];
   
    [Sharebutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Sharebutton addTarget:self action:@selector(sharebutton) forControlEvents:UIControlEventTouchUpInside];
    [mapView addSubview:Sharebutton];
    

    // Do any additional setup after loading the view.
}



- (void) updateLocationIndicator
{
    //Is the user off-screen?
    if (self.mapView.userLocationVisible == NO) {
        
        //Enable interaction with the component
        locationIndicatorButton.userInteractionEnabled = YES;
        locationIndicatorArrow.userInteractionEnabled = YES;
        
        //Fade in the component if necessary
        if (locationIndicatorButton.alpha != 1) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [locationIndicatorButton setAlpha:1];
            [locationIndicatorArrow setAlpha:1];
            [UIView commitAnimations];
        }
        
        //Update the component's location and rotation
        [self animateUserArrow];
        
    } else {
        
        //Fade out the component if necessary
        if (locationIndicatorButton.alpha != 0) {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5];
            [locationIndicatorButton setAlpha:0];
            [locationIndicatorArrow setAlpha:0];
            [UIView commitAnimations];
        }
        
        
        //Disable interaction with the component
        locationIndicatorButton.userInteractionEnabled = NO;
        locationIndicatorArrow.userInteractionEnabled = NO;
        
    }
}


-(void)sharebutton
{
    UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"Choose" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes" otherButtonTitles:nil, nil];
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        NSLog(@"g");
    }
       
}



- (void) animateUserArrow
{
    //Determine location of user and center of the map in pixels
    CGPoint user;
    user.x = ((self.mapView.userLocation.coordinate.longitude - self.mapView.region.center.longitude) / self.mapView.region.span.longitudeDelta) * self.mapView.frame.size.width;
    user.y = ((self.mapView.userLocation.coordinate.latitude - self.mapView.region.center.latitude) / self.mapView.region.span.latitudeDelta) * self.mapView.frame.size.height;
    
    //Define the bounding box for the button
    CGPoint bounds = CGPointMake(self.mapView.frame.size.width - 35, self.mapView.frame.size.height - 35);
    
    //Assume the center of the map is the origin point at (0,0)
    //Calculate the angle using trig
    float angle = atanf((user.y/user.x));
    float arrowRotation = 0;
    
    
    CGPoint buttonPosition = CGPointMake(0, 0);
    
    //Determine Quadrant
    if (user.y >= 0) {
        //User is located above center of the screen
        
        if (user.x >= 0) {
            //User is located to the right of the center of the screen
            //TOP RIGHT QUANDRANT
            arrowRotation = 1.57079633 - angle;
            //Determine which value we are aware of
            if (angle < 0.785398163) {
                //Less than 45 degrees, we know x and solve for y
                buttonPosition.x = (bounds.x);
                buttonPosition.y = bounds.y - (((bounds.x / 2) * tanf(angle)) + (bounds.y / 2));
            } else {
                //More than 45 degree, we know y and solve for x
                buttonPosition.y = self.mapView.frame.size.height - bounds.y;
                buttonPosition.x = ((bounds.x / 2) + (0.5 * (bounds.y / (tanf(angle)))));
            }
            
        } else if (user.x < 0) {
            //User is located to the left of the center of the screen
            //TOP LEFT QUANDRANT
            arrowRotation = 4.71238898 - angle;
            //Determine which value we are aware of
            if (angle > -0.785398163) {
                //Less than 45 degrees, we know x and solve for y
                buttonPosition.x = self.mapView.frame.size.width - bounds.x;
                buttonPosition.y = (((bounds.x / 2) * tanf(angle)) + (bounds.y / 2));
            } else {
                //More than 45 degree, we know y and solve for x
                buttonPosition.y = self.mapView.frame.size.height - bounds.y;
                buttonPosition.x = ((bounds.x / 2) + (0.5 * (bounds.y / (tanf(angle)))));
            }
        }
        
    } else if (user.y < 0) {
        //User is located below center of the screen
        
        if (user.x >= 0) {
            //User is located to the right of the center of the screen
            //BOTTOM RIGHT QUANDRANT
            arrowRotation = 1.57079633 - angle;
            //Determine which value we are aware of
            if (angle > -0.785398163) {
                //Less than 45 degrees, we know x and solve for y
                buttonPosition.x = (bounds.x);
                buttonPosition.y = bounds.y - (((bounds.x / 2) * tanf(angle)) + (bounds.y / 2));
            } else {
                //More than 45 degree, we know y and solve for x
                buttonPosition.y = bounds.y;
                buttonPosition.x = ((bounds.x / 2) - (0.5 * (bounds.y / (tanf(angle)))));
            }
            
        } else if (user.x < 0) {
            //User is located to the left of the center of the screen
            //BOTTOM LEFT QUANDRANT
            arrowRotation = 4.71238898 - angle;
            //Determine which value we are aware of
            if (angle < 0.785398163) {
                //Less than 45 degrees, we know x and solve for y
                buttonPosition.x = self.mapView.frame.size.width - bounds.x;
                buttonPosition.y = (((bounds.x / 2) * tanf(angle)) + (bounds.y / 2));
            } else {
                //More than 45 degree, we know y and solve for x
                buttonPosition.y = (bounds.y);
                buttonPosition.x = ((bounds.x / 2) - (0.5 * (bounds.y / (tanf(angle)))));
            }
            
        }
    }
    
    //Constrain buttonPosition to bounds
    if (buttonPosition.x > bounds.x) {
        buttonPosition.x = bounds.x;
    } else if (buttonPosition.x < (self.mapView.frame.size.width - bounds.x)) {
        buttonPosition.x = (self.mapView.frame.size.width - bounds.x);
    }
    
    if (buttonPosition.y > bounds.y) {
        buttonPosition.y = bounds.y;
    } else if (buttonPosition.y < (self.mapView.frame.size.height - bounds.y)) {
        buttonPosition.y = (self.mapView.frame.size.height - bounds.y);
    }
    
    //Set button position, while accounting for the height of the top UISearchBar and size of the graphic
    buttonPosition.x = (buttonPosition.x - (locationIndicatorButton.frame.size.width / 2));
    buttonPosition.y = ((buttonPosition.y /*+ topSearch.frame.size.height*/) - (locationIndicatorButton.frame.size.height / 2));
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    locationIndicatorButton.frame = CGRectMake(buttonPosition.x, buttonPosition.y, locationIndicatorButton.frame.size.width, locationIndicatorButton.frame.size.height);
    [UIView commitAnimations];
    
    
    //Rotate and position arrow
    
    CGPoint arrowPosition = CGPointMake(buttonPosition.x, buttonPosition.y);
    arrowPosition.x += locationIndicatorButton.frame.size.width / 2;
    arrowPosition.y += locationIndicatorButton.frame.size.height / 2;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    locationIndicatorArrow.center = CGPointMake(arrowPosition.x, arrowPosition.y);
    [UIView commitAnimations];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.8];
    
    CGAffineTransform rotate = CGAffineTransformMakeRotation( arrowRotation );
    [locationIndicatorArrow setTransform:rotate];
    
    [UIView commitAnimations];
    
}


- (void)findUserOnMap
{
    
    if (mapView.userLocation.location != nil ) {
        
        //Since this method will display the user's location on-screen, we will pre-emptively fade out the component and disable interaction with it
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.5];
        [locationIndicatorButton setAlpha:0];
        [locationIndicatorArrow setAlpha:0];
        [UIView commitAnimations];
        
        locationIndicatorButton.userInteractionEnabled = NO;
        locationIndicatorArrow.userInteractionEnabled = NO;
        
        MKCoordinateSpan span = mapView.region.span;
        
        MKCoordinateRegion region;
        region.span = span;
        region.center = mapView.userLocation.location.coordinate;
        
        [self.mapView setRegion:region animated:YES];
        
    } else {
        
        //If the user tapped on the location indicator to access this method, then the user location value should never be nil, but this is here in case this method is called in some other way
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Could not find your location" message:@"No user location could be found, please check your phone settings." delegate:nil cancelButtonTitle:@"Ok." otherButtonTitles: nil];
        [alert show];
       
        
    }
}

- (void) dealloc
{
    self.mapView = nil;
    self.locationIndicatorArrow = nil;
    self.locationIndicatorButton = nil;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //Update location indicator
    [self updateLocationIndicator];
    
}


- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self updateLocationIndicator];
}

-(void)viewWillAppear:(BOOL)animated
{
    if(([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) || ([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeRight))
    {
        [self willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft duration:2];
        [self willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationLandscapeRight duration:2];
        
    }
    else
    {
        [self willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:2];
        [self willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortraitUpsideDown duration:2];
        
    }
}

-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
        }
        else
        {
            
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
            
        }
        else
        {
            mapView.frame=CGRectMake(00, 60, 320,508);
            locationIndicatorButton.frame=CGRectMake(150, 250, 30, 30);
           
            Sharebutton.frame=CGRectMake(20, 200, 200, 40);
            
            
        }
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
