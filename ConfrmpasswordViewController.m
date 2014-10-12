//
//  ConfrmpasswordViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 03/05/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "ConfrmpasswordViewController.h"

@interface ConfrmpasswordViewController ()

@end

@implementation ConfrmpasswordViewController

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
    
    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    
    
    ScrollView=[[UIScrollView alloc]init];
    [self.view addSubview:ScrollView];
    [self CreateUI];
    // Do any additional setup after loading the view.
}

-(void)CreateUI
{
    messagealertlabel=[[UILabel alloc]init];
    messagealertlabel.text=@"A mail has been send to your on your email, please check your mail.";
    messagealertlabel.numberOfLines=2;
    [messagealertlabel setFont:[UIFont systemFontOfSize:13]];
    [ScrollView addSubview:messagealertlabel];
    
    UsernameLabel=[[UILabel alloc]init];
    UsernameLabel.text=@"Username:";
    [ScrollView addSubview:UsernameLabel];
    
    Star=[[UILabel alloc]init];
    Star.text=@"*";
    Star.textColor=[UIColor redColor];
    [ScrollView addSubview:Star];
    
    Star1=[[UILabel alloc]init];
    Star1.text=@"*";
    Star1.textColor=[UIColor redColor];
    [ScrollView addSubview:Star1];
    
    UsernameTF=[[UITextField alloc]init];
    [UsernameTF setDelegate:self];
    UsernameTF .layer.borderColor=[UIColor blackColor].CGColor;
    UsernameTF.layer.borderWidth=1.0f;
    [ScrollView addSubview:UsernameTF];
    
    Verificationlabel=[[UILabel alloc]init];
    Verificationlabel.text=@"Verification Code:";
    [ScrollView addSubview:Verificationlabel];
    
    VerifyCodeTF=[[UITextField alloc]init];
    [VerifyCodeTF setDelegate:self];
    VerifyCodeTF .layer.borderColor=[UIColor blackColor].CGColor;
    VerifyCodeTF.layer.borderWidth=1.0f;
    [ScrollView addSubview:VerifyCodeTF];
    
    Submittbutton=[[UIButton alloc]init];
    [Submittbutton setTitle:@"Submitt" forState:UIControlStateNormal];
    [Submittbutton addTarget:self action:@selector(SubmittButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [ScrollView addSubview:Submittbutton];
}

-(void)SubmittButtonClick
{
    NSLog(@"sd");
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
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                
                BackgroundImage.frame=CGRectMake(00, 00, 568, 320);
                ScrollView.frame=CGRectMake(00, 20, 568,300);
                [ScrollView setContentSize:CGSizeMake(320, 300)];
                [messagealertlabel setFont:[UIFont systemFontOfSize:15]];
                messagealertlabel.frame=CGRectMake(10, 45, 548, 70);
                UsernameLabel.frame=CGRectMake(10, 110, 160, 35);
                Star.frame=CGRectMake(96, 110, 30, 30);
                
                UsernameTF.frame=CGRectMake(10, 140, 548, 35);
                Verificationlabel.frame=CGRectMake(10, 175, 160, 35);
                Star1.frame=CGRectMake(145, 175, 30, 30);
                VerifyCodeTF.frame=CGRectMake(10, 205, 548, 35);
                Submittbutton.frame=CGRectMake(10, 245, 70, 40);
                
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                
                BackgroundImage.frame=CGRectMake(00, 00, 480, 320);
                ScrollView.frame=CGRectMake(00, 20, 480,300);
                [ScrollView setContentSize:CGSizeMake(320, 300)];
                
                [messagealertlabel setFont:[UIFont systemFontOfSize:15]];
                messagealertlabel.frame=CGRectMake(10, 40, 460, 70);
                UsernameLabel.frame=CGRectMake(10, 110, 160, 35);
                Star.frame=CGRectMake(96, 110, 30, 30);
                UsernameTF.frame=CGRectMake(10, 140, 460, 35);
                Verificationlabel.frame=CGRectMake(10, 175, 160, 35);
                Star1.frame=CGRectMake(145, 175, 30, 30);
                VerifyCodeTF.frame=CGRectMake(10, 205, 460, 35);
                Submittbutton.frame=CGRectMake(10, 245, 70, 40);
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
            
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==567)
            {
                BackgroundImage.frame=CGRectMake(00, 00, 320, 568);
                ScrollView.frame=CGRectMake(00, 20, 320,500);
                [ScrollView setContentSize:CGSizeMake(320, 300)];
                
                
                messagealertlabel.frame=CGRectMake(10, 45, 300, 70);
                UsernameLabel.frame=CGRectMake(10, 110, 160, 35);
                Star.frame=CGRectMake(96, 110, 30, 30);
                UsernameTF.frame=CGRectMake(10, 140, 300, 35);
                Verificationlabel.frame=CGRectMake(10, 175, 160, 35);
                Star1.frame=CGRectMake(145, 175, 30, 30);
                VerifyCodeTF.frame=CGRectMake(10, 205, 300, 35);
                Submittbutton.frame=CGRectMake(10, 245, 70, 40);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
            BackgroundImage.frame=CGRectMake(00, 00, 320, 568);
            ScrollView.frame=CGRectMake(00, 20, 320,500);
            [ScrollView setContentSize:CGSizeMake(320, 300)];
            
            
             messagealertlabel.frame=CGRectMake(10, 45, 300, 70);
            UsernameLabel.frame=CGRectMake(10, 110, 160, 35);
            Star.frame=CGRectMake(96, 110, 30, 30);
            UsernameTF.frame=CGRectMake(10, 140, 300, 35);
            Verificationlabel.frame=CGRectMake(10, 175, 160, 35);
            Star1.frame=CGRectMake(145, 175, 30, 30);
            VerifyCodeTF.frame=CGRectMake(10, 205, 300, 35);
            Submittbutton.frame=CGRectMake(10, 245, 70, 40);
            }
           
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
