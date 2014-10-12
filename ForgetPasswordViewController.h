//
//  ForgetPasswordViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 01/05/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordViewController : UIViewController<UITextFieldDelegate>
{
    UIImageView *BackgroundImage;
    UIScrollView *ScrollView;
    UILabel *messagealertlabel;
    UITextField *EmailTF;
    UIButton *Submittbutton;
    UILabel *EmailAddress;
    UILabel *Star;
    UIAlertView *Alert;
    NSURLConnection *ForgrtPasswordConnection;
}

@end
