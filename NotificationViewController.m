//
//  NotificationViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 03/05/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "NotificationViewController.h"
#import "SendbillViewController.h"

@interface NotificationViewController ()

@end

@implementation NotificationViewController

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
     
    Scrollview=[[UIScrollView alloc]init];
    [self.view addSubview:Scrollview];
    
   Coupon_Issue_Date=[[UILabel alloc]init];
    Coupon_Issue_Date.text=@"Coupon Issue Date";
    [Scrollview addSubview:Coupon_Issue_Date];
    
//    meannameTF=[[UITextField alloc]init];
//    meannameTF.layer.borderColor=[UIColor blackColor].CGColor ;
//     [meannameTF setDelegate:self];
//    meannameTF.layer.borderWidth=1.0f;
//    [Scrollview addSubview:meannameTF];
    
    discountlabel=[[UILabel alloc]init];
    discountlabel.text=@"Discount";
    [Scrollview addSubview:discountlabel];
    
//    DiscountTF=[[UITextField alloc]init];
//    DiscountTF.layer.borderColor=[UIColor blackColor].CGColor ;
//     [DiscountTF setDelegate:self];
//    DiscountTF.layer.borderWidth=1.0f;
// [Scrollview addSubview:DiscountTF];
    
    tax=[[UILabel alloc]init];
    tax.text=@"Tax";
    [Scrollview addSubview:tax];
    
    mealcost=[[UILabel alloc]init];
    mealcost.text=@"Meal Cost";
    [Scrollview addSubview:mealcost];
    
    mealcostTF=[[UITextField alloc]init];
    [mealcostTF setDelegate:self];
    mealcostTF.layer.borderColor=[UIColor blackColor].CGColor ;
    mealcostTF.layer.borderWidth=1.0f;
   [Scrollview addSubview:mealcostTF];
    
    Sendnotification=[[UIButton alloc]init];
    [Sendnotification setTitle:@"Send Notification" forState:UIControlStateNormal];
    [Sendnotification addTarget:self action:@selector(notificationclick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:Sendnotification];
    // Do any additional setup after loading the view.
}

-(void)notificationclick
{
    SendbillViewController *sendbill=[[SendbillViewController alloc]init];
    [self.navigationController pushViewController:sendbill animated:YES];
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
            BackgroundImage.frame=CGRectMake(00, 20, 1024, 760);
            
            mealcost.frame=CGRectMake(250, 100, 100, 35);
           // meannameTF.frame=CGRectMake(250, 145, 528, 40);
            discountlabel.frame=CGRectMake(250, 215, 100, 35);
            DiscountTF.frame=CGRectMake(250, 260, 528, 40);
            tax.frame=CGRectMake(250, 295, 100, 35);
            mealcostTF.frame=CGRectMake(250, 145, 528, 40);
            Coupon_Issue_Date.frame=CGRectMake(250, 360, 200, 35);
            Sendnotification.frame=CGRectMake(450, 480, 140, 40);
           
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 53, 568,280);
                [Scrollview setContentSize:CGSizeMake(568, 335)];
                BackgroundImage.frame=CGRectMake(00, 20, 568, 300);
                
                mealcost.frame=CGRectMake(20, 15, 100, 35);
                 mealcostTF.frame=CGRectMake(20, 55, 528, 35);
               // meannameTF.frame=CGRectMake(20, 50, 528, 35);
                discountlabel.frame=CGRectMake(20, 100, 100, 35);
                DiscountTF.frame=CGRectMake(20, 140, 528, 35);
                tax.frame=CGRectMake(20, 160, 100, 35);
                
                Coupon_Issue_Date.frame=CGRectMake(20, 220, 528, 35);
               
                Sendnotification.frame=CGRectMake(210, 260, 140, 40);

               
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 53, 480,280);
                [Scrollview setContentSize:CGSizeMake(480, 335)];
                BackgroundImage.frame=CGRectMake(00, 20, 480, 300);
                
                mealcost.frame=CGRectMake(20, 15, 100, 35);
                 mealcostTF.frame=CGRectMake(20, 55, 440, 35);
              //  meannameTF.frame=CGRectMake(20, 50, 440, 35);
                discountlabel.frame=CGRectMake(20, 100, 100, 35);
                DiscountTF.frame=CGRectMake(20, 140, 440, 35);
                tax.frame=CGRectMake(20, 150, 100, 35);
                Coupon_Issue_Date.frame=CGRectMake(20, 205, 440, 35);
                Sendnotification.frame=CGRectMake(170, 275, 140, 40);
               
               
            }
            
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            Scrollview.frame=CGRectMake(00, 60, 768,970);
            [Scrollview setContentSize:CGSizeMake(768, 970)];
            BackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
            
            mealcost.frame=CGRectMake(140, 100, 100, 35);
             mealcostTF.frame=CGRectMake(140, 145, 528, 40);
            //meannameTF.frame=CGRectMake(140, 145, 528, 40);
            discountlabel.frame=CGRectMake(140, 215, 100, 35);
            DiscountTF.frame=CGRectMake(140, 260, 528, 40);
            tax.frame=CGRectMake(140, 285, 100, 35);
            Coupon_Issue_Date.frame=CGRectMake(140, 350, 300, 35);
           
            Sendnotification.frame=CGRectMake(310, 480, 140, 40);

           
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 20, 320, 550);
                mealcost.frame=CGRectMake(10, 35, 100, 35);
                 mealcostTF.frame=CGRectMake(10, 75, 300, 35);
               // meannameTF.frame=CGRectMake(10, 70, 300, 35);
                discountlabel.frame=CGRectMake(10, 120, 100, 35);
                DiscountTF.frame=CGRectMake(10, 160, 300, 35);
                tax.frame=CGRectMake(10, 175, 100, 35);
                Coupon_Issue_Date.frame=CGRectMake(10, 220, 300, 35);
               
                 Sendnotification.frame=CGRectMake(90, 320, 140, 40);
                
                
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 20, 320, 550);
                
                mealcost.frame=CGRectMake(10, 10, 200, 35);
               // meannameTF.frame=CGRectMake(10, 50, 300, 35);
                discountlabel.frame=CGRectMake(10, 85, 100, 35);
               // DiscountTF.frame=CGRectMake(10, 140, 300, 35);
                tax.frame=CGRectMake(10, 155, 100, 35);
                
                Coupon_Issue_Date.frame=CGRectMake(10, 215, 200, 35);
                mealcostTF.frame=CGRectMake(10, 44, 300, 35);
                
                
                Sendnotification.frame=CGRectMake(90, 300, 140, 40);
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
