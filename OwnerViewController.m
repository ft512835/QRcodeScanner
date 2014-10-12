//
//  OwnerViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 03/06/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "OwnerViewController.h"
#import "MBProgressHUD.h"

@interface OwnerViewController ()
@property(nonatomic,retain)MBProgressHUD *hud;
@end

@implementation OwnerViewController

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
   // [self.navigationController.navigationBar setHidden:NO];
    
    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    Scrollview=[[UIScrollView alloc]init];
    [self.view addSubview:Scrollview];
    
    ownerEmailTF=[[UITextField alloc]init];
    [ownerEmailTF setBackgroundColor:[UIColor whiteColor]];
    [ownerEmailTF setDelegate:self];
    ownerEmailTF.placeholder=@"Owner Email-id";
    [Scrollview addSubview:ownerEmailTF];
    
    SubmittButton=[[UIButton alloc]init];
    [SubmittButton setTitle:@"Submitt" forState:UIControlStateNormal];
    [SubmittButton setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
    [SubmittButton addTarget:self action:@selector(Submittclick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:SubmittButton];
    
    logoutButton=[[UIButton alloc]init];
    [logoutButton setTitle:@"Logout" forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
    [logoutButton addTarget:self action:@selector(logoutClick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:logoutButton];
    
    // Do any additional setup after loading the view.
}


-(void)Submittclick
{
    NSString *OwnerEmailString=ownerEmailTF.text;
    [[NSUserDefaults standardUserDefaults]setValue:OwnerEmailString forKeyPath:@"OwnerEmail"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self OwnerEmailAPI];
}

-(void)logoutClick
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


-(void)OwnerEmailAPI
{
    NSString *User_idString=[[NSUserDefaults standardUserDefaults]valueForKey:@"User_id"];
    [[NSUserDefaults standardUserDefaults]valueForKey:@"Session_Token"];
    NSString *sessiontoken= [[NSUserDefaults standardUserDefaults]valueForKey:@"Session_Token"];
    
    [self showProgressForView:self.view WithMessage:@"Loading...."];
    NSString *post=[[NSString alloc]initWithFormat:@"user_id=%@&session_token=%@&paypal_email=%@",User_idString,sessiontoken,ownerEmailTF.text];
    NSLog(@"%@",post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://demo.redsymbolhost.com/ankit/rest/api.php?rquest=updatePaypalEmail"]]];
    PaypalEmailConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue =[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     
     {
         NSLog(@"%@",data);
         if(data == NULL)
         {
             [self performSelectorOnMainThread:@selector(ServerErrorsmethod) withObject:Nil waitUntilDone:NO];
         }
         else
         {
             id  result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
           
             if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
             {
                 [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
                 [self performSelectorOnMainThread:@selector(suceessmethod) withObject:Nil waitUntilDone:NO];
             }
             else
             {
                 [self performSelectorOnMainThread:@selector(failuremethod) withObject:Nil waitUntilDone:NO];
             }
         }
     }];
}

-(void)LogoutApi
{
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
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
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
}


-(void)LogoutSucess{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(void)suceessmethod
{
    NSLog(@"Sucess");
}
-(void)failuremethod
{
    [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
     NSLog(@"failure");
}

-(void)ServerErrorsmethod
{
     [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Server error,please try after some time" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [errorAlertView show];
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
            Scrollview.frame=CGRectMake(00, 60, 1024,970);
            [Scrollview setContentSize:CGSizeMake(1024, 760)];
            BackgroundImage.frame=CGRectMake(00, 00, 1024, 768);
           
            ownerEmailTF.frame=CGRectMake(100, 150, 824, 45);
            SubmittButton.frame=CGRectMake(448, 250, 130, 40);
            logoutButton.frame=CGRectMake(448, 340, 130, 40);
                       
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 53, 568,280);
                [Scrollview setContentSize:CGSizeMake(568, 340)];
                BackgroundImage.frame=CGRectMake(00, 00, 568, 320);
                
                ownerEmailTF.frame=CGRectMake(25, 70, 518, 45);
                SubmittButton.frame=CGRectMake(249, 130, 80, 35);
               logoutButton.frame=CGRectMake(249, 215, 80, 35);
                
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 53, 480,280);
                [Scrollview setContentSize:CGSizeMake(480, 300)];
                BackgroundImage.frame=CGRectMake(00, 0, 480, 320);
                
                ownerEmailTF.frame=CGRectMake(20, 70, 440, 45);
                SubmittButton.frame=CGRectMake(200, 145, 80, 35);
                logoutButton.frame=CGRectMake(200, 215, 80, 35);
                
                
            }
            
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            Scrollview.frame=CGRectMake(00, 60, 768,970);
            [Scrollview setContentSize:CGSizeMake(768, 970)];
            BackgroundImage.frame=CGRectMake(00, 00, 768, 1024);
            
            ownerEmailTF.frame=CGRectMake(50, 200, 668, 45);
            SubmittButton.frame=CGRectMake(325, 280, 100, 45);
             logoutButton.frame=CGRectMake(325, 360, 100, 45);
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 0, 320, 568);
                
                ownerEmailTF.frame=CGRectMake(10, 100, 300, 45);
                SubmittButton.frame=CGRectMake(120, 170, 80, 35);
                 logoutButton.frame=CGRectMake(120, 230, 80, 35);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 0, 320, 568);
                
                ownerEmailTF.frame=CGRectMake(10, 100, 300, 45);
                SubmittButton.frame=CGRectMake(120, 170, 80, 35);
                logoutButton.frame=CGRectMake(120, 230, 80, 35);
             }
         }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
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
