//
//  WebsiteViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 27/05/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "WebsiteViewController.h"
#import "MBProgressHUD.h"
@interface WebsiteViewController ()

@end

@implementation WebsiteViewController

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
       headerimage=[[UIImageView alloc]init];
    [headerimage setImage:[UIImage imageNamed:@"Untitled-5.png"]];
    [headerimage setUserInteractionEnabled:YES];
    [self.view addSubview:headerimage];

    
    backbtn=[[UIButton alloc]init];
  [backbtn setBackgroundColor:[UIColor clearColor] ];
  [backbtn setTitle:@"Done" forState:UIControlStateNormal];
   [backbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(backntnclick) forControlEvents:UIControlEventTouchUpInside];
  [headerimage addSubview:backbtn];
    
   // Do any additional setup after loading the view.
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

-(void)viewWillAppear:(BOOL)animated
{
     [self.navigationController.navigationBar setHidden:YES];
    [self showProgressForView:self.view WithMessage:@"Loading...."];
    
    NSString *tokenstring=[[NSUserDefaults standardUserDefaults] valueForKey:@"Session_Token"];
    Webview =[[UIWebView alloc]init];
    Webview.delegate=self ;
    
    //[Webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yumout.com/user-session?session_id=%@",tokenstring]]];
    NSString *string1=@"http://yumout.com/user-session?session_id=";
    NSString *string2=tokenstring;
    
    // NSString *string2=@"af085349d03f22160df475a60b31f700";
    
    
    NSString *string3=@"&@returnURL=http://yumout.com";
    NSString *stringurl=[string1 stringByAppendingString:string2];
    NSString *St=[stringurl stringByAppendingString:string3];
    NSLog(@"%@",St);
    // [Webview loadRequest:[[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"st"]]]];
    [Webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",St]]]];
    
    //http://yumout.com/user-session?session_id=3b16bc3f21803f1dbfc10b6d0f0fc120&returnURL=http://yumout.com/contacts.html
    [self.view addSubview:Webview];
    
    
}

-(void)backntnclick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidAppear:(BOOL)animated
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
   //[self.navigationController.navigationBar setHidden:YES];
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            Webview.frame=CGRectMake(00, 0, 1024, 698);
            headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 1024, 70);
            backbtn.frame=CGRectMake(10, 28, 60, 30);
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Webview.frame=CGRectMake(00, 0, 568, 270);
                headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 568, 50);
                backbtn.frame=CGRectMake(10, 12, 50, 25);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Webview.frame=CGRectMake(00, 0, 480, 270);
                headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 480, 50);
                backbtn.frame=CGRectMake(10, 12, 50, 25);
            }
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            Webview.frame=CGRectMake(00, 0, 768, 954);
            backbtn.frame=CGRectMake(15, 10, 70, 30);
            headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 768, 70);
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Webview.frame=CGRectMake(00, 0, 320, 518);
                backbtn.frame=CGRectMake(3, 12, 43, 25);
                headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 320, 50);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Webview.frame=CGRectMake(00,0, 320, 430);
                backbtn.frame=CGRectMake(3, 12, 43, 25);
                headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 320, 50);
                
                
                           }
        }
    }
}
/*
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
       {
            Webview.frame=CGRectMake(00, 00, 1024, 698);
             headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 1024, 70);
           // backbtn.frame=CGRectMake(10, 28, 60, 30);
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Webview.frame=CGRectMake(00,50, 568, 270);
                 headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 568, 50);
                //backbtn.frame=CGRectMake(10, 12, 50, 25);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Webview.frame=CGRectMake(00, 50, 480, 270);
                 headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 480, 50);
               // backbtn.frame=CGRectMake(10, 12, 50, 25);
            }
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            Webview.frame=CGRectMake(00, 50, 768, 954);
             //backbtn.frame=CGRectMake(5, 25, 50, 30);
             headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 768, 70);
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Webview.frame=CGRectMake(00, 50, 320, 568);
               //  backbtn.frame=CGRectMake(3, 12, 43, 25);
                 headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 320, 50);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Webview.frame=CGRectMake(00,50, 320, 480);
                //backbtn.frame=CGRectMake(3, 12, 43, 25);
                headerimage.frame=CGRectMake(00, self.view.frame.size.height - 44, 320, 50);
            }
           
        }
    }
}*/


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"ASDF");
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
