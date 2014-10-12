//
//  RegestrationViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegestrationViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *UserName,*Password,*ConfirmPassword;
    UITextField *Name;
    
    UITextField *EmailTF;
    UIImageView *emailbackground;
    
    UIImageView *NameBackground;
    UIImageView *UsernameBackground;
    UIImageView *PasswordBackground;
    UIScrollView *SignupScrollview;
    UILabel *Regestrationlabl;
    UIButton *RegisterButton;
    UIImageView *BackgroundImage;
    UIImageView *CnfrnPWrdBackground;
    NSURLConnection *regestrationConnection;
    UIAlertView *AlertforSucess;
    
    UITextField *UserRoleTF;
    UIImageView *UserRoleBAckground;
    UITableView *UserRoleTable;
    UIButton *SelectUserRoleButton;
    NSArray *UserRoleArrayData;
    
    UILabel *star1;
    UILabel *star2;
    UILabel *star3;
    UILabel *star4;
    UILabel *star5;
    UILabel *star6;
}

@end
