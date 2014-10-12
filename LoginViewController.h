//
//  LoginViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYSoapTool.h"
#import "AppDelegate.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>
{
    UIImageView *loginBackground;
    UITextField *UserName;
   UIImageView *PasswordBackground;
    UITextField *Password;
    UIButton *LoginButton;
    UIButton *RegisterButton;
    UIScrollView *LoginScrollview;
    UIImageView *LogoImAge;
    UILabel *Regestrationlabl;
    UIImageView *BackgroundImage;
    NSURLConnection *LoginConnection;
    SYSoapTool *soaptool;
    NSMutableData *responseData;
    UIAlertView *AlertforSucess;
    UIButton *ForgetPassword;
    id result;
    UILabel *underlinePassword;
    
    NSString *User_id;
    NSString *Token;
    NSString *expirytime;
    UIAlertView *OwnerAlertView;
   
   
}

@end
