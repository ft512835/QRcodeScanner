//
//  ForgetPasswordViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 01/05/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "ConfrmpasswordViewController.h"
#import "MBProgressHUD.h"

@interface ForgetPasswordViewController ()
@property(nonatomic,retain)MBProgressHUD *hud;
@end

@implementation ForgetPasswordViewController

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
    [self.navigationController.navigationBar setHidden:NO];
    [super viewDidLoad];
    
    
    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    ScrollView=[[UIScrollView alloc]init];
    [self.view addSubview:ScrollView];
    [self createUI];
    // Do any additional setup after loading the view.
}

-(void)createUI
{
    messagealertlabel=[[UILabel alloc]init];
    messagealertlabel.text=@"Please enter the email address for your account. A verification code will be sent to you. Once you have received the verification code, you will be able to choose a new password for your account.";
    messagealertlabel.numberOfLines=4;
    [messagealertlabel setFont:[UIFont systemFontOfSize:13]];
    [ScrollView addSubview:messagealertlabel];
    
    EmailTF=[[UITextField alloc]init];
    [EmailTF setDelegate:self];
    EmailTF .layer.borderColor=[UIColor blackColor].CGColor;
    EmailTF.layer.borderWidth=1.0f;
    [ScrollView addSubview:EmailTF];
    
    
    EmailAddress=[[UILabel alloc]init];
    EmailAddress.text=@"Email Address:";
    [ScrollView addSubview:EmailAddress];
    
    Star=[[UILabel alloc]init];
    Star.text=@"*";
    Star.textColor=[UIColor redColor];
    [ScrollView addSubview:Star];
    
    Submittbutton=[[UIButton alloc]init];
    [Submittbutton setTitle:@"Submitt" forState:UIControlStateNormal];
    [Submittbutton addTarget:self action:@selector(SubmittButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [ScrollView addSubview:Submittbutton];
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


-(void)SubmittButtonClick
{
   
        [self showProgressForView:self.view WithMessage:@"Loading...."];
        NSString *post=[[NSString alloc]initWithFormat:@"email=%@",EmailTF.text];
        NSLog(@"%@",post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
        NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yumout.com/rest/api.php?rquest=forgotPassword"]]];
        ForgrtPasswordConnection=[NSURLConnection connectionWithRequest:request delegate:self];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        NSLog(@"%@",request);
        NSOperationQueue *queue =[[NSOperationQueue alloc]init];
        [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         {
             id result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
             NSLog(@"%@",result);
             
             NSString *User_id=[result valueForKey:@"user_id"];
             NSString *Token=[result valueForKey:@"session_token"];
             NSLog(@"%@",User_id);
             
             [[NSUserDefaults standardUserDefaults]setValue:User_id forKeyPath:@"User_id"];
             [[NSUserDefaults standardUserDefaults]setValue:Token forKey:@"Session_Token"];
             [[NSUserDefaults standardUserDefaults]synchronize];
             
             if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
             {
                [self performSelectorOnMainThread:@selector(Passwordsuceessmethod) withObject:Nil waitUntilDone:NO];
             }
             else
             {
                 [self performSelectorOnMainThread:@selector(Passwordfailuremethod) withObject:Nil waitUntilDone:NO];
             }
         }];

    
}

-(void)Passwordsuceessmethod
{
     [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
    Alert=[[UIAlertView alloc]initWithTitle:@"" message:@"A mail has been send to your on your email, please check your mail" delegate:self cancelButtonTitle:Nil otherButtonTitles:@"Ok", nil];
    [Alert show];
   
}

-(void)Passwordfailuremethod
{
     [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
    UIAlertView *AlertFailure=[[UIAlertView alloc]initWithTitle:@"" message:@"Invalid Email" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
    [AlertFailure show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView==Alert)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
   
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (textField == EmailTF )
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y-60;
            self.view.frame = frame;
            
        }
        
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (textField == EmailTF )
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y+60;
            self.view.frame = frame;
        }
    }
    
    return YES;
    
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
            BackgroundImage.frame=CGRectMake(00, 00, 1024, 768);
            ScrollView.frame=CGRectMake(00, 20, 1024,700);
            [ScrollView setContentSize:CGSizeMake(1024, 600)];
            
            messagealertlabel.frame=CGRectMake(10, 250, 1004, 60);
            messagealertlabel.numberOfLines=4;
            EmailAddress.frame=CGRectMake(10, 370, 160, 35);
            Star.frame=CGRectMake(130, 370, 30, 30);
            [messagealertlabel setFont:[UIFont systemFontOfSize:20]];
            EmailTF.frame=CGRectMake(10, 400, 984, 35);
            Submittbutton.frame=CGRectMake(900, 440, 80, 40);
           
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                
                BackgroundImage.frame=CGRectMake(00, 00, 568, 320);
                ScrollView.frame=CGRectMake(00, 20, 568,300);
                [ScrollView setContentSize:CGSizeMake(320, 300)];
                
                messagealertlabel.frame=CGRectMake(10, 45, 548, 60);
                messagealertlabel.numberOfLines=3;
                EmailAddress.frame=CGRectMake(10, 120, 160, 35);
                Star.frame=CGRectMake(130, 120, 30, 30);
                EmailTF.frame=CGRectMake(10, 160, 548, 35);
                Submittbutton.frame=CGRectMake(478, 200, 80, 30);
               
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
               
                BackgroundImage.frame=CGRectMake(00, 00, 480, 320);
                ScrollView.frame=CGRectMake(00, 20, 480,300);
                [ScrollView setContentSize:CGSizeMake(320, 300)];
                
                messagealertlabel.frame=CGRectMake(10, 45, 460, 60);
                messagealertlabel.numberOfLines=3;
                EmailAddress.frame=CGRectMake(10, 120, 160, 35);
                Star.frame=CGRectMake(130, 120, 30, 30);
                EmailTF.frame=CGRectMake(10, 160, 460, 35);
                Submittbutton.frame=CGRectMake(390, 200, 80, 30);
            }
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
           
            
            BackgroundImage.frame=CGRectMake(00, 00, 768, 1024);
            ScrollView.frame=CGRectMake(00, 20, 768,950);
            [ScrollView setContentSize:CGSizeMake(768, 800)];
            
            messagealertlabel.frame=CGRectMake(10, 355, 748, 60);
            messagealertlabel.numberOfLines=4;
            EmailAddress.frame=CGRectMake(10, 460, 160, 35);
            Star.frame=CGRectMake(130, 460, 30, 30);
             [messagealertlabel setFont:[UIFont systemFontOfSize:15]];
            EmailTF.frame=CGRectMake(10, 490, 748, 35);
            Submittbutton.frame=CGRectMake(650, 540, 80, 40);
          
            
        }
        else
        {
            
            BackgroundImage.frame=CGRectMake(00, 00, 320, 568);
            ScrollView.frame=CGRectMake(00, 20, 320,500);
            [ScrollView setContentSize:CGSizeMake(320, 430)];
            
            messagealertlabel.frame=CGRectMake(10, 45, 300, 100);
            messagealertlabel.numberOfLines=4;
            EmailAddress.frame=CGRectMake(10, 160, 160, 35);
            Star.frame=CGRectMake(130, 160, 30, 30);
            EmailTF.frame=CGRectMake(10, 190, 300, 35);
            Submittbutton.frame=CGRectMake(230, 235, 80, 30);
        }
        
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
