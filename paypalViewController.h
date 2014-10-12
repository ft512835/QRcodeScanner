//
//  paypalViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPalMobile.h"

@interface paypalViewController : UIViewController<PayPalPaymentDelegate>
{
    IBOutlet UIButton *paypalbutton;
    UIScrollView *PaypalScrollview;
    UILabel *Label1;
    UILabel *Label2;
    NSString *kPayPalClientId;
    NSString *kPayPalSecret;
    UIImageView *BackgroundImage;
    NSString *PaypalOwneremail;
    
}
//-(IBAction)paypalbuttonclick:(id)sender;
@property(nonatomic, strong, readwrite) UIPopoverController *flipsidePopoverController;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) NSString *resultText;
@property(nonatomic,strong)NSString *PaypalOwneremail;
@end
