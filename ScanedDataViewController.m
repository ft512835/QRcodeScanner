//
//  ScanedDataViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "ScanedDataViewController.h"
#import "Payment1ViewController.h"

@interface ScanedDataViewController ()

@end

@implementation ScanedDataViewController

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
     [self.navigationItem setTitle:@"Scaned Result"];
    [self CreateUI];
    // Do any additional setup after loading the view from its nib.
}
-(void)CreateUI
{
    mainBackgroundImage=[[UIImageView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        mainBackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
    }
    else
    {
        mainBackgroundImage.frame=CGRectMake(00, 20, 320, 548);
    }
    [mainBackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:mainBackgroundImage];
    
    Scrollview=[[UIScrollView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        Scrollview.frame=CGRectMake(00, 60, 768,950);
        [Scrollview setContentSize:CGSizeMake(768, 800)];
    }
    else
    {
        Scrollview.frame=CGRectMake(00, 60, 320,510);
        [Scrollview setContentSize:CGSizeMake(320, 430)];
    }
    [self.view addSubview:Scrollview];
     
    
    BackgroungImage=[[UIImageView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        BackgroungImage.frame=CGRectMake(100, 25, 600, 360);
    }
    else
    {
         BackgroungImage.frame=CGRectMake(10, 25, 300, 250);
    }
    [BackgroungImage setImage:[UIImage imageNamed:@"result_bg.png"]];
    [Scrollview addSubview:BackgroungImage];
    
    custmrname=[[UILabel alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         custmrname.frame=CGRectMake(25, 25, 280, 35);
      
    }
    else
    {
         custmrname.frame=CGRectMake(10, 15, 280, 35);
    }
    custmrname.text=@"Customer Name";
    [BackgroungImage addSubview:custmrname];
    
    
    CUSTOMERNAME=[[UILabel alloc]init];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        CUSTOMERNAME.frame=CGRectMake(300, 25, 200, 35);
    }
    else
    {
     CUSTOMERNAME.frame=CGRectMake(250, 15, 280, 35);
    }
    CUSTOMERNAME.text=@"testing";
    [BackgroungImage addSubview:CUSTOMERNAME];

    
    
    
    YourDish=[[UILabel alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         YourDish.frame=CGRectMake(25, 80, 280, 35);
    }
    else
    {
         YourDish.frame=CGRectMake(10, 60, 280, 35);
    }
    YourDish.text=@"Your Dish";
    [BackgroungImage addSubview:YourDish];
    
    DISHNAME=[[UILabel alloc]init];
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        DISHNAME.frame=CGRectMake(300, 80, 200, 35);
    }
    else
    {
        DISHNAME.frame=CGRectMake(250, 60, 280, 35);
    }
    DISHNAME.text=@"test";
    [BackgroungImage addSubview:DISHNAME];
    
    Discount=[[UILabel alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         Discount.frame=CGRectMake(25, 135, 280, 35);
    }
    else
    {
          Discount.frame=CGRectMake(10, 105, 280, 35);
    }
    Discount.text=@"Discount";
    [BackgroungImage addSubview:Discount];
    
    DISCOUT=[[UILabel alloc]init];
    DISCOUT.text=@"20 %";
    [BackgroungImage addSubview:DISCOUT];
    
    IssueDate=[[UILabel alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         IssueDate.frame=CGRectMake(20, 190, 280, 35);
    }
    else
    {
         IssueDate.frame=CGRectMake(10, 150, 280, 35);
    }
    IssueDate.text=@"Issue Date";
    [BackgroungImage addSubview:IssueDate];
    
    ISSUE_DATE=[[UILabel alloc]init];
    ISSUE_DATE.text=@"YY/MM/DD";
    [BackgroungImage addSubview:ISSUE_DATE];
    
    ExpiryDate=[[UILabel alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         ExpiryDate.frame=CGRectMake(20, 245, 280, 35);
    }
    else
    {
        ExpiryDate.frame=CGRectMake(10, 195, 280, 35);
    }
    ExpiryDate.text=@"Expiry Date";
    [BackgroungImage addSubview:ExpiryDate];
    
    EXPIRYDATE=[[UILabel alloc]init];
    EXPIRYDATE.text=@"YY/MM/DD";
    [BackgroungImage addSubview:EXPIRYDATE];
    
    NextButton=[[UIButton alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         NextButton.frame=CGRectMake(300, 560, 200, 50);
    }
    else
    {
         NextButton.frame=CGRectMake(70, 340, 180, 50);
    }
   // [NextButton setTitle:@"Next" forState:UIControlStateNormal];
   [NextButton setBackgroundImage:[UIImage imageNamed:@"scan_result_next"] forState:UIControlStateNormal];
    [NextButton addTarget:self action:@selector(Nextbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:NextButton];
}

-(void)Nextbuttonclick
{
    Payment1ViewController *Startpaymentview=[[Payment1ViewController alloc]initWithNibName:@"Payment1ViewController" bundle:Nil];
    [self.navigationController pushViewController:Startpaymentview animated:YES];
    
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
            mainBackgroundImage.frame=CGRectMake(00, 20, 1024, 738);
            
             Scrollview.frame=CGRectMake(00, 60, 1024,720);
            [Scrollview setContentSize:CGSizeMake(768, 600)];
            Regestrationlabl.frame=CGRectMake(230,-50, 230, 45);
            BackgroungImage.frame=CGRectMake(100, 80, 800, 330);
            custmrname.frame=CGRectMake(25, 25, 280, 35);
            CUSTOMERNAME.frame=CGRectMake(500, 25, 300, 35);
            YourDish.frame=CGRectMake(25, 80, 280, 35);
            DISHNAME.frame=CGRectMake(500, 80, 300, 35);
            Discount.frame=CGRectMake(25, 135, 280, 35);
            DISCOUT.frame=CGRectMake(500, 135, 300, 35);
            IssueDate.frame=CGRectMake(20, 190, 280, 35);
            ISSUE_DATE.frame=CGRectMake(500, 190, 300, 35);
            ExpiryDate.frame=CGRectMake(20, 245, 280, 35);
            EXPIRYDATE.frame=CGRectMake(500, 245, 300, 35);
            NextButton.frame=CGRectMake(350, 560, 300, 55);
           
            
        }
        else
        {
             mainBackgroundImage.frame=CGRectMake(00, 20, 568, 320);
            Scrollview.frame=CGRectMake(00, 55, 568,260);
            [Scrollview setContentSize:CGSizeMake(320, 430)];
            Regestrationlabl.frame=CGRectMake(145,-50, 230, 45);
            BackgroungImage.frame=CGRectMake(90, 25, 400, 250);
            custmrname.frame=CGRectMake(10, 15, 280, 35);
            CUSTOMERNAME.frame=CGRectMake(300, 15, 300, 35);
            YourDish.frame=CGRectMake(10, 60, 280, 35);
            DISHNAME.frame=CGRectMake(300, 60, 300, 35);
            Discount.frame=CGRectMake(10, 105, 280, 35);
            DISCOUT.frame=CGRectMake(300, 105, 300, 35);
            IssueDate.frame=CGRectMake(10, 150, 280, 35);
            ISSUE_DATE.frame=CGRectMake(300, 150, 300, 35);
            ExpiryDate.frame=CGRectMake(10, 195, 280, 35);
            EXPIRYDATE.frame=CGRectMake(300, 195, 300, 35);
            NextButton.frame=CGRectMake(200, 340, 180, 50);
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            mainBackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
            Scrollview.frame=CGRectMake(00, 60, 768,950);
            [Scrollview setContentSize:CGSizeMake(768, 800)];
            Regestrationlabl.frame=CGRectMake(230,-50, 230, 45);
            BackgroungImage.frame=CGRectMake(80, 100, 600, 320);
            custmrname.frame=CGRectMake(25, 25, 280, 35);
            CUSTOMERNAME.frame=CGRectMake(400, 25, 250, 35);
            YourDish.frame=CGRectMake(25, 80, 280, 35);
            DISHNAME.frame=CGRectMake(400, 80, 250, 35);
            Discount.frame=CGRectMake(25, 135, 280, 35);
            DISCOUT.frame=CGRectMake(400, 135, 280, 35);
            IssueDate.frame=CGRectMake(20, 190, 280, 35);
            ISSUE_DATE.frame=CGRectMake(400, 190, 280, 35);
            ExpiryDate.frame=CGRectMake(20, 245, 280, 35);
            EXPIRYDATE.frame=CGRectMake(400, 245, 280, 35);
            NextButton.frame=CGRectMake(280, 640, 200, 55);
            
        }
        else
        {
             mainBackgroundImage.frame=CGRectMake(00, 20, 320, 548);
            Scrollview.frame=CGRectMake(00, 60, 320,510);
            [Scrollview setContentSize:CGSizeMake(320, 430)];
            Regestrationlabl.frame=CGRectMake(45,-50, 230, 45);
            BackgroungImage.frame=CGRectMake(10, 50, 300, 250);
            custmrname.frame=CGRectMake(10, 15, 280, 35);
            CUSTOMERNAME.frame=CGRectMake(180, 15, 200, 35);
            YourDish.frame=CGRectMake(10, 60, 280, 35);
            DISHNAME.frame=CGRectMake(180, 60, 200, 35);
            Discount.frame=CGRectMake(10, 105, 280, 35);
            DISCOUT.frame=CGRectMake(180, 105, 200, 35);
            IssueDate.frame=CGRectMake(10, 150, 280, 35);
            ISSUE_DATE.frame=CGRectMake(180, 150, 200, 35);
            ExpiryDate.frame=CGRectMake(10, 195, 280, 35);
            EXPIRYDATE.frame=CGRectMake(180, 195, 200, 35);
            NextButton.frame=CGRectMake(70, 370, 180, 50);
        }
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
