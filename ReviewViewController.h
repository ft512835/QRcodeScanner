//
//  ReviewViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 01/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewViewController : UIViewController<UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
{
    UIImageView *BackgroundImage;
    UIScrollView *Scrollview;
    UIImageView *profileimage;
    UIButton *BRowseButton;
    UILabel *menuItemScore;
    UILabel *servicelabel;
    UILabel *menuItemCost;
    UITextField *ItemCostTF;
    UILabel *ReviewTitleLabel;
    UITextField *ReviewtitleTF;
    UILabel *ReviewDescription;
    UITextView *reviewDescriptionTF;
    NSString *imagename;
    UIImagePickerController *imagePicker;
    UIButton *SubmittButton;
}

@end
