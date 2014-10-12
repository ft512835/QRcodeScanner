//
//  SendbillViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 03/05/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "SendbillViewController.h"

@interface SendbillViewController ()

@end

@implementation SendbillViewController

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
    
    mealnamelabel=[[UILabel alloc]init];
    mealnamelabel.text=@"Accepted Quality";
    [Scrollview addSubview:mealnamelabel];
    
    meannameTF=[[UITextField alloc]init];
    meannameTF.layer.borderColor=[UIColor blackColor].CGColor ;
    [meannameTF setDelegate:self];
    meannameTF.layer.borderWidth=1.0f;
    [Scrollview addSubview:meannameTF];
    
    
    discountlabel=[[UILabel alloc]init];
    discountlabel.text=@"Discount";
    [Scrollview addSubview:discountlabel];
    
    DiscountTF=[[UITextField alloc]init];
    DiscountTF.layer.borderColor=[UIColor blackColor].CGColor ;
    [DiscountTF setDelegate:self];
    DiscountTF.layer.borderWidth=1.0f;
    [Scrollview addSubview:DiscountTF];
    
    totallabel=[[UILabel alloc]init];
    totallabel.text=@"Total";
    [Scrollview addSubview:totallabel];
    
    TotalTF=[[UITextField alloc]init];
    [TotalTF setDelegate:self];
    TotalTF.layer.borderColor=[UIColor blackColor].CGColor ;
    TotalTF.layer.borderWidth=1.0f;
    [Scrollview addSubview:TotalTF];
    
    
    Sendbillbutton=[[UIButton alloc]init];
    [Sendbillbutton setTitle:@"Send Notification" forState:UIControlStateNormal];
    [Sendbillbutton addTarget:self action:@selector(billbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:Sendbillbutton];
    // Do any additional setup after loading the view.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [meannameTF resignFirstResponder];
    [DiscountTF resignFirstResponder];
    [TotalTF resignFirstResponder];
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

-(void)billbuttonclick
{
    NSLog(@"sdfs");
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
            
            mealnamelabel.frame=CGRectMake(250, 100, 150, 35);
            meannameTF.frame=CGRectMake(250, 145, 528, 40);
            discountlabel.frame=CGRectMake(250, 215, 100, 35);
            DiscountTF.frame=CGRectMake(250, 260, 528, 40);
            totallabel.frame=CGRectMake(250, 335, 100, 35);
            TotalTF.frame=CGRectMake(250, 380, 528, 40);
            Sendbillbutton.frame=CGRectMake(430, 480, 140, 40);
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 53, 568,280);
                [Scrollview setContentSize:CGSizeMake(568, 340)];
                BackgroundImage.frame=CGRectMake(00, 20, 568, 300);
                
                mealnamelabel.frame=CGRectMake(20, 15, 160, 35);
                meannameTF.frame=CGRectMake(20, 50, 528, 35);
                discountlabel.frame=CGRectMake(20, 100, 100, 35);
                DiscountTF.frame=CGRectMake(20, 140, 528, 35);
                totallabel.frame=CGRectMake(20, 190, 100, 35);
                TotalTF.frame=CGRectMake(20, 225, 528, 35);
                Sendbillbutton.frame=CGRectMake(210, 270, 140, 40);
                
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 53, 480,280);
                [Scrollview setContentSize:CGSizeMake(480, 340)];
                BackgroundImage.frame=CGRectMake(00, 20, 480, 300);
                
                mealnamelabel.frame=CGRectMake(20, 15, 160, 35);
                meannameTF.frame=CGRectMake(20, 50, 440, 35);
                discountlabel.frame=CGRectMake(20, 100, 100, 35);
                DiscountTF.frame=CGRectMake(20, 140, 440, 35);
                totallabel.frame=CGRectMake(20, 190, 100, 35);
                TotalTF.frame=CGRectMake(20, 225, 440, 35);
                Sendbillbutton.frame=CGRectMake(170, 270, 140, 40);
                
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
            
            mealnamelabel.frame=CGRectMake(140, 100, 160, 35);
            meannameTF.frame=CGRectMake(140, 145, 528, 40);
            discountlabel.frame=CGRectMake(140, 215, 100, 35);
            DiscountTF.frame=CGRectMake(140, 260, 528, 40);
            totallabel.frame=CGRectMake(140, 335, 100, 35);
            TotalTF.frame=CGRectMake(140, 380, 528, 40);
            Sendbillbutton.frame=CGRectMake(310, 480, 140, 40);
            
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 20, 320, 550);
                
                mealnamelabel.frame=CGRectMake(10, 10, 160, 35);
                meannameTF.frame=CGRectMake(10, 50, 300, 35);
                discountlabel.frame=CGRectMake(10, 95, 100, 35);
                DiscountTF.frame=CGRectMake(10, 140, 300, 35);
                totallabel.frame=CGRectMake(10, 185, 100, 35);
                TotalTF.frame=CGRectMake(10, 225, 300, 35);
                Sendbillbutton.frame=CGRectMake(80, 270, 140, 40);
                
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 20, 320, 550);
                mealnamelabel.frame=CGRectMake(10, 10, 130, 35);
                meannameTF.frame=CGRectMake(10, 50, 300, 35);
                discountlabel.frame=CGRectMake(10, 95, 100, 35);
                DiscountTF.frame=CGRectMake(10, 140, 300, 35);
                totallabel.frame=CGRectMake(10, 185, 100, 35);
                TotalTF.frame=CGRectMake(10, 225, 300, 35);
                Sendbillbutton.frame=CGRectMake(80, 270, 140, 40);
            }
            
            
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
