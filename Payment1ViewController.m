//
//  Payment1ViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "Payment1ViewController.h"
#import "CompletePaymentViewController.h"
#import "paypalViewController.h"

@interface Payment1ViewController ()

@end

@implementation Payment1ViewController

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
    
    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    paypalScrollview=[[UIScrollView alloc]init];
    [self.view addSubview:paypalScrollview];
    
    Label1=[[UILabel alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        Label1.frame=CGRectMake(300, -30, 187, 25);
        Label1.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:25];
    }
    else
    {
        Label1.frame=CGRectMake(88, -40, 157, 23);
        Label1.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:21];
    }
    Label1.text=@"Make Comission";
    [paypalScrollview addSubview:Label1];
    
    Label2=[[UILabel alloc]init];
    Label2.text=@"Payment";
    [paypalScrollview addSubview:Label2];
    
    NextButon =[[UIButton alloc]init];
   [NextButon setBackgroundImage:[UIImage imageNamed:@"scan_result_next.png"] forState:UIControlStateNormal];
    [NextButon addTarget: self action:@selector(NextButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [paypalScrollview addSubview:NextButon];

    
    // Do any additional setup after loading the view from its nib.
}

-(void)NextButtonClicked
{
    paypalViewController *Completepayment=[[paypalViewController alloc]initWithNibName:@"paypalViewController" bundle:Nil];
    [self.navigationController pushViewController:Completepayment animated:YES];
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
            BackgroundImage.frame=CGRectMake(00, 20, 1024, 738);
            paypalScrollview.frame=CGRectMake(00, 60, 1024,700);
            [paypalScrollview setContentSize:CGSizeMake(768, 800)];
            Label1.frame=CGRectMake(400, 20, 187, 30);
            Label2.frame=CGRectMake(430, 45, 187, 30);
            NextButon.frame=CGRectMake(350, 530, 260, 50);
        }
        else
        {
             BackgroundImage.frame=CGRectMake(00, 20, 568, 320);
            paypalScrollview.frame=CGRectMake(00, 55, 568,260);
            [paypalScrollview setContentSize:CGSizeMake(568, 200)];
            Label1.frame=CGRectMake(200, 12, 157, 23);
            Label2.frame=CGRectMake(230, 30, 120, 23);
            NextButon.frame=CGRectMake(200, 180, 150, 50);
        }

        
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            
            BackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
            paypalScrollview.frame=CGRectMake(00, 60, 768,950);
            [paypalScrollview setContentSize:CGSizeMake(768, 800)];
            Label1.frame=CGRectMake(300, 20, 187, 25);
            Label2.frame=CGRectMake(340, 45, 187, 25);
            NextButon.frame=CGRectMake(250, 704, 260, 50);
        }
        else
        {
            BackgroundImage.frame=CGRectMake(00, 20, 320, 548);
            paypalScrollview.frame=CGRectMake(00, 60, 320,510);
            [paypalScrollview setContentSize:CGSizeMake(320, 430)];
            Label1.frame=CGRectMake(88, 20, 157, 23);
            Label2.frame=CGRectMake(126, 40, 122, 23);
            NextButon.frame=CGRectMake(90, 370, 150, 50);
        }

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
