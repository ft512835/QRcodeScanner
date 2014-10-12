//
//  DashboardViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "DashboardViewController.h"

#import "Payment1ViewController.h"
#import "ScanedDataViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

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
   [self.navigationItem setTitle:@"Dashboard"];
   
    [self CreateUI];
    
   
    // Do any additional setup after loading the view from its nib.
}
-(void)CreateUI
{
    BackgroundImage=[[UIImageView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         BackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
    }
    else
    {
        BackgroundImage.frame=CGRectMake(00, 20, 320, 548);
    }
                                 
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    
    dashBoardScrollview=[[UIScrollView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        dashBoardScrollview.frame=CGRectMake(00, 60, 768,950);
        [dashBoardScrollview setContentSize:CGSizeMake(768, 900)];
    }
    else
    {
        dashBoardScrollview.frame=CGRectMake(00, 60, 320,510);
        [dashBoardScrollview setContentSize:CGSizeMake(320, 430)];
    }
    
    [self.view addSubview:dashBoardScrollview];

    
//    Regestrationlabl=[[UILabel alloc]init];
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//    {
//      Regestrationlabl.frame=CGRectMake(230, -10, 230, 45);
//      Regestrationlabl.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:25];
//    }
//    else
//    {
//        Regestrationlabl.frame=CGRectMake(42, -50, 230, 45);
//        Regestrationlabl.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:21];
//    }
//    Regestrationlabl.text=@"           Dashboard";
//  
//    [dashBoardScrollview addSubview:Regestrationlabl];

    ScanQRbtn=[[UIButton alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        ScanQRbtn.frame=CGRectMake(175, 200, 400, 45);
    }
    else
    {
        ScanQRbtn.frame=CGRectMake(70, 70, 180, 45);
    }
    //[ScanQRbtn setTitle:@"Scan QR Code" forState:UIControlStateNormal];
    [ScanQRbtn setBackgroundImage:[UIImage imageNamed:@"scan_QR_code.png"] forState:UIControlStateNormal];
    [ScanQRbtn addTarget:self action:@selector(ScanQRbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [dashBoardScrollview addSubview:ScanQRbtn];

    Paymentbtn=[[UIButton alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        Paymentbtn.frame=CGRectMake(175, 300, 400, 45);
    }
    else
    {
        Paymentbtn.frame=CGRectMake(70, 170, 180, 45);
    }
    //[Paymentbtn setTitle:@"Make Payment" forState:UIControlStateNormal];
    [Paymentbtn setBackgroundImage:[UIImage imageNamed:@"make_payment"] forState:UIControlStateNormal];
    [Paymentbtn addTarget:self action:@selector(Paymentbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [dashBoardScrollview addSubview:Paymentbtn];

    SyncSystembtn=[[UIButton alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        SyncSystembtn.frame=CGRectMake(175, 400, 400, 45);
    }
    else
    {
        SyncSystembtn.frame=CGRectMake(70, 270, 180, 45);
    }
   // [SyncSystembtn setTitle:@"Sync System" forState:UIControlStateNormal];
    [SyncSystembtn setBackgroundImage:[UIImage imageNamed:@"sync_system"] forState:UIControlStateNormal];
    [SyncSystembtn addTarget:self action:@selector(Sysnsystembuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [dashBoardScrollview addSubview:SyncSystembtn];
    
}

-(void)ScanQRbuttonclick
{
    
}

-(void)Paymentbuttonclick
{
    Payment1ViewController *dashboard=[[Payment1ViewController alloc]initWithNibName:@"Payment1ViewController" bundle:Nil];
    [self.navigationController pushViewController:dashboard animated:YES];
}

-(void)Sysnsystembuttonclick
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    if(([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) || ([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeRight))
    {
        [self willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft duration:1];
        [self willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationLandscapeRight duration:1];
        
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
            dashBoardScrollview.frame=CGRectMake(00, 60, 1024,700);
            [dashBoardScrollview setContentSize:CGSizeMake(768, 590)];
            
            Regestrationlabl.frame=CGRectMake(370, -10, 230, 45);
            ScanQRbtn.frame=CGRectMake(175, 200, 685, 60);
            Paymentbtn.frame=CGRectMake(175, 310, 685, 60);
            SyncSystembtn.frame=CGRectMake(175, 420, 685, 60);
           
        }
        else
        {
             BackgroundImage.frame=CGRectMake(00, 20, 568, 320);
            dashBoardScrollview.frame=CGRectMake(00, 55, 568,260);
            [dashBoardScrollview setContentSize:CGSizeMake(320, 330)];
            
            Regestrationlabl.frame=CGRectMake(143, 00, 230, 45);
            ScanQRbtn.frame=CGRectMake(180, 60, 200, 45);
            Paymentbtn.frame=CGRectMake(180, 120, 200, 45);
            SyncSystembtn.frame=CGRectMake(180, 180, 200, 45);
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            BackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
            dashBoardScrollview.frame=CGRectMake(00, 60, 768,950);
            [dashBoardScrollview setContentSize:CGSizeMake(768, 800)];
            Regestrationlabl.frame=CGRectMake(230, -10, 230, 45);
            ScanQRbtn.frame=CGRectMake(175, 200, 400,60);
            Paymentbtn.frame=CGRectMake(175, 310, 400, 60);
            SyncSystembtn.frame=CGRectMake(175, 420, 400, 60);
          
            
        }
        else
        {
              BackgroundImage.frame=CGRectMake(00, 20, 320, 548);
            dashBoardScrollview.frame=CGRectMake(00, 60, 320,510);
            [dashBoardScrollview setContentSize:CGSizeMake(320, 430)];
            Regestrationlabl.frame=CGRectMake(42, 00, 230, 45);
            ScanQRbtn.frame=CGRectMake(70, 90, 180, 45);
            Paymentbtn.frame=CGRectMake(70, 190, 180, 45);
            SyncSystembtn.frame=CGRectMake(70, 290, 180, 45);
        }
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
