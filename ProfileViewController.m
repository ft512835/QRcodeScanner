//
//  ProfileViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 01/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "ProfileViewController.h"


@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize imageview;

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
    self.navigationItem.title=@"Profile";
    [self.navigationController.navigationBar setHidden:NO];
   
    [self CreateUI];
    array=[[NSArray alloc]initWithObjects:@"item 1",@"item 2",@"item 3", nil];
    // Do any additional setup after loading the view.
}


-(void)CreateUI
{
    NSString *NameString=[[NSUserDefaults standardUserDefaults]valueForKey:@"Name"];
   NSString *UserNameString= [[NSUserDefaults standardUserDefaults]valueForKey:@"User_Name"];
   NSString *EmailString= [[NSUserDefaults standardUserDefaults]valueForKey:@"E-mail"];
    
    BackgroundImage=[[UIImageView alloc]init];
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    Scrollview=[[UIScrollView alloc]init];
    [self.view addSubview:Scrollview];
    
    Username=[[UILabel alloc]init];
    Username.text=@"testing";
    [Scrollview addSubview:Username];
    
    organization=[[UILabel alloc]init];
    organization.text=@"organization";
    [Scrollview addSubview:organization];
    
    Phnnumber=[[UILabel alloc]init];
    Phnnumber.text=@"4545465655";
    [Scrollview addSubview:Phnnumber];
    
    imageview=[[UIImageView alloc]init];
    [imageview setImage:[UIImage imageNamed:@"user.png"]];
    [Scrollview addSubview:imageview];
    
    Name=[[UILabel alloc]init];
    Name.text=@"Name";
    [Scrollview addSubview:Name];
    
    NameLabel=[[UILabel alloc]init];
    NameLabel.text=NameString;
//    [NameTF setDelegate:self];
//    NSString *NameString= [[NSUserDefaults standardUserDefaults]valueForKeyPath:@"Name"];
//    NSLog(@"%@",NameString);
//
//    [NameTF setBackgroundColor:[UIColor whiteColor]];
//    NameTF.placeholder=@"Tap to Enter";
    [Scrollview addSubview:NameLabel];
    
    UsernameEdit=[[UILabel alloc]init];
    UsernameEdit.text=@"Username";
    [Scrollview addSubview:UsernameEdit];
    
    UsernameLabel=[[UILabel alloc]init];
    UsernameLabel.text=UserNameString;
    [Scrollview addSubview:UsernameLabel];
    
    
    EmailID=[[UILabel alloc]init];
    EmailID.text=@"Email Address";
    [Scrollview addSubview:EmailID];
    
    EmailIdLabel=[[UILabel alloc]init];
    EmailIdLabel.text=EmailString;
    [Scrollview addSubview:EmailIdLabel];
    
    SavedCoupn=[[UILabel alloc]init];
    SavedCoupn.text=@"Saved Coupons";
    [Scrollview addSubview:SavedCoupn];
    
    Tableview =[[UITableView alloc]init];
    [Tableview setDelegate:self];
    [Tableview setDataSource:self];
    [Scrollview addSubview:Tableview];
    
    SubmittButton=[[UIButton alloc]init];
    [SubmittButton setBackgroundImage:[UIImage imageNamed:@"button_.png"] forState:UIControlStateNormal];
    [SubmittButton setTitle:@"Submitt" forState:UIControlStateNormal];
    [Scrollview addSubview:SubmittButton];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return[array count];
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [array objectAtIndex:indexPath.row] ;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ItemName=[[NSString alloc]init];
    ItemName=[array objectAtIndex:indexPath.row];
    NSLog(@"%@",ItemName);
    [[NSUserDefaults standardUserDefaults]setValue:ItemName forKeyPath:@"Item_name"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   
//    SelectSavedCoupanItemViewController *selectItem=[[SelectSavedCoupanItemViewController alloc]init];
//    [self.navigationController pushViewController:selectItem animated:YES];
}


//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//        if (textField == EmailIdTF)
//        {
//            CGRect frame = self.view.frame;
//            frame.origin.y = frame.origin.y-50;
//            self.view.frame = frame;
//            
//        }
//    }
//    return YES;
//}
//
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//{
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//    {
//        if (textField == EmailIdTF)
//        {
//            CGRect frame = self.view.frame;
//            frame.origin.y = frame.origin.y+50;
//            self.view.frame = frame;
//        }
//    }
//    return YES;
//}
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    [textField resignFirstResponder];
//    return YES;
//}


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
            Scrollview.frame=CGRectMake(00, 60, 1024,760);
            [Scrollview setContentSize:CGSizeMake(1024, 900)];
            BackgroundImage.frame=CGRectMake(00, 20, 1024, 760);
            Username.frame=CGRectMake(140, 20+20, 180, 45);
            imageview.frame=CGRectMake(700, 15, 150, 160);
            organization.frame=CGRectMake(140, 50+20, 180, 45);
            Phnnumber.frame=CGRectMake(140, 80+20, 180, 45);
            Name.frame=CGRectMake(140, 170, 140, 28);
            NameLabel.frame=CGRectMake(150, 200, 700, 40);
            UsernameEdit.frame=CGRectMake(140, 250, 140, 28);
            UsernameLabel.frame=CGRectMake(150, 280, 700, 40);
            EmailID.frame=CGRectMake(140, 330, 140, 28);
            EmailIdLabel.frame=CGRectMake(150, 360, 700, 40);
           // SavedCoupn.frame=CGRectMake(140, 410, 140, 28);
          //  Tableview.frame=CGRectMake(150, 440, 700, 300);
          //  SubmittButton.frame=CGRectMake(400, 760, 150, 60);
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
            Scrollview.frame=CGRectMake(00, 53, 568,270);
            [Scrollview setContentSize:CGSizeMake(320, 400)];
            BackgroundImage.frame=CGRectMake(00, 20, 568, 300);
            Username.frame=CGRectMake(100, 20+15, 180, 25);
            imageview.frame=CGRectMake(370, 15, 130, 120);
            organization.frame=CGRectMake(100, 50+15, 180, 25);
            Phnnumber.frame=CGRectMake(100, 80+15, 180, 25);
            Name.frame=CGRectMake(100, 140, 140, 28);
            NameLabel.frame=CGRectMake(110, 170, 336, 30);
            UsernameEdit.frame=CGRectMake(100, 210, 140, 28);
            UsernameLabel.frame=CGRectMake(110, 240, 336, 30);
            EmailID.frame=CGRectMake(100, 280, 140, 28);
            EmailIdLabel.frame=CGRectMake(110, 310, 336, 30);
           // SavedCoupn.frame=CGRectMake(100, 350, 140, 28);
           // Tableview.frame=CGRectMake(110, 385, 336, 150);
          //  SubmittButton.frame=CGRectMake(220, 545, 120, 40);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 53, 480,270);
                [Scrollview setContentSize:CGSizeMake(480, 370)];
                BackgroundImage.frame=CGRectMake(00, 20, 480, 300);
                
                Username.frame=CGRectMake(70, 20+15, 180, 25);
                imageview.frame=CGRectMake(330, 15, 130, 120);
                organization.frame=CGRectMake(70, 50+15, 180, 25);
                Phnnumber.frame=CGRectMake(70, 80+15, 180, 25);
                Name.frame=CGRectMake(70, 140, 140, 28);
                
                NameLabel.frame=CGRectMake(80, 170, 150, 30);
                UsernameEdit.frame=CGRectMake(70, 210, 140, 28);
                UsernameLabel.frame=CGRectMake(80, 240, 336, 30);
                EmailID.frame=CGRectMake(70, 280, 140, 28);
                EmailIdLabel.frame=CGRectMake(80, 310, 336, 30);
               // SavedCoupn.frame=CGRectMake(70, 350, 140, 28);
               // Tableview.frame=CGRectMake(80, 385, 336, 150);
               // SubmittButton.frame=CGRectMake(200, 545, 120, 40);
 
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
            
            Username.frame=CGRectMake(35, 20+20, 180, 45);
            imageview.frame=CGRectMake(500, 15, 150, 160);
            organization.frame=CGRectMake(35, 50+20, 180, 45);
            Phnnumber.frame=CGRectMake(35, 80+20, 180, 45);
            
            
            Name.frame=CGRectMake(35, 170, 140, 28);
            NameLabel.frame=CGRectMake(45, 200, 600, 40);
            UsernameEdit.frame=CGRectMake(35, 250, 140, 28);
            UsernameLabel.frame=CGRectMake(45, 280, 600, 40);
            EmailID.frame=CGRectMake(35, 330, 140, 28);
            EmailIdLabel.frame=CGRectMake(45, 360, 600, 40);
           // SavedCoupn.frame=CGRectMake(35, 410, 140, 28);
           // Tableview.frame=CGRectMake(45, 440, 600, 350);
            //SubmittButton.frame=CGRectMake(300, 820, 150, 60);
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
            Scrollview.frame=CGRectMake(00, 60, 320,508);
            [Scrollview setContentSize:CGSizeMake(320, 450)];
             BackgroundImage.frame=CGRectMake(00, 20, 320, 548);
            Username.frame=CGRectMake(15, 20+15, 180, 25);
            imageview.frame=CGRectMake(170, 15, 130, 120);
            organization.frame=CGRectMake(15, 50+15, 180, 25);
            Phnnumber.frame=CGRectMake(15, 80+15, 180, 25);
            Name.frame=CGRectMake(15, 140, 140, 28);
            NameLabel.frame=CGRectMake(20, 170, 286, 30);
            UsernameEdit.frame=CGRectMake(15, 210, 140, 28);
            UsernameLabel.frame=CGRectMake(20, 240, 286, 30);
            EmailID.frame=CGRectMake(15, 280, 140, 28);
            EmailIdLabel.frame=CGRectMake(20, 310, 286, 30);
            //SavedCoupn.frame=CGRectMake(15, 350, 140, 28);
           // Tableview.frame=CGRectMake(20, 385, 280, 150);
           // SubmittButton.frame=CGRectMake(120, 545, 80, 40);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 60, 320,420);
                [Scrollview setContentSize:CGSizeMake(320, 420)];
                BackgroundImage.frame=CGRectMake(00, 20, 320, 548);
                Username.frame=CGRectMake(15, 20+15, 180, 25);
                imageview.frame=CGRectMake(170, 15, 130, 120);
                organization.frame=CGRectMake(15, 50+15, 180, 25);
                Phnnumber.frame=CGRectMake(15, 80+15, 180, 25);
                Name.frame=CGRectMake(15, 140, 140, 28);
                NameLabel.frame=CGRectMake(20, 170, 286, 30);
                UsernameEdit.frame=CGRectMake(15, 210, 140, 28);
                UsernameLabel.frame=CGRectMake(20, 240, 286, 30);
                EmailID.frame=CGRectMake(15, 280, 140, 28);
                EmailIdLabel.frame=CGRectMake(20, 310, 286, 30);
                //SavedCoupn.frame=CGRectMake(15, 350, 140, 28);
               // Tableview.frame=CGRectMake(20, 385, 280, 150);
                //SubmittButton.frame=CGRectMake(120, 545, 80, 40);
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
