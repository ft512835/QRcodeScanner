//
//  CheckinViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 01/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "CheckinViewController.h"
#import "ShareCheckinViewController.h"
#import "MBProgressHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>

//#import <SDWebImage/UIImageView+WebCache.h>

@interface CheckinViewController ()
@property(nonatomic,retain)MBProgressHUD *hud;
@end

@implementation CheckinViewController
@synthesize myMapview;

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
    
    forCheckApi=false;
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title=@"Check.in";
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [locationManager startUpdatingLocation];
    
    
    [self createUI];
    
    // Do any additional setup after loading the view.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)showProgressForView:(UIView *)view WithMessage:(NSString *)message
{
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _hud.labelText = message;
}

- (void)hideProgressForView:(UIView*)view
{
    if (_hud)
    {
        [MBProgressHUD hideHUDForView:view animated:YES];
        self.hud = nil;
    }
}

-(void)CheckinApi

{
   //float lati =locationManager.location.coordinate.latitude;
    //float longi =locationManager.location.coordinate.longitude;
    [[NSUserDefaults standardUserDefaults]valueForKeyPath:@"User_id"];
    [[NSUserDefaults standardUserDefaults]valueForKeyPath:@"Session_Token"];
    NSString *UserID=[[NSUserDefaults standardUserDefaults]valueForKeyPath:@"User_id"];
    NSString *SessionToken=[[NSUserDefaults standardUserDefaults]valueForKeyPath:@"Session_Token"];
    
   [self showProgressForView:self.view WithMessage:@"Checking...."];
    MenuArray =[[NSMutableArray alloc]init];
  //  NSString *post=[[NSString alloc]initWithFormat:@"user_id=%@&lat=18.9220%f&long=72.8334%f&session_token=%@",UserID,lati,longi,SessionToken];
     NSString *post=[[NSString alloc]initWithFormat:@"user_id=%@&lat=18.9220&long=72.8334&session_token=%@",UserID,SessionToken];
    // NSString *post=[[NSString alloc]initWithFormat:@"user_id=%@&lat=%@&long=%@&session_token=%@",UserID,lat,longt,SessionToken];
   NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yumout.com/rest/api.php?rquest=checkinRequest"]]];
    
    checkInConnectionConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue =[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    
     {
         NSLog(@"%@",data);
         id result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
         if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
         {
             [self performSelectorOnMainThread:@selector(showalert) withObject:self.view waitUntilDone:NO];
         }
         
         else if([[result valueForKey:@"status"]isEqualToString:@"CheckedIn"])
         {
            [self performSelectorOnMainThread:@selector(Alreadycheckin) withObject:self.view waitUntilDone:NO];
         }
        else
        {
            [self performSelectorOnMainThread:@selector(failedtocheckin) withObject:self.view waitUntilDone:NO];
        }
          [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
     }];
}

-(void)showalert
{
    ShowOutputLabel.text=@"Sucessfully Checked In";
 }
-(void)Alreadycheckin
{
     ShowOutputLabel.text=@"Already checked-in";
}

-(void)failedtocheckin
{
    ShowOutputLabel.text=@"Failed to Checked In";
}
-(void)createUI
{
    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    Scrollview=[[UIScrollView alloc]init];
    [self.view addSubview:Scrollview];
//
    OKButton=[[UIButton alloc]init];
    [OKButton setTitle:@"OK" forState:UIControlStateNormal];
    [OKButton setBackgroundColor:[UIColor clearColor]];
    [OKButton addTarget:self action:@selector(OKButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:OKButton];
    
    ShowOutputLabel=[[UILabel alloc]init];
    [Scrollview addSubview:ShowOutputLabel];
}

-(void)CancelButtonClick
{
    NSLog(@"CANCEL");
}

-(void)OKButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
   [self CheckinApi];
    
    
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
            Scrollview.frame=CGRectMake(00, 60, 1024,970);
            [Scrollview setContentSize:CGSizeMake(1024, 760)];
            BackgroundImage.frame=CGRectMake(00, 20, 1024, 760);
            SearchTF.frame=CGRectMake(150, 40, 550, 50);
            CancelButton.frame=CGRectMake(720, 40, 130, 50);
            CheckedIn.frame=CGRectMake(450, 500, 120, 40);
            ShowOutputLabel.frame=CGRectMake(420, 300, 200, 45);

        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 53, 568,280);
                [Scrollview setContentSize:CGSizeMake(568, 450)];
                BackgroundImage.frame=CGRectMake(00, 20, 568, 300);
                SearchTF.frame=CGRectMake(50, 30, 400, 40);
                CancelButton.frame=CGRectMake(460, 30, 80, 40);
                CheckedIn.frame=CGRectMake(250, 400, 120, 40);
                ShowOutputLabel.frame=CGRectMake(170, 130, 200, 45);
               // OKButton.frame=CGRectMake(260, 170, 50, 45);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 53, 480,280);
                [Scrollview setContentSize:CGSizeMake(480, 450)];
                BackgroundImage.frame=CGRectMake(00, 20, 480, 300);
                SearchTF.frame=CGRectMake(30, 30, 330, 40);
                CancelButton.frame=CGRectMake(370, 30, 80, 40);
                CheckedIn.frame=CGRectMake(200, 400, 120, 40);
                ShowOutputLabel.frame=CGRectMake(140,100, 200, 45);
                //OKButton.frame=CGRectMake(200, 120, 50, 45);
            }

        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            Scrollview.frame=CGRectMake(00, 60, 768,970);
            [Scrollview setContentSize:CGSizeMake(768, 970)];
            BackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
            
            SearchTF.frame=CGRectMake(100, 50, 430, 50);
            CancelButton.frame=CGRectMake(540, 50, 120, 50);
            
             CheckedIn.frame=CGRectMake(310, 650, 140, 50);
            ShowOutputLabel.frame=CGRectMake(300, 400, 200, 45);
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 20, 320, 550);
                SearchTF.frame=CGRectMake(20, 30, 200, 30);
                CancelButton.frame=CGRectMake(230, 30, 70, 30);
              
                CheckedIn.frame=CGRectMake(110, 440, 120, 40);
                ShowOutputLabel.frame=CGRectMake(70, 170, 200, 45);
                //OKButton.frame=CGRectMake(130, 170, 50, 45);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 20, 320, 550);
                SearchTF.frame=CGRectMake(20, 20, 200, 30);
                CancelButton.frame=CGRectMake(230, 20, 70, 30);
             
                CheckedIn.frame=CGRectMake(110, 360, 120, 40);
                
                ShowOutputLabel.frame=CGRectMake(70, 150, 200, 45);
                //OKButton.frame=CGRectMake(130, 150, 50, 45);
                 //cell.frame=CGRectMake(00, 00, 320, 200);
            }
            
           
        }
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
