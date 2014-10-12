//
//  RegestrationViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "RegestrationViewController.h"
#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "SelectSideViewController.h"
#import "ResturentDashboardViewController.h"
#import "CustomerDashboardViewController.h"
#import "EmployeeprocessViewController.h"
#import "CompleteRegisterationViewController.h"



@interface RegestrationViewController ()
@property(nonatomic,retain)MBProgressHUD *hud;
@end

@implementation RegestrationViewController

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
    [self.navigationController.navigationBar setHidden:NO];
    [self.navigationItem setTitle:@"Register"];
    [self CreateUI];
    UserRoleArrayData=[[NSArray alloc]initWithObjects:@"User",@"company",@"Owner", nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)CreateUI
{
    
    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    
    SignupScrollview=[[UIScrollView alloc]init];
    [self.view addSubview:SignupScrollview];
    
    UsernameBackground=[[UIImageView alloc]init];
    [UsernameBackground setImage:[UIImage imageNamed:@"username_txt"]];
    [UsernameBackground setUserInteractionEnabled:YES];
    [SignupScrollview addSubview:UsernameBackground];
    
    star1=[[UILabel alloc]init];
    star1.text=@"*";
    [star1 setFont:[UIFont systemFontOfSize:35]];
    [star1 setTextColor:[UIColor redColor]];
    [SignupScrollview addSubview:star1];
    
    star2=[[UILabel alloc]init];
    star2.text=@"*";
    [star2 setFont:[UIFont systemFontOfSize:35]];
    [star2 setTextColor:[UIColor redColor]];
    [SignupScrollview addSubview:star2];

    
    star3=[[UILabel alloc]init];
    star3.text=@"*";
    [star3 setFont:[UIFont systemFontOfSize:35]];
    [star3 setTextColor:[UIColor redColor]];
    [SignupScrollview addSubview:star3];
    
    star4=[[UILabel alloc]init];
    star4.text=@"*";
    [star4 setFont:[UIFont systemFontOfSize:35]];
    [star4 setTextColor:[UIColor redColor]];
    [SignupScrollview addSubview:star4];
    
    star5=[[UILabel alloc]init];
    star5.text=@"*";
    [star5 setFont:[UIFont systemFontOfSize:35]];
    [star5 setTextColor:[UIColor redColor]];
    [SignupScrollview addSubview:star5];
    
    star6=[[UILabel alloc]init];
    star6.text=@"*";
    [star6 setFont:[UIFont systemFontOfSize:35]];
    [star6 setTextColor:[UIColor redColor]];
    [SignupScrollview addSubview:star6];
    
    
    
    UserName=[[UITextField alloc]init];
    UserName.tag=1;
    [UserName setDelegate:self];
    UserName.placeholder=@"Username";
    [UsernameBackground addSubview:UserName];
    
    
    //name...
    
    NameBackground=[[UIImageView alloc]init];
    [NameBackground setImage:[UIImage imageNamed:@"username_txt"]];
    [NameBackground setUserInteractionEnabled:YES];
    [SignupScrollview addSubview:NameBackground];
    
    
    Name=[[UITextField alloc]init];
    [Name setDelegate:self];
    Name.tag=0;
     Name.returnKeyType = UIReturnKeyNext;
    Name.placeholder=@"Name";
    [NameBackground addSubview:Name];

    
    
    //password..
    
    emailbackground=[[UIImageView alloc]init];
    [emailbackground setImage:[UIImage imageNamed:@"username_txt.png"]];
    [emailbackground setUserInteractionEnabled:YES];
    [SignupScrollview addSubview:emailbackground];
    
    EmailTF=[[UITextField alloc]init];
    EmailTF.returnKeyType=UIReturnKeyNext ;
    EmailTF.tag=2;
    [EmailTF setDelegate:self];
    EmailTF.placeholder=@"Email";
    [emailbackground addSubview:EmailTF];
    
    
    PasswordBackground=[[UIImageView alloc]init];
    [PasswordBackground setImage:[UIImage imageNamed:@"re-enter_pass.png"]];
    [PasswordBackground setUserInteractionEnabled:YES];
    [SignupScrollview addSubview:PasswordBackground];
    
    
    Password=[[UITextField alloc]init];
    Password.tag=3;
    Password.returnKeyType=UIReturnKeyNext ;
    Password.secureTextEntry=YES;
    [Password setDelegate:self];
    Password.placeholder=@"Password";
    [PasswordBackground addSubview:Password];
    
    //confrm password......
    
    CnfrnPWrdBackground=[[UIImageView alloc]init];
    [CnfrnPWrdBackground setImage:[UIImage imageNamed:@"re-enter_pass.png"]];
    [CnfrnPWrdBackground setUserInteractionEnabled:YES];
    [SignupScrollview addSubview:CnfrnPWrdBackground];
    
    
    ConfirmPassword=[[UITextField alloc]init];
    [ConfirmPassword setDelegate:self];
    ConfirmPassword.tag=4;
    ConfirmPassword.secureTextEntry=YES;
    ConfirmPassword.returnKeyType=UIReturnKeyNext ;
    ConfirmPassword.placeholder=@"Confirm Password";
    [CnfrnPWrdBackground addSubview:ConfirmPassword];
    
    
    UserRoleBAckground=[[UIImageView alloc]init];
    [UserRoleBAckground setImage:[UIImage imageNamed:@"re-enter_pass.png"]];
    [UserRoleBAckground setUserInteractionEnabled:YES];
    [SignupScrollview addSubview:UserRoleBAckground];
    
    
    UserRoleTF=[[UITextField alloc]init];
    [UserRoleTF setDelegate:self];
    [UserRoleTF setUserInteractionEnabled:NO];
    UserRoleTF.tag=5;
    UserRoleTF.placeholder=@"User Role";
    [UserRoleBAckground addSubview:UserRoleTF];

    SelectUserRoleButton=[[UIButton alloc]init];
    [SelectUserRoleButton setBackgroundImage:[UIImage imageNamed:@"dropdown25X25.png"] forState:UIControlStateNormal];
    //[SelectUserRoleButton setBackgroundColor:[UIColor blackColor]];
    [SelectUserRoleButton addTarget:self action:@selector(UserRoleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [UserRoleBAckground addSubview:SelectUserRoleButton];
    
    
    
    RegisterButton=[[UIButton alloc]init];
    [RegisterButton setBackgroundImage:[UIImage imageNamed:@"blank.png"] forState:UIControlStateNormal];
    [RegisterButton setTitle:@"Register" forState:UIControlStateNormal];
    [RegisterButton addTarget:self action:@selector(regesterbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [SignupScrollview addSubview:RegisterButton];
    
    UserRoleTable=[[UITableView alloc]init];
    UserRoleTable.frame=CGRectMake(400, 600, 200, 150);
    [UserRoleTable setDelegate:self];
    [UserRoleTable setHidden:YES];
    [UserRoleTable setDataSource:self];
    [SignupScrollview addSubview:UserRoleTable];

}
-(BOOL)validemail:(NSString *)candidate
{
    NSString *emailRegex = @"[A-Z/0-9/a-z.A-Z/0-9/a-z_%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:candidate];
}


-(void)UserRoleButtonClick
{
    [UserRoleTable setHidden:NO];
}
-(void)regesterbuttonclick
{
    
        
     if (([UserName.text isEqualToString:@""])&&([Password.text isEqualToString:@""])&&([ConfirmPassword.text isEqualToString:@""])&& ([Name.text isEqualToString:@""])&&([EmailTF.text isEqualToString:@""])&&([UserRoleTF.text isEqualToString:@""]))
     {
         NameBackground.layer.borderColor=[UIColor redColor].CGColor ;
         NameBackground.layer.borderWidth=2.0f;
         UsernameBackground.layer.borderColor=[UIColor redColor].CGColor ;
         UsernameBackground.layer.borderWidth=2.0f;
         emailbackground.layer.borderColor=[UIColor redColor].CGColor ;
         emailbackground.layer.borderWidth=2.0f;
         PasswordBackground.layer.borderColor=[UIColor redColor].CGColor ;
         PasswordBackground.layer.borderWidth=2.0f;
         UserRoleBAckground.layer.borderColor=[UIColor redColor].CGColor ;
         UserRoleBAckground.layer.borderWidth=2.0f;
         CnfrnPWrdBackground.layer.borderColor=[UIColor redColor].CGColor ;
         CnfrnPWrdBackground.layer.borderWidth=2.0f;
         
         UIAlertView *Filltextfield=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Fill the complete text " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
         [Filltextfield show];

     }
     else if([Name.text isEqualToString:@""])
     {
         NameBackground.layer.borderColor=[UIColor redColor].CGColor ;
         NameBackground.layer.borderWidth=2.0f;
         
         UsernameBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         emailbackground.layer.borderColor=[UIColor clearColor].CGColor ;
         PasswordBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         CnfrnPWrdBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         UserRoleBAckground.layer.borderColor=[UIColor clearColor].CGColor ;
         
         UIAlertView *PasswordAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Enter Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [PasswordAlert show];
     }

     else if([UserName.text isEqualToString:@""])
     {
         UsernameBackground.layer.borderColor=[UIColor redColor].CGColor ;
         UsernameBackground.layer.borderWidth=2.0f;
         
         NameBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         emailbackground.layer.borderColor=[UIColor clearColor].CGColor ;
         PasswordBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         CnfrnPWrdBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         UserRoleBAckground.layer.borderColor=[UIColor clearColor].CGColor ;
         
         UIAlertView *PasswordAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Enter User Name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [PasswordAlert show];
     }

     else if([Password.text isEqualToString:@""])
     {
         PasswordBackground.layer.borderColor=[UIColor redColor].CGColor ;
         PasswordBackground.layer.borderWidth=2.0f;
         
         NameBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         emailbackground.layer.borderColor=[UIColor clearColor].CGColor ;
         UsernameBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         CnfrnPWrdBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         UserRoleBAckground.layer.borderColor=[UIColor clearColor].CGColor ;
         
         UIAlertView *PasswordAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Enter Password" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
         [PasswordAlert show];
     }

    
    
     else if (![self validemail:EmailTF.text])
     {
         emailbackground.layer.borderColor=[UIColor redColor].CGColor ;
         emailbackground.layer.borderWidth=2.0f;
         
         UsernameBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         NameBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         PasswordBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         CnfrnPWrdBackground.layer.borderColor=[UIColor clearColor].CGColor ;
         UserRoleBAckground.layer.borderColor=[UIColor clearColor].CGColor ;
         UIAlertView *Checkemail=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please Enter Valid Email-id" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
         [Checkemail show];
     }

    else if(![Password.text isEqualToString:ConfirmPassword.text])
    {
        PasswordBackground.layer.borderColor=[UIColor redColor].CGColor ;
        PasswordBackground.layer.borderWidth=2.0f;
        CnfrnPWrdBackground.layer.borderColor=[UIColor redColor].CGColor ;
        CnfrnPWrdBackground.layer.borderWidth=2.0f;
        UsernameBackground.layer.borderColor=[UIColor clearColor].CGColor ;
        emailbackground.layer.borderColor=[UIColor clearColor].CGColor ;
        NameBackground.layer.borderColor=[UIColor clearColor].CGColor ;
        UserRoleBAckground.layer.borderColor=[UIColor clearColor].CGColor ;
        
        UIAlertView *PasswordAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Password not matched" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [PasswordAlert show];
    }
    else if([UserRoleTF.text isEqualToString:@""])
    {
        UserRoleBAckground.layer.borderColor=[UIColor redColor].CGColor ;
        UserRoleBAckground.layer.borderWidth=2.0f;
        UsernameBackground.layer.borderColor=[UIColor clearColor].CGColor ;
        emailbackground.layer.borderColor=[UIColor clearColor].CGColor ;
        NameBackground.layer.borderColor=[UIColor clearColor].CGColor ;
        PasswordBackground.layer.borderColor=[UIColor clearColor].CGColor ;
        CnfrnPWrdBackground.layer.borderColor=[UIColor clearColor].CGColor ;
      
        UIAlertView *PasswordAlert = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Select your role" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [PasswordAlert show];
    }

    
    else
    {
        
        [self registeration];
        
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


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (textField == Password)
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y-120;
            self.view.frame = frame;
        
        }
    
        else if(textField ==ConfirmPassword)
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y-120;
            self.view.frame = frame;
        }
      
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (textField == Password)
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y-120;
            self.view.frame = frame;
        }
        else if(textField==ConfirmPassword)
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y-120;
            self.view.frame = frame;
            
        }
        
    }
        return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
     if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
     {
         if (textField == Password)
         {
             CGRect frame = self.view.frame;
             frame.origin.y = frame.origin.y+120;
             self.view.frame = frame;
         }
        else if(textField==ConfirmPassword)
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y+120;
            self.view.frame = frame;
        
        }
    
     }
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (textField == Password)
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y+120;
            self.view.frame = frame;
        }
        else if(textField==ConfirmPassword)
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y+120;
            self.view.frame = frame;
            
        }

    }
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [UserRoleArrayData count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[UserRoleArrayData objectAtIndex:indexPath.row];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserRoleTF.text=[UserRoleArrayData objectAtIndex:indexPath.row];
    [UserRoleTable setHidden:YES];
}



