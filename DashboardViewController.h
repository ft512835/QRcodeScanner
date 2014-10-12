//
//  DashboardViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DashboardViewController : UIViewController<UITextFieldDelegate>
{
    UIImageView *BackgroundImage;
    UIButton *ScanQRbtn;
    UIButton *Paymentbtn;
    UIButton *SyncSystembtn;
    UIScrollView *dashBoardScrollview;
    UILabel *Regestrationlabl;
}

@end
