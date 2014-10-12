//
//  LoginViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "LoginViewController.h"
#import "RegestrationViewController.h"
#import "Payment1ViewController.h"
#import "SYSoapTool.h"
#import "MBProgressHUD.h"
#import "SelectSideViewController.h"
#import "SBJson4.h"
#import "CustomerDashboardViewController.h"
#import "EmployeeprocessViewController.h"
#import "ForgetPasswordViewController.h"
#import "OwnerViewController.h"


@interface LoginViewController ()<SOAPToolDelegate>
@property(nonatomic,retain)MBProgressHUD *hud;
@end
@implementation LoginViewController

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
 
    
    //[self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    soaptool=[[SYSoapTool alloc] init];
    soaptool.delegate=self;
    [self.navigationController.navigationBar setHidden:YES];
    
//    UILabel *headerlabel=[[UILabel alloc]init];
//    headerlabel.text=@"Login";
//    headerlabel.textColor=[UIColor whiteColor];
//    [self.view addSubview:headerlabel];
//    //self.navigationController.navigationBar.barTintColor = [UIColor blueColor];
//
//    [self.navigationItem setTitle:@"Login"];
    
//self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoyumoui.png"]];
    
    
    [self CreateUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)CreateUI
{
    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];

    
    
    LoginScrollview=[[UIScrollView alloc]init];
    [self.view addSubview:LoginScrollview];
    
    LogoImAge=[[UIImageView alloc]init];
    [LogoImAge setImage:[UIImage imageNamed:@"logoyumoui.png"]];
    [LoginScrollview addSubview:LogoImAge];
    
    loginBackground=[[UIImageView alloc]init];
    [loginBackground setImage:[UIImage imageNamed:@"username_txt"]];
    [loginBackground setUserInteractionEnabled:YES];
    [LoginScrollview addSubview:loginBackground];
    
    
    
    UserName=[[UITextField alloc]init];
    [UserName setDelegate:self];
    //UserName.text=@"hotel";
    UserName.returnKeyType=UIReturnKeyNext;
    UserName.placeholder=@"Email or Username";
    [loginBackground addSubview:UserName];
    
    
    PasswordBackground=[[UIImageView alloc]init];
     [PasswordBackground setUserInteractionEnabled:YES];
    [PasswordBackground setImage:[UIImage imageNamed:@"pass_txt-1.png"]];
    [LoginScrollview addSubview:PasswordBackground];

    
    Password=[[UITextField alloc]init];
    [Password setDelegate:self];
    //Password.text=@"123";
    Password.secureTextEntry=YES;
    Password.placeholder=@"Password";
    [PasswordBackground addSubview:Password];
    
    
    ForgetPassword=[[UIButton alloc]init];
   // [ForgetPassword setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
    [ForgetPassword setTitle:@"Forgot Password" forState:UIControlStateNormal];
     [ForgetPassword setTitleColor:[UIColor colorWithRed:80/255.0 green:154/255.0 blue:227/255.0 alpha:1] forState:UIControlStateNormal];
    [ForgetPassword addTarget:self action:@selector(ForgetPasswordClicked) forControlEvents:UIControlEventTouchUpInside];
    [LoginScrollview addSubview:ForgetPassword];
    
    underlinePassword=[[UILabel alloc]init];
    underlinePassword.text=@"________________";
    [underlinePassword setTextColor:[UIColor colorWithRed:80/255.0 green:154/255.0 blue:227/255.0 alpha:1]];
    [LoginScrollview addSubview:underlinePassword];
    
    
    LoginButton=[[UIButton alloc]init];
    //LoginButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [LoginButton setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
    [LoginButton setTitle:@"Login" forState:UIControlStateNormal];
    [LoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginButton addTarget:self action:@selector(Loginbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [LoginScrollview addSubview:LoginButton];
    
    RegisterButton=[[UIButton alloc]init];
    [RegisterButton setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
     [RegisterButton setTitle:@"Register" forState:UIControlStateNormal];
    [RegisterButton addTarget:self action:@selector(Registerbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [LoginScrollview addSubview:RegisterButton];
}


- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString* apnsDeviceToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    apnsDeviceToken  = [apnsDeviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"My token is: %@", apnsDeviceToken);
    // [[[UIAlertView alloc]initWithTitle:nil message:apnsDeviceToken delegate:nil cancelButtonTitle:@"Ol" otherButtonTitles:nil, nil]show];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}




-(void)ForgetPasswordClicked
{
    NSLog(@"Forget Password");
    ForgetPasswordViewController *ForgetPassword_=[[ForgetPasswordViewController alloc]init];
    [self.navigationController pushViewController:ForgetPassword_ animated:YES];
}
-(void)Loginbuttonclick
{
   
    if (([UserName.text isEqualToString:@""])||([Password.text isEqualToString:@""]))
    {
        UIAlertView *AlertFilltextfield=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Wrong User Name or Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
        [AlertFilltextfield show];
    }
    else
    {
       
      [self loginAPI];
       
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

-(void)loginAPI
{
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:UserName.text forKey:@"username"];
    [defaults setObject:Password.text forKey:@"password"];
    [defaults synchronize];
    NSLog(@"%@",UserName);
     NSLog(@"%@",Password);
    
    [self showProgressForView:self.view WithMessage:@"Loading...."];
    
    NSString *post=[[NSString alloc]initWithFormat:@"username=%@&password=%@",UserName.text,Password.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yumout.com/rest/api.php?rquest=getLoginAuth"]]];
    LoginConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue =[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    
     {
      
         if(data == NULL)
         {
              NSLog(@"%@",data);
             [self performSelectorOnMainThread:@selector(ServerErrorsmethod) withObject:Nil waitUntilDone:NO];
         }
         else
         {
             
             result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
             User_id=[result valueForKey:@"user_id"];
             NSLog(@"%@",User_id);
             Token=[result valueForKey:@"session_token"];
             expirytime=[result valueForKey:@"session_expiry_time"];
    
         if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
         {
             
             
             [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
             
                        [self performSelectorOnMainThread:@selector(Loginsuceessmethod) withObject:Nil waitUntilDone:NO];
         }
         else
         {
             [self performSelectorOnMainThread:@selector(Loginalertmethod) withObject:Nil waitUntilDone:NO];
           
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

-(void)Loginsuceessmethod
{
    [[NSUserDefaults standardUserDefaults]setValue:User_id forKey:@"User_id"];
    NSLog(@"%@",User_id);
    [[NSUserDefaults standardUserDefaults]setObject:Token forKey:@"Session_Token"];
    [[NSUserDefaults standardUserDefaults]setObject:expirytime forKey:@"session_expiry_time"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    UserName.text=Nil;
    Password.text=Nil;
    if (([[result valueForKey:@"userrole"]isEqualToString:@"user"]) ||([[result valueForKey:@"userrole"] isEqualToString:@"User"]))
    {
         CustomerDashboardViewController *CustomerDashBoard=[[CustomerDashboardViewController alloc]init];
         CustomerDashBoard.datastring=User_id;
         [self.navigationController pushViewController:CustomerDashBoard animated:YES];
       
    }
    else if ([[result valueForKey:@"userrole"]isEqualToString:@"Company"])
    {
        EmployeeprocessViewController *EmployeProcess=[[EmployeeprocessViewController alloc]init];
        EmployeProcess.datastring1=User_id;
        [self.navigationController pushViewController:EmployeProcess animated:YES];
    }
     else if ([[result valueForKey:@"userrole"]isEqualToString:@"Owner"])
     {
         OwnerAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Use Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
         OwnerAlertView.alertViewStyle=UIAlertViewStyleSecureTextInput;
         [OwnerAlertView show];
     }
}

-(void)Loginalertmethod
{
     [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
    UIAlertView *CheckEmail=[[UIAlertView alloc]initWithTitle:@"Wrong Username or Password" message:Nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
    [CheckEmail show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==OwnerAlertView)
    {
        if (buttonIndex==1)
        {
            OwnerViewController *ownerview=[[OwnerViewController alloc]init];
            [self.navigationController pushViewController:ownerview animated:YES];
        }
    }
}

-(void)retriveFromSYSoapTool:(NSMutableArray *)_data
{
    NSLog(@"data %@",_data);
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (textField == UserName || textField == Password)
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y-30;
            self.view.frame = frame;
            
        }
        
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (textField == UserName || textField == Password)
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y+30;
            self.view.frame = frame;
        }
    }
    
    return YES;
   
}

-(void)Registerbuttonclick
{
    RegestrationViewController *registerview=[[RegestrationViewController alloc]initWithNibName:@"RegestrationViewController" bundle:Nil];
    [self.navigationController pushViewController:registerview animated:YES];
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
           
            LoginScrollview.frame=CGRectMake(00, 20, 1024,700);
            [LoginScrollview setContentSize:CGSizeMake(1024, 600)];
            LogoImAge.frame=CGRectMake(400, 20, 225, 60);
            Regestrationlabl.frame=CGRectMake(385, 20, 230, 45);
            
            loginBackground.frame=CGRectMake(225, 130, 530, 60);
            UserName.frame=CGRectMake(120, 1, 400, 58);
            //(225, 390, 530, 50)
             PasswordBackground.frame=CGRectMake(225, 230, 530, 60);
            Password.frame=CGRectMake(120, 1, 400, 58);
            
            ForgetPassword.frame=CGRectMake(400, 300, 190, 20);
            underlinePassword.frame=CGRectMake(425, 300, 150, 30);
            
            LoginButton.frame=CGRectMake(330,395, 340, 55);
            RegisterButton.frame=CGRectMake(330,500, 340, 55);
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
            loginBackground.frame=CGRectMake(110, 95, 330, 50);
             BackgroundImage.frame=CGRectMake(00, 00, 568, 320);
            LoginScrollview.frame=CGRectMake(00, 20, 568,300);
            [LoginScrollview setContentSize:CGSizeMake(320, 440)];
            LogoImAge.frame=CGRectMake(160, 15, 225, 50);
             PasswordBackground.frame=CGRectMake(110, 165, 330, 50);
            Regestrationlabl.frame=CGRectMake(170, 10, 230, 45);
            UserName.frame=CGRectMake(70, 1, 265, 48);
            Password.frame=CGRectMake(70, 1, 265, 48);
                
                ForgetPassword.frame=CGRectMake(180, 225, 190, 15);
                underlinePassword.frame=CGRectMake(205, 225, 150, 20);
                
            LoginButton.frame=CGRectMake(180, 290, 180, 50);
            RegisterButton.frame=CGRectMake(180, 355, 180, 50);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                loginBackground.frame=CGRectMake(70, 95, 330, 50);
                BackgroundImage.frame=CGRectMake(00, 00, 480, 320);
                LoginScrollview.frame=CGRectMake(00, 20, 480,300);
                [LoginScrollview setContentSize:CGSizeMake(320, 430)];
                LogoImAge.frame=CGRectMake(123, 15, 225, 50);
                PasswordBackground.frame=CGRectMake(70, 165, 330, 50);
                Regestrationlabl.frame=CGRectMake(170, 10, 230, 45);
                UserName.frame=CGRectMake(70, 1, 265, 48);
                Password.frame=CGRectMake(70, 1, 265, 48);
                
                ForgetPassword.frame=CGRectMake(150, 225, 190, 15);
                underlinePassword.frame=CGRectMake(175, 225, 150, 20);
                
                LoginButton.frame=CGRectMake(150, 290, 180, 50);
                RegisterButton.frame=CGRectMake(150, 355, 180, 50);
            }
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            loginBackground.frame=CGRectMake(160, 170, 430, 55);
           
            BackgroundImage.frame=CGRectMake(00, 00, 768, 1024);
            PasswordBackground.frame=CGRectMake(160, 270, 430, 55);
           
            LoginScrollview.frame=CGRectMake(00, 20, 768,950);
            [LoginScrollview setContentSize:CGSizeMake(768, 800)];
            
            LogoImAge.frame=CGRectMake(290, 20, 225, 60);
            Regestrationlabl.frame=CGRectMake(235, 20, 230, 45);
            UserName.frame=CGRectMake(92, 1, 340, 53);
            Password.frame=CGRectMake(92, 1, 340, 53);
            
            ForgetPassword.frame=CGRectMake(280, 335, 190, 20);
            underlinePassword.frame=CGRectMake(305, 335, 150, 30);

            
            LoginButton.frame=CGRectMake(205,450, 340, 55);
            RegisterButton.frame=CGRectMake(205,550, 340, 55);

        }
        else
        {
             PasswordBackground.frame=CGRectMake(45, 160, 230, 40);
             loginBackground.frame=CGRectMake(45, 95, 230, 40);
             BackgroundImage.frame=CGRectMake(00, 00, 320, 568);
            LoginScrollview.frame=CGRectMake(00, 20, 320,500);
            [LoginScrollview setContentSize:CGSizeMake(320, 430)];
            LogoImAge.frame=CGRectMake(60, 20, 200, 50);
            Regestrationlabl.frame=CGRectMake(53, 10, 230, 45);
            UserName.frame=CGRectMake(50, 1, 180, 38);
            Password.frame=CGRectMake(50, 1, 180, 38);
            ForgetPassword.frame=CGRectMake(70, 210, 190, 15);
            underlinePassword.frame=CGRectMake(95, 210, 150, 20);

            LoginButton.frame=CGRectMake(60, 270, 200, 40);
            RegisterButton.frame=CGRectMake(60, 330, 200, 40);
        }
        
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations.
    
	if([[[UIDevice currentDevice] model] hasPrefix:@"iPa"]){
        
        if(interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown||interfaceOrientation==UIInterfaceOrientationPortrait){
            return YES;
        }
	}
	return NO;
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([UserName isFirstResponder])
    {
        [Password becomeFirstResponder];
    }
    else
    {
        if (([UserName.text isEqualToString:@""])&&([Password.text isEqualToString:@""]))
        {
           [textField resignFirstResponder];
        }
        else
        {
             [textField resignFirstResponder];
             [self loginAPI];
        }
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