-(void)registeration
{
    [self showProgressForView:self.view WithMessage:@"Loading...."];
    NSString *post=[[NSString alloc]initWithFormat:@"name=%@&username=%@&email=%@&password=%@&userrole=%@",Name.text,UserName.text,EmailTF.text,Password.text
                    ,UserRoleTF.text];
    NSURL *url=[NSURL URLWithString:@"http://yumout.com/rest/api.php?rquest=userregistration"];
   
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    NSLog(@"%@",request);
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
        [self performSelectorOnMainThread:@selector(Registersuceessmethod) withObject:Nil waitUntilDone:NO];
    }
    else
    {
       [self performSelectorOnMainThread:@selector(Regesteralertmethod) withObject:Nil waitUntilDone:NO];
    }
    
    
    
}

/*
    NSString *post=[[NSString alloc]initWithFormat:@"name=%@&username=%@&email=%@&password=%@&userrole=%@",Name.text,UserName.text,EmailTF.text,Password.text
                    ,UserRoleTF.text];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSLog(@"%@",UserName);
    NSLog(@"%@",Password);
    NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yumout.com/rest/api.php?rquest=userregistration"]]];
    regestrationConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSLog(@"%@",request);
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
             id result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
             NSLog(@"%@",result);
             if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
             {
                 [self performSelectorOnMainThread:@selector(Registersuceessmethod) withObject:Nil waitUntilDone:NO];
             }
             else
             {
                [self performSelectorOnMainThread:@selector(Regesteralertmethod) withObject:Nil waitUntilDone:NO];
             }
         }
     }];

    [[NSUserDefaults standardUserDefaults]setValue:Name.text forKeyPath:@"Name"];
    [[NSUserDefaults standardUserDefaults]setValue:UserName.text forKeyPath:@"User_Name"];
    [[NSUserDefaults standardUserDefaults]setValue:EmailTF.text forKeyPath:@"Email"];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"Name"]);
 }
    */


