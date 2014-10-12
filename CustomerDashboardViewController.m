//
//  CustomerDashboardViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 01/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "CustomerDashboardViewController.h"
#import "ProfileViewController.h"
#import "ReviewViewController.h"
#import "CheckinViewController.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "WebsiteViewController.h"

@interface CustomerDashboardViewController ()
@property(nonatomic,retain)MBProgressHUD *hud;
@end

@implementation CustomerDashboardViewController

@synthesize Webview,SegmentController,datastring;

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
    [self.navigationController.navigationBar setHidden:YES];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoyumoui.png"]];
    [self UserINFO];
    [self CreateUI];
    // Do any additional setup after loading the view.
}
-(void)CreateUI
{

    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    Scrollview=[[UIScrollView alloc]init];
    [self.view addSubview:Scrollview];
    
    WelComeLabel =[[UILabel alloc]init];
    WelComeLabel.text=@"Welcome";
    [WelComeLabel setFont:[UIFont systemFontOfSize:20]];
    WelComeLabel.textAlignment = NSTextAlignmentCenter;
    WelComeLabel.textColor=[UIColor whiteColor];
    [Scrollview addSubview:WelComeLabel];
    
    usernamelabel =[[UILabel alloc]init];
    usernamelabel.text=NameString;
     usernamelabel.textAlignment = NSTextAlignmentCenter;
     [usernamelabel setFont:[UIFont systemFontOfSize:15]];
    [Scrollview addSubview:usernamelabel];
    
    Checkinbutton=[[UIButton alloc]init];
    [Checkinbutton setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
    [Checkinbutton setTitle:@"Checkin" forState:UIControlStateNormal];
    [Checkinbutton addTarget:self action:@selector(checkinclick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:Checkinbutton];
    
    websitebtn=[[UIButton alloc]init];
    [websitebtn setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
    [websitebtn addTarget:self action:@selector(WebsiteClick) forControlEvents:UIControlEventTouchUpInside];
    [websitebtn setTitle:@"Website" forState:UIControlStateNormal];
    [Scrollview addSubview:websitebtn];
    
    LogoutButton=[[UIButton alloc]init];
    [LogoutButton setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
    [LogoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [LogoutButton addTarget:self action:@selector(LogoutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:LogoutButton];
    
    [[NSUserDefaults standardUserDefaults] valueForKey:@"Session_Token"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

-(void)checkinclick
{
    CheckinViewController *CheckInView=[[CheckinViewController alloc]init];
    [self.navigationController pushViewController:CheckInView animated:YES];
}

-(void)WebsiteClick
{
    WebsiteViewController *websiteview=[[WebsiteViewController alloc]init];
    [self.navigationController pushViewController:websiteview animated:YES];
}

-(void)LogoutButtonClicked
{
    [self LogoutApi];
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



-(void)UserINFO
{
    
    NSString *User_idString=[[NSUserDefaults standardUserDefaults]valueForKey:@"User_id"];
   
    [[NSUserDefaults standardUserDefaults]valueForKey:@"Session_Token"];
    NSString *sessiontoken= [[NSUserDefaults standardUserDefaults]valueForKey:@"Session_Token"];
    
    
    NSString *post=[[NSString alloc]initWithFormat:@"user_id=%@&session_token=%@",User_idString,sessiontoken];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yumout.com/rest/api.php?rquest=getUserDetail"]]];
    NSLog(@"%@",request);
    UserInfoConnection =[NSURLConnection connectionWithRequest:request delegate:self];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue =[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     
     {
         if(data == NULL)
         {
             [self performSelectorOnMainThread:@selector(ServerErrorsmethod) withObject:Nil waitUntilDone:NO];
         }
         else
         {
             id result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
             NSMutableArray *userdetailarray= [result valueForKey:@"user_detail"];
         
             if ([userdetailarray valueForKey:@"restaurant_id"] == (id)[NSNull null] )
             {
                 resturentid=@"2";
             }
            else
            {
                resturentid=[userdetailarray valueForKey:@"restaurant_id"];
            }
             UserDetailArray=[result valueForKey:@"user_detail"];
         
             if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
             {
               [self performSelectorOnMainThread:@selector(getinfoSucess) withObject:self.view waitUntilDone:NO];
             }
             else
             {
            // [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
             }
         }
     }];
    
    
}

-(void)ServerErrorsmethod
{
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Server error,please try after some time" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [errorAlertView show];
    [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
}

-(void)getinfoSucess
{
   
    NameString=[UserDetailArray valueForKey:@"name"];
    usernamelabel.text=NameString;
    [[NSUserDefaults standardUserDefaults]setValue:NameString forKey:@"Name"];
    UserNameString=[UserDetailArray valueForKey:@"username"];
    [[NSUserDefaults standardUserDefaults]setValue:UserNameString forKey:@"User_Name"];
    EmailString=[UserDetailArray valueForKey:@"email"];
    [[NSUserDefaults standardUserDefaults]setValue:EmailString forKey:@"E-mail"];
    [[NSUserDefaults standardUserDefaults]setValue:resturentid forKey:@"resturentid"];
}


-(void)RightBarButtonClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)segmentcontrollerclick
{
    if (SegmentController.selectedSegmentIndex==0)
    {
        ProfileViewController *Profileview=[[ProfileViewController alloc]init];
        [self.navigationController pushViewController:Profileview animated:YES];
    }
    if (SegmentController.selectedSegmentIndex==1)
    {
        CheckinViewController *CheckInView=[[CheckinViewController alloc]init];
    
        [self.navigationController pushViewController:CheckInView animated:YES];
    }
    if (SegmentController.selectedSegmentIndex==2)
    {
        [self LogoutApi];
    }
}

-(void)LogoutApi
{
     
    [self showProgressForView:self.view WithMessage:@"Loading...."];
     [self performSelectorOnMainThread:@selector(getinfoSucess) withObject:self.view waitUntilDone:NO];
    
    
     NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@",self.datastring];
    NSLog(@"%@",post);
        NSURL *url=[NSURL URLWithString:@"http://yumout.com/rest/api.php?rquest=logout"];
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    id result=[NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    NSLog(@"%@",result);
       if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
          
               

    {
        [self performSelectorOnMainThread:@selector(LogoutSucess) withObject:self.view waitUntilDone:NO];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
    }


   
    }

-(void)LogoutSucess
{
    [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];

    [self.navigationController popToRootViewControllerAnimated:YES];
}



-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:YES];
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
            Scrollview.frame=CGRectMake(00, 20, 1024,768);
            [Scrollview setContentSize:CGSizeMake(1024, 768)];
            BackgroundImage.frame=CGRectMake(00, 00, 1024, 768);
            
            WelComeLabel.frame=CGRectMake(362, 00, 300, 40);
            usernamelabel.frame=CGRectMake(362, 35, 300,30);
            
            websitebtn.frame=CGRectMake(395, 220, 240, 60);
            Checkinbutton.frame=CGRectMake(395, 365, 240, 60);
            LogoutButton.frame=CGRectMake(395, 500, 240, 60);
            
            [WelComeLabel setFont:[UIFont systemFontOfSize:30]];
            [usernamelabel setFont:[UIFont systemFontOfSize:25]];
           
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 20, 568,300);
                [Scrollview setContentSize:CGSizeMake(320, 260)];
                BackgroundImage.frame=CGRectMake(00, 00, 568, 320);

                
                WelComeLabel.frame=CGRectMake(180, 00, 208, 40);
                usernamelabel.frame=CGRectMake(180, 25, 208,30);
                
                websitebtn.frame=CGRectMake(215, 65, 140, 40);
                Checkinbutton.frame=CGRectMake(215, 140, 140, 40);
                LogoutButton.frame=CGRectMake(215, 220, 140, 40);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                
                
                Scrollview.frame=CGRectMake(00, 20, 480,300);
                [Scrollview setContentSize:CGSizeMake(320, 260)];
                BackgroundImage.frame=CGRectMake(00, 00, 480, 320);
                
                WelComeLabel.frame=CGRectMake(130, 0, 220, 40);
                usernamelabel.frame=CGRectMake(130, 25, 220,30);
                
                websitebtn.frame=CGRectMake(170, 65, 140, 40);
                Checkinbutton.frame=CGRectMake(170, 140, 140, 40);
                LogoutButton.frame=CGRectMake(170, 210, 140, 40);
            }
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
            Scrollview.frame=CGRectMake(00, 20, 768,1004);
            [Scrollview setContentSize:CGSizeMake(768, 1004)];
            BackgroundImage.frame=CGRectMake(00, 00, 768, 1024);
            
            WelComeLabel.frame=CGRectMake(300, 10, 168, 40);
            usernamelabel.frame=CGRectMake(300, 45, 168,30);
            
            websitebtn.frame=CGRectMake(249, 320, 300, 50);
            Checkinbutton.frame=CGRectMake(249, 500, 300, 50);
            LogoutButton.frame=CGRectMake(249, 685, 300, 50);
            
            [WelComeLabel setFont:[UIFont systemFontOfSize:30]];
            [usernamelabel setFont:[UIFont systemFontOfSize:25]];
           
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 20, 320,540);
                [Scrollview setContentSize:CGSizeMake(320, 430)];
                BackgroundImage.frame=CGRectMake(00, 00, 320, 568);
                
                WelComeLabel.frame=CGRectMake(100, 5, 120, 40);
                usernamelabel.frame=CGRectMake(100, 40, 120,30);
                
                websitebtn.frame=CGRectMake(90, 140, 140, 40);
                Checkinbutton.frame=CGRectMake(90, 239, 140, 40);
                LogoutButton.frame=CGRectMake(90, 330, 140, 40);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 20, 320,460);
                [Scrollview setContentSize:CGSizeMake(320, 430)];
                BackgroundImage.frame=CGRectMake(00, 00, 320, 480);
                
                WelComeLabel.frame=CGRectMake(100, 5, 120, 40);
                usernamelabel.frame=CGRectMake(100, 35, 120,30);
              
                Checkinbutton.frame=CGRectMake(90, 210, 140, 40);
                websitebtn.frame=CGRectMake(90, 120, 140, 40);
                LogoutButton.frame=CGRectMake(90, 300, 140, 40);
            }
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
