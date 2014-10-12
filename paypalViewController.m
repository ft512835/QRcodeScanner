//
//  paypalViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "paypalViewController.h"

#import "PayPalMobile.h"
#import "ZZFlipsideViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kPayPalEnvironment PayPalEnvironmentNoNetwork
#define kPayPalReceiverEmail PaypalOwneremail;

@interface paypalViewController ()
@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;
@property(nonatomic, strong, readwrite) IBOutlet UIButton *payFutureButton;
@property(nonatomic, strong, readwrite) IBOutlet UIView *successView;
@end

@implementation paypalViewController
@synthesize PaypalOwneremail;

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
    
    PaypalScrollview=[[UIScrollView alloc]init];
    [self.view addSubview:PaypalScrollview];
    
    Label1=[[UILabel alloc]init];
    Label1.text=@"Select Payment";
    [PaypalScrollview addSubview:Label1];
    
    Label2=[[UILabel alloc]init];
    Label2.text=@"Mode";
    [PaypalScrollview addSubview:Label2];
    
    
    paypalbutton =[[UIButton alloc]init];
    [paypalbutton setBackgroundImage:[UIImage imageNamed:@"paypal.png"] forState:UIControlStateNormal];
    [paypalbutton addTarget: self action:@selector(paypalbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [PaypalScrollview addSubview:paypalbutton];
    
    _payPalConfig = [[PayPalConfiguration alloc] init];
    _payPalConfig.acceptCreditCards = YES;
    _payPalConfig.languageOrLocale = @"en";
    _payPalConfig.merchantPrivacyPolicyURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/privacy-full"];
    _payPalConfig.merchantUserAgreementURL = [NSURL URLWithString:@"https://www.paypal.com/webapps/mpp/ua/useragreement-full"];
    _payPalConfig.languageOrLocale = [NSLocale preferredLanguages][0];
    self.successView.hidden = YES;
    self.environment = kPayPalEnvironment;
    // Do any additional setup after loading the view from its nib.
    
    kPayPalClientId=[[NSString alloc]init];
    kPayPalClientId=@"AXnSrhBuNkvCCGBarWlQt1zihXEiqvdViKjg0-VPOz7cqX_arWdtiO51Pz-l";
    
    kPayPalSecret=[[NSString alloc]init];
    kPayPalSecret=@"EHz6eBBkk4YjzZv9w2rTv1hZ10CRvNtYhCAPoYV17IOfkVjKMCk9HxX3xG_6";
}

-(void)paypalbuttonclick
{
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    payment.shortDescription = @"PAYPAL";
    payment.amount = [[NSDecimalNumber alloc] initWithString:@"9.95"];
    payment.currencyCode = @"USD";
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    [self showSuccess];
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    NSLog(@"PayPal Payment Canceled");
    self.resultText = nil;
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    // TODO: Send completedPayment.confirmation to server
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}
- (IBAction)getUserAuthorization:(id)sender
{
    
    PayPalFuturePaymentViewController *futurePaymentViewController = [[PayPalFuturePaymentViewController alloc] initWithConfiguration:self.payPalConfig delegate:self];
    [self presentViewController:futurePaymentViewController animated:YES completion:nil];
}

- (void)payPalFuturePaymentViewController:(PayPalFuturePaymentViewController *)futurePaymentViewController didAuthorizeFuturePayment:(NSDictionary *)futurePaymentAuthorization
{
    NSLog(@"PayPal Future Payment Authorization Success!");
    self.resultText = futurePaymentAuthorization[@"code"];
    [self showSuccess];
    
    [self sendAuthorizationToServer:futurePaymentAuthorization];
    [self dismissViewControllerAnimated:YES completion:nil];
}




- (void)payPalFuturePaymentDidCancel:(PayPalFuturePaymentViewController *)futurePaymentViewController
{
    NSLog(@"PayPal Future Payment Authorization Canceled");
    self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendAuthorizationToServer:(NSDictionary *)authorization {
    // TODO: Send authorization to server
    NSLog(@"Here is your authorization:\n\n%@\n\nSend this to your server to complete future payment setup.", authorization);
}
- (void)showSuccess {
    self.successView.hidden = NO;
    self.successView.alpha = 1.0f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelay:2.0];
    self.successView.alpha = 0.0f;
    [UIView commitAnimations];
}
- (void)flipsideViewControllerDidFinish:(ZZFlipsideViewController *)controller {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    }
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
            
           
           
            
            
            PaypalScrollview.frame=CGRectMake(00, 60, 1024,700);
            [PaypalScrollview setContentSize:CGSizeMake(1024, 600)];
            Label1.frame=CGRectMake(400, -30, 187, 25);
            Label2.frame=CGRectMake(450, 0, 187, 25);
            paypalbutton.frame=CGRectMake(350, 404, 260, 180);
            
        }
        else
        {
            BackgroundImage.frame=CGRectMake(00, 20, 568, 320);
            PaypalScrollview.frame=CGRectMake(00, 55, 568,260);
            [PaypalScrollview setContentSize:CGSizeMake(320, 300)];
            Label1.frame=CGRectMake(200, 10, 157, 23);
            Label2.frame=CGRectMake(240, 30, 72, 23);
            paypalbutton.frame=CGRectMake(210, 120, 150, 100);
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
             BackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
            PaypalScrollview.frame=CGRectMake(00, 60, 768,950);
            [PaypalScrollview setContentSize:CGSizeMake(768, 900)];
            Label1.frame=CGRectMake(300, -30, 187, 25);
            Label2.frame=CGRectMake(350, 0, 187, 25);
            paypalbutton.frame=CGRectMake(250, 504, 260, 180);
        }
        else
        {
             BackgroundImage.frame=CGRectMake(00, 20, 320, 548);
            PaypalScrollview.frame=CGRectMake(00, 60, 320,510);
            [PaypalScrollview setContentSize:CGSizeMake(320, 430)];
            Label1.frame=CGRectMake(88, 10, 157, 23);
            Label2.frame=CGRectMake(126, 30, 72, 23);
            paypalbutton.frame=CGRectMake(90, 250, 150, 100);
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
