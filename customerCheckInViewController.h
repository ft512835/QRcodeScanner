//
//  customerCheckInViewController.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 25/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customerCheckInViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    
        UIImageView *BackgroundImage;
        UIScrollView  *Scrollview;
    UITableView *Tableview;
    UITableViewCell *cell;
    NSArray *Array;
   NSURLConnection *checkinConnection;
    NSURLConnection *UserInfoConnection;
    
    NSString *useridstring;
    NSString *sessiontoken;
}

@end