-(void)ServerErrorsmethod
{
    UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:nil message:@"Server error,please try after some time" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    [errorAlertView show];
    [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
}


-(void)Registersuceessmethod
{
    [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
    /*
    if ([UserRoleTF.text isEqualToString:@"User"])
    {
        CustomerDashboardViewController *CustomerSide=[[CustomerDashboardViewController alloc]init];
        [self.navigationController pushViewController:CustomerSide animated:YES];

    }
    
   else if ([UserRoleTF.text isEqualToString:@"Resturant"])
    {
        
        EmployeeprocessViewController *EmployeProcess=[[EmployeeprocessViewController alloc]init];
        [self.navigationController pushViewController:EmployeProcess animated:YES];
    }
    else if ([UserRoleTF.text isEqualToString:@"owner"])
    {
        NSLog(@"owner");
    }
     */
    CompleteRegisterationViewController *completeRegisteration=[[CompleteRegisterationViewController alloc]init];
    [self.navigationController pushViewController:completeRegisteration animated:YES];
   // [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)Regesteralertmethod
{
    [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
    UIAlertView *CheckEmail=[[UIAlertView alloc]initWithTitle:@"Email already Exist" message:Nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:Nil, nil];
    [CheckEmail show];
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
            BackgroundImage.frame=CGRectMake(00, 20, 1024, 745);
            SignupScrollview.frame=CGRectMake(00, 65, 1024,690);
            [SignupScrollview setContentSize:CGSizeMake(768, 670)];
            Regestrationlabl.frame=CGRectMake(380, -20, 330, 45);
            NameBackground.frame=CGRectMake(225, 30, 530, 60);
            Name.frame=CGRectMake(110, 1, 410, 58);
            UsernameBackground.frame=CGRectMake(225, 120, 530, 60);
            UserName.frame=CGRectMake(115, 1, 410, 58);
            emailbackground.frame=CGRectMake(225, 210, 530, 60);
            EmailTF.frame=CGRectMake(115, 1, 410, 58);
            PasswordBackground.frame=CGRectMake(225, 300, 530, 60);
            Password.frame=CGRectMake(115, 1, 410, 58);
            CnfrnPWrdBackground.frame=CGRectMake(225, 390, 530, 60);
            ConfirmPassword.frame=CGRectMake(115, 1, 410, 58);
            UserRoleBAckground.frame=CGRectMake(225, 480, 530, 60);
            UserRoleTF.frame=CGRectMake(115, 1, 370, 58);
            SelectUserRoleButton.frame=CGRectMake(490, 10, 40, 40);
            UserRoleTable.frame=CGRectMake(445, 540, 310, 150);
            RegisterButton.frame=CGRectMake(350, 580, 280, 60);
            
            star1.frame=CGRectMake(755, 30, 20, 30);
            star2.frame=CGRectMake(755, 120, 20, 30);
            star3.frame=CGRectMake(755, 210, 20,30);
            star4.frame=CGRectMake(755, 300, 20, 30);
            star5.frame=CGRectMake(755, 390, 20, 30);
            star6.frame=CGRectMake(755, 480, 20, 30);
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                BackgroundImage.frame=CGRectMake(00, 20, 568, 320);
                SignupScrollview.frame=CGRectMake(00, 53, 568,270);
                [SignupScrollview setContentSize:CGSizeMake(320, 490)];
                Regestrationlabl.frame=CGRectMake(180, -50, 380, 45);
                NameBackground.frame=CGRectMake(140, 15, 330, 40);
                Name.frame=CGRectMake(70, 1, 270, 38);
                UsernameBackground.frame=CGRectMake(140, 75, 330, 40);
                UserName.frame=CGRectMake(70, 1, 270, 38);
                emailbackground.frame=CGRectMake(140, 135, 330, 40);
                EmailTF.frame=CGRectMake(70, 1, 270, 38);
                PasswordBackground.frame=CGRectMake(140, 195, 330, 40);
                Password.frame=CGRectMake(70, 1, 270, 38);
                CnfrnPWrdBackground.frame=CGRectMake(140, 255, 330, 40);
                ConfirmPassword.frame=CGRectMake(70, 1, 270, 38);
                UserRoleBAckground.frame=CGRectMake(140, 315, 330, 40);
                UserRoleTF.frame=CGRectMake(70, 1, 240, 38);
                SelectUserRoleButton.frame=CGRectMake(300, 5, 30, 30);
                UserRoleTable.frame=CGRectMake(200, 355, 270, 120);
                RegisterButton.frame=CGRectMake(215, 370, 180, 50);
                
                star1.frame=CGRectMake(470, 15, 20, 30);
                star2.frame=CGRectMake(470, 75, 20, 30);
                star3.frame=CGRectMake(470, 135, 20,30);
                star4.frame=CGRectMake(470, 195, 20, 30);
                star5.frame=CGRectMake(470, 255, 20, 30);
                star6.frame=CGRectMake(470, 315, 20, 30);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                BackgroundImage.frame=CGRectMake(00, 20, 480, 320);
                SignupScrollview.frame=CGRectMake(00, 55, 480,270);
                [SignupScrollview setContentSize:CGSizeMake(480, 480)];
                NameBackground.frame=CGRectMake(75, 15, 330, 40);
                Name.frame=CGRectMake(70, 1, 270, 38);
                UsernameBackground.frame=CGRectMake(75, 75, 330, 40);
                UserName.frame=CGRectMake(70, 1, 270, 38);
                emailbackground.frame=CGRectMake(75, 135, 330, 40);
                EmailTF.frame=CGRectMake(70, 1, 270, 38);
                PasswordBackground.frame=CGRectMake(75, 195, 330, 40);
                Password.frame=CGRectMake(70, 1, 270, 38);
                CnfrnPWrdBackground.frame=CGRectMake(75, 255, 330, 40);
                ConfirmPassword.frame=CGRectMake(70, 1, 270, 38);
                UserRoleBAckground.frame=CGRectMake(75, 315, 330, 40);
                UserRoleTF.frame=CGRectMake(70, 1, 240, 38);
                SelectUserRoleButton.frame=CGRectMake(300, 5, 30, 30);
                UserRoleTable.frame=CGRectMake(125, 355, 280, 120);
                RegisterButton.frame=CGRectMake(150, 370, 180, 50);
                
                star1.frame=CGRectMake(405, 15, 20, 30);
                star2.frame=CGRectMake(405, 75, 20, 30);
                star3.frame=CGRectMake(405, 135, 20,30);
                star4.frame=CGRectMake(405, 195, 20, 30);
                star5.frame=CGRectMake(405, 255, 20, 30);
                star6.frame=CGRectMake(405, 315, 20, 30);
            }
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            BackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
            SignupScrollview.frame=CGRectMake(00, 60, 768,950);
            [SignupScrollview setContentSize:CGSizeMake(768, 800)];
            Regestrationlabl.frame=CGRectMake(280, 00, 230, 45);
            
            NameBackground.frame=CGRectMake(150, 70, 430, 50);
            Name.frame=CGRectMake(95, 1, 340, 48);
            UsernameBackground.frame=CGRectMake(150, 160, 430, 50);
            UserName.frame=CGRectMake(95, 1, 340, 48);
            emailbackground.frame=CGRectMake(150, 250, 430, 50);
            EmailTF.frame=CGRectMake(95, 1, 340, 48);
            PasswordBackground.frame=CGRectMake(150, 340, 430, 50);
            Password.frame=CGRectMake(95, 1, 340, 48);
            CnfrnPWrdBackground.frame=CGRectMake(150, 430, 430, 50);
            ConfirmPassword.frame=CGRectMake(95, 1, 340, 48);
            UserRoleBAckground.frame=CGRectMake(150, 520, 430, 50);
            UserRoleTF.frame=CGRectMake(95, 1, 305, 48);
            SelectUserRoleButton.frame=CGRectMake(390, 7, 40, 35);
            UserRoleTable.frame=CGRectMake(260, 570, 320, 140);
             RegisterButton.frame=CGRectMake(270, 670, 180, 50);
            
            star1.frame=CGRectMake(580, 70, 20, 30);
            star2.frame=CGRectMake(580, 160, 20, 30);
            star3.frame=CGRectMake(580, 250, 20,30);
            star4.frame=CGRectMake(580, 340, 20, 30);
            star5.frame=CGRectMake(580, 430, 20, 30);
            star6.frame=CGRectMake(580, 520, 20, 30);
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                BackgroundImage.frame=CGRectMake(00, 20, 320, 548);
                SignupScrollview.frame=CGRectMake(00, 60, 320,510);
                [SignupScrollview setContentSize:CGSizeMake(320, 430)];
                Regestrationlabl.frame=CGRectMake(45, -50, 230, 45);
                UsernameBackground.frame=CGRectMake(45, 95, 230, 40);
                emailbackground.frame=CGRectMake(45, 155, 230, 40);
                PasswordBackground.frame=CGRectMake(45, 215, 230, 40);
                NameBackground.frame=CGRectMake(45, 35, 230, 40);
                Name.frame=CGRectMake(50, 1, 180, 40);
                UserName.frame=CGRectMake(50, 1, 180, 38);
                EmailTF.frame=CGRectMake(50, 1, 180, 38);
                Password.frame=CGRectMake(50, 2,180, 40);
                CnfrnPWrdBackground.frame=CGRectMake(45, 275, 230, 40);
                ConfirmPassword.frame=CGRectMake(50, 1, 180, 38);
                UserRoleBAckground.frame=CGRectMake(45, 335, 230, 40);
                UserRoleTF.frame=CGRectMake(50, 1, 150, 38);
                 RegisterButton.frame=CGRectMake(70, 400, 180, 50);
                SelectUserRoleButton.frame=CGRectMake(200, 5, 30, 30);
                UserRoleTable.frame=CGRectMake(100, 375, 175, 120);
                
                star1.frame=CGRectMake(275, 35, 20, 30);
                star2.frame=CGRectMake(275, 95, 20, 30);
                star3.frame=CGRectMake(275, 155, 20,30);
                star4.frame=CGRectMake(275, 215, 20, 30);
                star5.frame=CGRectMake(275, 275, 20, 30);
                star6.frame=CGRectMake(275, 335, 20, 30);
               
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                BackgroundImage.frame=CGRectMake(00, 20, 320, 548);
                SignupScrollview.frame=CGRectMake(00, 60, 320,510);
                [SignupScrollview setContentSize:CGSizeMake(320, 600)];
                Regestrationlabl.frame=CGRectMake(45, -50, 230, 45);
                UsernameBackground.frame=CGRectMake(45, 95, 230, 40);
                emailbackground.frame=CGRectMake(45, 155, 230, 40);
                PasswordBackground.frame=CGRectMake(45, 215, 230, 40);
                NameBackground.frame=CGRectMake(45, 35, 230, 40);
                Name.frame=CGRectMake(50, 1, 180, 40);
                UserName.frame=CGRectMake(50, 1, 180, 38);
                EmailTF.frame=CGRectMake(50, 1, 180, 38);
                Password.frame=CGRectMake(50, 2,180, 40);
                CnfrnPWrdBackground.frame=CGRectMake(45, 275, 230, 40);
                ConfirmPassword.frame=CGRectMake(50, 1, 180, 38);
                
                UserRoleBAckground.frame=CGRectMake(45, 335, 230, 40);
                UserRoleTF.frame=CGRectMake(50, 1, 150, 38);
                RegisterButton.frame=CGRectMake(70, 400, 180, 50);
                SelectUserRoleButton.frame=CGRectMake(200,5, 30, 30);
                UserRoleTable.frame=CGRectMake(100, 375, 175, 120);
                
                star1.frame=CGRectMake(275, 35, 20, 30);
                star2.frame=CGRectMake(275, 95, 20, 30);
                star3.frame=CGRectMake(275, 155, 20,30);
                star4.frame=CGRectMake(275, 215, 20, 30);
                star5.frame=CGRectMake(275, 275, 20, 30);
                star6.frame=CGRectMake(275, 335, 20, 30);
            }
            
        }
        
    }
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
//    NSInteger nextTag = textField.tag + 1;
//    NSLog(@"%i",nextTag);
//    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
//    if (nextTag==textField.tag+1)
//    {
//       [nextResponder becomeFirstResponder];
//    }
//   // if (nextResponder)
////    {
////        // Found next responder, so set it.
////        [nextResponder becomeFirstResponder];
////    }
//    else
//    {
//        // Not found, so remove keyboard.
//        [textField resignFirstResponder];
//    }
    
    
    
    if ([Password isFirstResponder])
    {
        [ConfirmPassword becomeFirstResponder];
    }
    
    else if ([EmailTF isFirstResponder])
    {
        [Password becomeFirstResponder];
    }
    else if ([UserName isFirstResponder])
    {
        [EmailTF becomeFirstResponder];
    }
    
    else if ([Name isFirstResponder])
    {
        [UserName becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
    }
    return NO;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
