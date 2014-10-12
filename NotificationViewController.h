//
//  NotificationViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 03/05/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationViewController : UIViewController<UITextFieldDelegate>
{
    UIImageView *BackgroundImage;
    UIScrollView  *Scrollview;
    
    UILabel *Coupon_Issue_Date,*discountlabel,*tax,*mealcost;
    UITextField *mealcostTF,*DiscountTF,*TotalTF;
    UIButton *Sendnotification;

}

@end
