//
//  customerCheckInViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 25/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "customerCheckInViewController.h"
#import "NotificationViewController.h"
#import "MBProgressHUD.h"

@interface customerCheckInViewController ()
@property(nonatomic,retain)MBProgressHUD *hud;
@end

@implementation customerCheckInViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setHidden:NO];
    self.navigationItem.title=@"Check in list";
    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    Scrollview=[[UIScrollView alloc]init];
    [self.view addSubview:Scrollview];
    
    
    
    [self CreateUI];
   
    //Array=[[NSArray alloc]initWithObjects:@"user 1",@"user 2",@"user 3",@"user 4", nil];
    // Do any additional setup after loading the view.
}

//




-(void)CreateUI
{
    Tableview=[[UITableView alloc]init];
        [Tableview setDelegate:self];
        [Tableview setDataSource:self];
        Tableview.layer.borderColor=[UIColor blackColor].CGColor;
        Tableview.layer.borderWidth=.6f;
        [Scrollview addSubview:Tableview];
    [self checkinuserdetail];
}

-(void)checkinuserdetail
{
    
    [self showProgressForView:self.view WithMessage:@"Loading...."];
  // [self performSelectorOnMainThread:@selector(getinfoSucess) withObject:self.view waitUntilDone:NO];
    
    
    NSString *resturentidstring=[[NSUserDefaults standardUserDefaults]valueForKey:@"resturentid"];
    NSLog(@"%@",resturentidstring);
    useridstring=[[NSUserDefaults standardUserDefaults]valueForKey:@"User_id"];
    NSLog(@"%@",useridstring);
    sessiontoken=[[NSUserDefaults standardUserDefaults]valueForKey:@"Session_Token"];
    NSLog(@"%@",sessiontoken);
    
    NSString *post=[[NSString alloc]initWithFormat:@"user_id=%@&restaurant_id=%@&session_token=%@",useridstring,resturentidstring,sessiontoken];
    
    NSLog(@"%@",post);
    NSURL *url=[NSURL URLWithString:@"http://yumout.com/rest/api.php?rquest=getCheckinList"];
    NSLog(@"%@",url);
    
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSLog(@"%@",postData);
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init] ;
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSLog(@"%@",urlData);
    
    id result=[NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
    
    NSLog(@"%@",result);
    if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
        
    {
        

        [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
        
        //[self performSelectorOnMainThread:@selector(LogoutSucess) withObject:self.view waitUntilDone:NO];
    }
    else
    {
       Array =[result valueForKey:@"restaurant_id"];
        NSLog(@"%@",Array);
        [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
    }
    
    

  
    
    
    
   /*
    [self showProgressForView:self.view WithMessage:@"Loading...."];
   NSString *resturentidstring=[[NSUserDefaults standardUserDefaults]valueForKey:@"resturentid"];
    NSLog(@"%@",resturentidstring);
   useridstring=[[NSUserDefaults standardUserDefaults]valueForKey:@"User_id"];
     NSLog(@"%@",useridstring);
    sessiontoken=[[NSUserDefaults standardUserDefaults]valueForKey:@"Session_Token"];
     NSLog(@"%@",sessiontoken);
    
    NSString *post=[[NSString alloc]initWithFormat:@"user_id=%@&restaurant_id=%@&session_token=%@",useridstring,resturentidstring,sessiontoken];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:NO];
    NSString * postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://yumout.com/rest/api.php?rquest=getCheckinList"]]];
     NSLog(@"%@",request);
    checkinConnection=[NSURLConnection connectionWithRequest:request delegate:self];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    NSOperationQueue *queue =[[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSLog(@"%@",data);
        id result=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&connectionError];
        
         
         if ([[result valueForKey:@"status"]isEqualToString:@"Success"])
         {
             if ([[result valueForKey:@"msg"]isEqualToString:@"No checkin user found."])
             {
                [self performSelectorOnMainThread:@selector(Alert) withObject:Nil waitUntilDone:NO];
             }
            [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
            // [self performSelectorOnMainThread:@selector(suceessmethod) withObject:Nil waitUntilDone:NO];
         }
         else
         {
             NSLog(@"sd");
             [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];
            // [self performSelectorOnMainThread:@selector(Loginalertmethod) withObject:Nil waitUntilDone:NO];
         }
     }];*/

}
- (void)showProgressForView:(UIView *)view WithMessage:(NSString *)message
{
    self.hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    _hud.labelText = message;
}

- (void)hideProgressForView:(UIView*)view
{
    if (_hud)
    {
        [MBProgressHUD hideHUDForView:view animated:YES];
        self.hud = nil;
    }
}


-(void)Alert
{
    UIAlertView *masgalert=[[UIAlertView alloc]initWithTitle:@"Massage" message:@"No checkin user found." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:Nil, nil];
    [masgalert show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return[Array count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[Array objectAtIndex:indexPath.row];
    NSLog(@"%ld",(long)indexPath.row);
    //[cell.imageView setImageWithURL:[NSURL URLWithString:[[MenuArray objectAtIndex:indexPath.row] valueForKey:@"restaurant_image_url"]] placeholderImage:[UIImage imageNamed:@"user.png"]  options:SDWebImageRefreshCached];
  //   [self performSelectorOnMainThread:@selector(hideProgressForView:) withObject:self.view waitUntilDone:NO];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NotificationViewController *shareCheckin=[[NotificationViewController alloc]init];
    [self.navigationController pushViewController:shareCheckin animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    if(([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeLeft) || ([[UIApplication sharedApplication]statusBarOrientation] == UIInterfaceOrientationLandscapeRight))
    {
        [self willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationLandscapeLeft duration:2];
        [self willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationLandscapeRight duration:2];
        
    }
    else
    {
        [self willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortrait duration:2];
        [self willAnimateRotationToInterfaceOrientation:UIInterfaceOrientationPortraitUpsideDown duration:2];
        
    }
    
}


-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if (toInterfaceOrientation==UIInterfaceOrientationLandscapeLeft||toInterfaceOrientation==UIInterfaceOrientationLandscapeRight)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            Scrollview.frame=CGRectMake(00, 60, 1024,970);
            [Scrollview setContentSize:CGSizeMake(1024, 760)];
            BackgroundImage.frame=CGRectMake(00, 20, 1024, 760);
            Tableview.frame=CGRectMake(160, 130, 700, 400);
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 53, 568,280);
                [Scrollview setContentSize:CGSizeMake(568, 280)];
                BackgroundImage.frame=CGRectMake(00, 20, 568, 300);
                 Tableview.frame=CGRectMake(50, 10, 468, 240);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 53, 480,280);
                [Scrollview setContentSize:CGSizeMake(480, 300)];
                BackgroundImage.frame=CGRectMake(00, 20, 480, 300);
                Tableview.frame=CGRectMake(30, 10, 420, 240);
            }
            
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
            Scrollview.frame=CGRectMake(00, 60, 768,970);
            [Scrollview setContentSize:CGSizeMake(768, 970)];
            BackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
             Tableview.frame=CGRectMake(100, 150, 568, 480);
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 20, 320, 550);
                 Tableview.frame=CGRectMake(20, 80, 280, 350);
               
                
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,508);
                [Scrollview setContentSize:CGSizeMake(320, 500)];
                BackgroundImage.frame=CGRectMake(00, 20, 320, 550);
                Tableview.frame=CGRectMake(20, 60, 280, 300);
            }
            
            
        }
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
