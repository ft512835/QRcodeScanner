//
//  CheckinViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 01/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface CheckinViewController : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate>
{
    UITextField *SearchTF;
    UIScrollView *Scrollview;;
    UIButton *CancelButton;
// UITableView *Tableview;
    UIImageView *BackgroundImage;
    NSArray *array;
    NSMutableArray *MenuArray;
    UITableViewCell *cell;
    UILabel *CheckedIn;
    UIButton *OKButton;
    UILabel *ShowOutputLabel;
    NSURLConnection *checkInConnectionConnection;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    NSString *lat;
    NSString *longt;
    
    float currentLocationLati;
    float currentLocationLong;
    NSString *currentlongitud;
    NSString *currentlatitud;
    bool forCheckApi;
    
       
}
@property (weak, nonatomic) IBOutlet MKMapView *myMapview;

@end
