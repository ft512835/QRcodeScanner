//
//  WebsiteViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 27/05/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface WebsiteViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *Webview;
    UIButton *backbtn;
    UIImageView *headerimage;
}
@property(nonatomic,retain)MBProgressHUD *hud;

@end
