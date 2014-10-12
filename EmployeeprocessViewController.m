//
//  EmployeeprocessViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 02/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "EmployeeprocessViewController.h"
#import "customerCheckInViewController.h"
#import "ZBarSDK.h"
#import "MBProgressHUD.h"
#import "LoginViewController.h"
#import "ScanedDataViewController.h"

float value =0.0;
@interface EmployeeprocessViewController ()
@property(nonatomic,retain)MBProgressHUD *hud;
@end

@implementation EmployeeprocessViewController

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
    self.navigationItem.title=@"Dashboard";
    self.navigationItem.hidesBackButton = YES;
    
    [self UserINFO];
    [self creteUI];
    // Do any additional setup after loading the view.
}


-(void)creteUI
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
    [Checkinbutton setTitle:@"Check-in List" forState:UIControlStateNormal];
    [Checkinbutton addTarget:self action:@selector(checkinlistclick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:Checkinbutton];

    codeScannbutton=[[UIButton alloc]init];
    [codeScannbutton setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
    [codeScannbutton addTarget:self action:@selector(ScanQRcode) forControlEvents:UIControlEventTouchUpInside];
    [codeScannbutton setTitle:@"Scan QRcode" forState:UIControlStateNormal];
    [Scrollview addSubview:codeScannbutton];
    
    
    
    buttonImage = [UIImage imageNamed:@"logout_.png"];
    aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [aButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    aBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aButton];
    aButton.frame = CGRectMake(0.0, 0.0, 60, 30);
    [aButton addTarget:self action:@selector(RightBarButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:aBarButtonItem];
    
    
    LogoutButton=[[UIButton alloc]init];
    [LogoutButton setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
    [LogoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [LogoutButton addTarget:self action:@selector(LogoutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:LogoutButton];
    
     [self showProgressForView:self.view WithMessage:@"Loading...."];

}

-(void)LogoutButtonClicked
{
    [self LogoutApi];
}

-(void)LogoutApi
{
    NSLog(@"%@",self.datastring1);
    
    [self showProgressForView:self.view WithMessage:@"Loading...."];
    [self performSelectorOnMainThread:@selector(getinfoSucess) withObject:self.view waitUntilDone:NO];
    
    
    NSString *post =[[NSString alloc] initWithFormat:@"user_id=%@",_datastring1];
     NSLog(@"%@",post);
    NSURL *url=[NSURL URLWithString:@"http://yumout.com/rest/api.php?rquest=logout"];
    NSLog(@"%@",url);

    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSLog(@"%@",postData);
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"%@",urlData);

    id result=[NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];

    NSLog(@"%@",result);
    if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
        
    {
      
        [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];

        [self performSelectorOnMainThread:@selector(LogoutSucess) withObject:self.view waitUntilDone:NO];
    }
    else
    {
        [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
    }
    

    /*
    [self showProgressForView:self.view WithMessage:@"Loading...."];
    NSString *User_idString=[[NSUserDefaults standardUserDefaults]valueForKey:@"User_id"];
    NSString *post=[[NSString alloc]initWithFormat:@"user_id=%@",User_idString];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yumout.com/rest/api.php?rquest= logout"]]];
    Logout_Connection =[NSURLConnection connectionWithRequest:request delegate:self];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue =[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if(data == NULL){
             [self performSelectorOnMainThread:@selector(ServerErrorsmethod) withObject:Nil waitUntilDone:NO];
         }
         else{
         id result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
         if ([[result valueForKey:@"status"]isEqualToString:@"Success"]){
          [self performSelectorOnMainThread:@selector(LogoutSucess) withObject:self.view waitUntilDone:NO];
             [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
         }
         else{
             [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
         }
         }
     }];
     */
    
    
    
    
    
    
}


-(void)LogoutSucess
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)UserINFO
{
   NSString *User_idString=[[NSUserDefaults standardUserDefaults]valueForKey:@"User_id"];
   [[NSUserDefaults standardUserDefaults]valueForKey:@"Session_Token"];
   NSString *sessiontoken= [[NSUserDefaults standardUserDefaults]valueForKey:@"Session_Token"];
   NSString *post=[[NSString alloc]initWithFormat:@"user_id=%@&session_token=%@",User_idString,sessiontoken];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yumout.com/rest/api.php?rquest=getUserDetail"]]];
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
             NSLog(@"%@",result);
             userdetailarray= [result valueForKey:@"user_detail"];
             if ([userdetailarray valueForKey:@"restaurant_id"] == (id)[NSNull null] )
             {
                 resturentid=@"2";
             }
             else
             {
                 resturentid=[userdetailarray valueForKey:@"restaurant_id"];
             }
             if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
             {
                 [self performSelectorOnMainThread:@selector(getinfoSucess) withObject:self.view waitUntilDone:NO];
             }
             else
             {
                 [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
             }
         }
     }];
}

-(void)getinfoSucess
{
    [[NSUserDefaults standardUserDefaults]setValue:resturentid forKey:@"resturentid"];
    NameString=[userdetailarray valueForKey:@"name"];
    usernamelabel.text=NameString;
    [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
}


-(void)ServerErrorsmethod
{
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Server error,please try after some time" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [errorAlertView show];
    [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
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

-(void)RightBarButtonClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)ScanQRcode
{
    [self ScannedImage];
}

-(void)ScannedImage
{
   codeReader = [ZBarReaderViewController new];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelbtnClicked) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0, codeReader.view.frame.size.height - 44, 80, 44);
    [codeReader.view addSubview:cancelBtn];
    codeReader.readerDelegate=self;
    codeReader.showsZBarControls = NO;
    codeReader.supportedOrientationsMask = ZBarOrientationMaskAll;
    ZBarImageScanner *scanner = codeReader.scanner;
    [scanner setSymbology: ZBAR_I25 config: ZBAR_CFG_ENABLE to: 0];
    [self presentViewController:codeReader animated:YES completion:nil];
    
    value =0.0;
}

-(void)cancelbtnClicked
{
      [codeReader dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController: (UIImagePickerController*) reader didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results = [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // just grab the first barcode
        break;
    NSLog(@"data %@",info);
    // showing the result on textview
    NSString *QRcodeString=[[NSString alloc]init];
    QRcodeString=symbol.data;
    NSLog(@"%@",QRcodeString);
    [reader dismissViewControllerAnimated:YES completion:nil];
    
    NSString *post=[[NSString alloc]initWithFormat:@"qrcodes=%@",QRcodeString];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yumout.com/rest/api.php?rquest=checkQrcode"]]];
    CodeScanConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue =[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         id result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
         if([[result valueForKey:@"status"]isEqualToString:@"sucess"])
         {
             [self performSelectorOnMainThread:@selector(method) withObject:Nil waitUntilDone:NO];
         }
         else
         {
               [self performSelectorOnMainThread:@selector(Invalidalertmethod) withObject:Nil waitUntilDone:NO];
         }
     }];
}

-(void)Invalidalertmethod
{
    UIAlertView *Alertforinvalidcode=[[UIAlertView alloc]initWithTitle:@"Error" message:@"You scanned the wrong QRcode ,its not exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
    [Alertforinvalidcode show];
}

-(void)method
{
    ScanedDataViewController *ScannedData=[[ScanedDataViewController alloc]initWithNibName:@"ScanedDataViewController" bundle:Nil];
    [self.navigationController pushViewController:ScannedData animated:YES];
}

-(void)checkinlistclick
{
    customerCheckInViewController *Checkin=[[customerCheckInViewController alloc]init];
    [self.navigationController pushViewController:Checkin animated:YES];
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
            BackgroundImage.frame=CGRectMake(00, 00, 1024, 768);
            Scrollview.frame=CGRectMake(00, 20, 1024,768);
            [Scrollview setContentSize:CGSizeMake(1024, 768)];
            WelComeLabel.frame=CGRectMake(362, 00, 300, 40);
            usernamelabel.frame=CGRectMake(362, 35, 300,30);
            codeScannbutton.frame=CGRectMake(395, 220, 240, 60);
            Checkinbutton.frame=CGRectMake(395, 365, 240, 60);
            Checkinlistview.frame=CGRectMake(250, 50, 540, 580);
            CancelButton.frame=CGRectMake(238, 92, 30, 30);
             LogoutButton.frame=CGRectMake(395, 500, 240, 60);
            [WelComeLabel setFont:[UIFont systemFontOfSize:30]];
            [usernamelabel setFont:[UIFont systemFontOfSize:25]];
        }
        else
        {
             if ([UIScreen mainScreen].bounds.size.height==568)
             {
                 BackgroundImage.frame=CGRectMake(00, 00, 568, 320);
                 Scrollview.frame=CGRectMake(00, 20, 568,300);
                 [Scrollview setContentSize:CGSizeMake(320, 260)];
                 WelComeLabel.frame=CGRectMake(180, 00, 208, 40);
                 usernamelabel.frame=CGRectMake(180, 25, 208,30);
                 Checkinlistview.frame=CGRectMake(100, 20, 380, 220);
                 codeScannbutton.frame=CGRectMake(210, 40, 140, 40);
                 Checkinbutton.frame=CGRectMake(210, 130, 140, 40);
                 CancelButton.frame=CGRectMake(90, 65, 20, 20);
                 LogoutButton.frame=CGRectMake(210, 220, 140, 40);
             }
             else if ([UIScreen mainScreen].bounds.size.height==480)
             {
                 BackgroundImage.frame=CGRectMake(00, 00, 480, 320);
                 Scrollview.frame=CGRectMake(00, 20, 480,300);
                 [Scrollview setContentSize:CGSizeMake(320, 260)];
                 WelComeLabel.frame=CGRectMake(130, 0, 220, 40);
                 usernamelabel.frame=CGRectMake(130, 25, 220,30);
                 codeScannbutton.frame=CGRectMake(180, 50, 140, 40);
                 Checkinbutton.frame=CGRectMake(180, 130, 140, 40);
                 Checkinlistview.frame=CGRectMake(50, 20, 380, 220);
                 CancelButton.frame=CGRectMake(40, 65, 20, 20);
                 LogoutButton.frame=CGRectMake(180, 210, 140, 40);
             }
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            BackgroundImage.frame=CGRectMake(00, 00, 768, 1024);
            Scrollview.frame=CGRectMake(00, 20, 768,1004);
            [Scrollview setContentSize:CGSizeMake(768, 1004)];
            WelComeLabel.frame=CGRectMake(300, 10, 168, 40);
            usernamelabel.frame=CGRectMake(300, 45, 168,30);
            codeScannbutton.frame=CGRectMake(300, 320, 140, 50);
            Checkinbutton.frame=CGRectMake(300, 500, 140, 50);
            Checkinlistview.frame=CGRectMake(150, 160, 480, 600);
            CancelButton.frame=CGRectMake(143, 209, 20, 20);
            LogoutButton.frame=CGRectMake(300, 685, 140, 50);
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
            codeScannbutton.frame=CGRectMake(90, 140, 140, 40);
            Checkinbutton.frame=CGRectMake(90, 239, 140, 40);
            Checkinlistview.frame=CGRectMake(20, 60, 280, 380);
            CancelButton.frame=CGRectMake(15, 110, 20, 20);
             LogoutButton.frame=CGRectMake(90, 330, 140, 40);
        }
        else if ([UIScreen mainScreen].bounds.size.height==480)
        {
            Scrollview.frame=CGRectMake(00, 20, 320,460);
            [Scrollview setContentSize:CGSizeMake(320, 430)];
            BackgroundImage.frame=CGRectMake(00, 0, 320, 480);
            Checkinbutton.frame=CGRectMake(90, 210, 140, 40);
            WelComeLabel.frame=CGRectMake(100, 5, 120, 40);
            usernamelabel.frame=CGRectMake(100, 35, 120,30);
            codeScannbutton.frame=CGRectMake(90, 120, 140, 40);
            //Checkinlistview.frame=CGRectMake(20, 60, 280, 300);
            CancelButton.frame=CGRectMake(15, 110, 20, 20);
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
