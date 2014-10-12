//
//  CompleteRegisterationViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 16/05/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "CompleteRegisterationViewController.h"

@interface CompleteRegisterationViewController ()

@end

@implementation CompleteRegisterationViewController

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
    
    thankslablel =[[UILabel alloc]init];
    thankslablel.textColor=[UIColor whiteColor];
    thankslablel.text=@"Thanks for Resistarion.Go to website and register your resturant";
    [self.view addSubview:thankslablel];
    
    urlButton=[[UIButton alloc]init];
    [urlButton setTitle:@"http://demo.redsymbolhost.com/market/sitelatest/" forState:UIControlStateNormal];
    [urlButton setTitleColor:[UIColor colorWithRed:80/255.0 green:154/255.0 blue:227/255.0 alpha:1] forState:UIControlStateNormal];
    [urlButton addTarget:self action:@selector(urlclick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:urlButton];
    
    // Do any additional setup after loading the view.
}

-(void)urlclick
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://demo.redsymbolhost.com/market/sitelatest/"]];
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
            
            thankslablel.frame=CGRectMake(210, 280, 700, 50);
            thankslablel.numberOfLines=2;
            urlButton.frame=CGRectMake(230, 380, 510, 15);
       
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 53, 568,280);
                [Scrollview setContentSize:CGSizeMake(568, 340)];
                BackgroundImage.frame=CGRectMake(00, 20, 568, 300);
                thankslablel.frame=CGRectMake(10, 120, 548, 50);
                thankslablel.numberOfLines=2;
                urlButton.frame=CGRectMake(5, 220, 558, 15);
                
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 53, 480,280);
                [Scrollview setContentSize:CGSizeMake(480, 340)];
                BackgroundImage.frame=CGRectMake(00, 20, 480, 300);
                thankslablel.frame=CGRectMake(10, 120, 460, 50);
                thankslablel.numberOfLines=2;
                urlButton.frame=CGRectMake(5, 220, 470, 15);
              
                
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
            thankslablel.frame=CGRectMake(110, 280, 700, 50);
            thankslablel.numberOfLines=2;
            urlButton.frame=CGRectMake(120, 380, 510, 15);

            
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 20, 320, 550);
                thankslablel.frame=CGRectMake(10, 170, 300, 50);
                thankslablel.numberOfLines=2;
                urlButton.frame=CGRectMake(5, 240, 310, 15);
                urlButton.titleLabel.font = [UIFont systemFontOfSize: 12];
                
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 20, 320, 550);
                thankslablel.frame=CGRectMake(10, 180, 300, 50);
                thankslablel.numberOfLines=2;
                urlButton.frame=CGRectMake(5, 250, 310, 15);
                urlButton.titleLabel.font = [UIFont systemFontOfSize: 12];
                
               
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
