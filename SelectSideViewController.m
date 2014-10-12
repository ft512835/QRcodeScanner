//
//  SelectSideViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 01/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "SelectSideViewController.h"
#import "CustomerDashboardViewController.h"
#import "ResturentDashboardViewController.h"

@interface SelectSideViewController ()

@end

@implementation SelectSideViewController

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
    [self CReateUI];
    // Do any additional setup after loading the view from its nib.
}

-(void)CReateUI
{
    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    Scrollview=[[UIScrollView alloc]init];
    [self.view addSubview:Scrollview];
    
    Customerside=[[UIButton alloc]init];
    [Customerside setTitle:@"Customer" forState:UIControlStateNormal];
    [Customerside setBackgroundImage:[UIImage imageNamed:@"button_.png"] forState:UIControlStateNormal];
    [Customerside addTarget:self action:@selector(Customerbuttonclick) forControlEvents:UIControlEventTouchUpInside];
     [Scrollview addSubview:Customerside];
    
    ResturentSide=[[UIButton alloc]init];
    [ResturentSide setTitle:@"Resturent" forState:UIControlStateNormal];
    [ResturentSide setBackgroundImage:[UIImage imageNamed:@"button_.png"] forState:UIControlStateNormal];
    [ResturentSide addTarget:self action:@selector(ResturentbuttonClick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:ResturentSide];

}

-(void)Customerbuttonclick
{
    CustomerDashboardViewController *CustomerSide=[[CustomerDashboardViewController alloc]init];
    [self.navigationController pushViewController:CustomerSide animated:YES];
}

-(void)ResturentbuttonClick
{
    ResturentDashboardViewController *resturentSide=[[ResturentDashboardViewController alloc]init];
    [self.navigationController pushViewController:resturentSide animated:YES];
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
            Scrollview.frame=CGRectMake(00, 55, 1024,748);
            [Scrollview setContentSize:CGSizeMake(1024, 748)];
            ResturentSide.frame=CGRectMake(430, 370, 200, 40);
            Customerside.frame=CGRectMake(430, 230, 200, 40);
        }
        else
        {
            BackgroundImage.frame=CGRectMake(00, 20, 568, 320);
            Scrollview.frame=CGRectMake(00, 55, 568,260);
            [Scrollview setContentSize:CGSizeMake(320, 260)];
            ResturentSide.frame=CGRectMake(180, 170, 200, 40);
            Customerside.frame=CGRectMake(180, 70, 200, 40);
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {   Scrollview.frame=CGRectMake(00, 60, 768,1004);
            [Scrollview setContentSize:CGSizeMake(768, 1004)];
            BackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
            ResturentSide.frame=CGRectMake(250, 500, 260, 70);
            Customerside.frame=CGRectMake(250, 300, 260, 70);
        }
        else
        {
            Scrollview.frame=CGRectMake(00, 60, 320,500);
            [Scrollview setContentSize:CGSizeMake(320, 430)];
            BackgroundImage.frame=CGRectMake(00, 20, 320, 548);
            ResturentSide.frame=CGRectMake(80, 300, 160, 40);
            Customerside.frame=CGRectMake(80, 200, 160, 40);
        }
        
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
