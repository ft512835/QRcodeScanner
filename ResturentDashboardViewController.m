//
//  ResturentDashboardViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 02/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "ResturentDashboardViewController.h"
#import "EmployeeprocessViewController.h"

@interface ResturentDashboardViewController ()

@end

@implementation ResturentDashboardViewController

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
    [self CreateUI];
    // Do any additional setup after loading the view.
}

-(void)CreateUI
{
    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    Scrollview=[[UIScrollView alloc]init];
    [self.view addSubview:Scrollview];
    
    RestuentEmplyees=[[UIButton alloc]init];
    [RestuentEmplyees setBackgroundImage:[UIImage imageNamed:@"button_.png"] forState:UIControlStateNormal];
    [RestuentEmplyees setTitle:@"Employees" forState:UIControlStateNormal];
    [RestuentEmplyees addTarget:self action:@selector(employeebuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:RestuentEmplyees];
    
    ResturentOwner=[[UIButton alloc]init];
    [ResturentOwner setBackgroundImage:[UIImage imageNamed:@"button_.png"] forState:UIControlStateNormal];
    [ResturentOwner setTitle:@"Owner" forState:UIControlStateNormal];
    [ResturentOwner addTarget:self action:@selector(Ownerbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:ResturentOwner];

}

-(void)employeebuttonclick
{
    EmployeeprocessViewController *employeprocess=[[EmployeeprocessViewController alloc]init];
    [self.navigationController pushViewController:employeprocess animated:YES];
    
}

-(void)Ownerbuttonclick
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:nil
                                                          message:@"Use Password" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    myAlertView.alertViewStyle=UIAlertViewStyleSecureTextInput;
    [myAlertView show];
    
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
            Scrollview.frame=CGRectMake(00, 55, 1024,710);
            [Scrollview setContentSize:CGSizeMake(1024, 710)];
            RestuentEmplyees.frame=CGRectMake(380, 300, 200, 40);
            ResturentOwner.frame=CGRectMake(380, 170, 200, 40);
        }
        else
        {
            BackgroundImage.frame=CGRectMake(00, 20, 568, 320);
            Scrollview.frame=CGRectMake(00, 55, 568,260);
            [Scrollview setContentSize:CGSizeMake(320, 260)];
            
            RestuentEmplyees.frame=CGRectMake(180, 170, 200, 40);
            ResturentOwner.frame=CGRectMake(180, 70, 200, 40);
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            BackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
            Scrollview.frame=CGRectMake(00, 60, 710,1004);
            [Scrollview setContentSize:CGSizeMake(768, 1004)];
            
            RestuentEmplyees.frame=CGRectMake(80, 300, 160, 40);
            ResturentOwner.frame=CGRectMake(80, 200, 160, 40);
            
        }
        else
        {
            Scrollview.frame=CGRectMake(00, 60, 320,500);
            [Scrollview setContentSize:CGSizeMake(320, 430)];
            BackgroundImage.frame=CGRectMake(00, 20, 320, 548);
            RestuentEmplyees.frame=CGRectMake(80, 300, 160, 40);
            ResturentOwner.frame=CGRectMake(80, 200, 160, 40);
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
