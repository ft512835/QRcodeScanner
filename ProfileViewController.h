//
//  ProfileViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 01/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *BackgroundImage;
    UIScrollView *Scrollview;
    UILabel *Username;
    UILabel *organization;
    UILabel *Phnnumber;
    UILabel *Name;
    UILabel *NameLabel;
    UILabel *UsernameEdit;
    UILabel *UsernameLabel;
    UILabel *EmailID;
    UILabel *EmailIdLabel;
    UILabel *SavedCoupn;
    UITableView *Tableview;
    NSArray *array;
    UIButton *SubmittButton;
    
    
    
  }
@property(nonatomic,retain)UIImageView *imageview;

@end
