//
//  EmployeeprocessViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 02/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZBarSDK.h"
#import "ZBarSDK.h"

@interface EmployeeprocessViewController : UIViewController<ZBarReaderDelegate,UIImagePickerControllerDelegate>
{
    UIImageView *BackgroundImage;
    UIScrollView *Scrollview;
    UIButton *Checkinbutton;
    UIButton *codeScannbutton;
    UIView *Checkinlistview;
     UIButton *CancelButton;
     NSURLConnection *CodeScanConnection;
     UIImage *buttonImage;
     UIButton *aButton;
     UIBarButtonItem *aBarButtonItem;
     UIButton *LogoutButton;
     NSURLConnection *LogoutConnection;
     NSURLConnection *UserInfoConnection;
     ZBarReaderViewController *codeReader;
     NSURLConnection *Logout_Connection;
     NSString *resturentid;
     UILabel *WelComeLabel;
     UILabel *usernamelabel;
     NSString *NameString;
     NSMutableArray *userdetailarray;
     
     }
@property(strong,nonatomic)NSString *datastring1;
@end
