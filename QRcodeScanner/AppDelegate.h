//
//  AppDelegate.h
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigationController;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@end
