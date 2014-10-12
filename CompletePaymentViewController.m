//
//  CompletePaymentViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 07/03/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "CompletePaymentViewController.h"
#import "paypalViewController.h"
@interface CompletePaymentViewController ()

@end

@implementation CompletePaymentViewController

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
    [self CreateUI];
    array=[[NSArray alloc]initWithObjects:@"setting1",@"setting1",@"setting1",@"setting1",nil];
    // Do any additional setup after loading the view from its nib.
}
-(void)CreateUI
{
    mainBackgroundImage=[[UIImageView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        mainBackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
    }
    else
    {
        mainBackgroundImage.frame=CGRectMake(00, 20, 320, 548);
    }
    
    [mainBackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:mainBackgroundImage];

    
    Scrollview=[[UIScrollView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        Scrollview.frame=CGRectMake(00, 60, 768,970);
        [Scrollview setContentSize:CGSizeMake(768, 800)];
    }
    else
    {
        Scrollview.frame=CGRectMake(00, 60, 320,510);
        [Scrollview setContentSize:CGSizeMake(320, 430)];
    }
    [self.view addSubview:Scrollview];
    
    
    
    PaymentUIlabel =[[UILabel alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         PaymentUIlabel.frame=CGRectMake(325,-50, 200, 40);
        PaymentUIlabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:25];
    }
    else
    {
        PaymentUIlabel.frame=CGRectMake(110,-50, 200, 40);
         PaymentUIlabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:21];
    }
    PaymentUIlabel.text=@"Payment UI";
    [Scrollview addSubview:PaymentUIlabel];
    
    
    selectButton=[[UIButton alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         selectButton.frame=CGRectMake(80, 25, 250, 40);
    }
    else
    {
        selectButton.frame=CGRectMake(30, 15, 90, 40);
    }
    [selectButton setTitle:@"Select" forState:UIControlStateNormal];
    [selectButton setBackgroundColor:[UIColor blackColor]];
    [Scrollview addSubview:selectButton];
    
    selectAllButton=[[UIButton alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
          selectAllButton.frame=CGRectMake(340, 25, 250, 40);
    }
    else
    {
        selectAllButton.frame=CGRectMake(125, 15, 100, 40);
    }
    [selectAllButton setTitle:@"Select All" forState:UIControlStateNormal];
    [selectAllButton setBackgroundColor:[UIColor blackColor]];
    [Scrollview addSubview:selectAllButton];
    
    
    RightsideButton=[[UIButton alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         RightsideButton.frame=CGRectMake(600, 25, 55, 40);
    }
    else
    {
        RightsideButton.frame=CGRectMake(235, 15, 35, 40);
    }
   // [RightsideButton setTitle:@"select" forState:UIControlStateNormal];
    [RightsideButton setBackgroundColor:[UIColor blackColor]];
    [Scrollview addSubview:RightsideButton];
    
    backgroundImage=[[UIImageView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         backgroundImage.frame=CGRectMake(100, 195, 540, 500);
    }
    else
    {
        backgroundImage.frame=CGRectMake(10, 75, 300, 200);
    }
    backgroundImage.layer.borderWidth=.4f;
    backgroundImage.layer.borderColor=[UIColor blackColor].CGColor;
    [Scrollview addSubview:backgroundImage];
    
    
    Table=[[UITableView alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         Table.frame=CGRectMake(101, 196, 538, 498);
    }
    else
    {
        Table.frame=CGRectMake(11, 76, 298, 198);
    }
    [Table setDelegate:self];
    [Table setDataSource:self];
    [Scrollview addSubview:Table];
    
    backbutton=[[UIButton alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        backbutton.frame=CGRectMake(70, 770, 180, 40);
    }
    else
    {
        backbutton.frame=CGRectMake(20, 330, 80, 40);
    }

    [backbutton setTitle:@"Back" forState:UIControlStateNormal];
    [backbutton setBackgroundImage:[UIImage imageNamed:@"button_.png"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(Backbuttonclick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:backbutton];
    
    PayButton=[[UIButton alloc]init];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
         PayButton.frame=CGRectMake(510, 770, 180, 40);
    }
    else
    {
        PayButton.frame=CGRectMake(220, 330, 80, 40);
    }
    [PayButton setTitle:@"Pay Now" forState:UIControlStateNormal];
    [PayButton addTarget:self action:@selector(completepaymentclcik) forControlEvents:UIControlEventTouchUpInside];
    [PayButton setBackgroundImage:[UIImage imageNamed:@"button_.png"] forState:UIControlStateNormal];
    [Scrollview addSubview:PayButton];
}


-(void)Backbuttonclick 
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)completepaymentclcik
{
    NSString *OwneremailString=[[NSUserDefaults standardUserDefaults]valueForKey:@"OwnerEmail"];
    
    paypalViewController *paypalView=[[paypalViewController alloc]initWithNibName:@"paypalViewController" bundle:Nil];
    paypalView.PaypalOwneremail=OwneremailString;
    [self.navigationController pushViewController:paypalView animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return YES;
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
            
            mainBackgroundImage.frame=CGRectMake(00, 20, 1024, 738);
            Scrollview.frame=CGRectMake(00, 60, 1024,700);
            [Scrollview setContentSize:CGSizeMake(768, 600)];
            PaymentUIlabel.frame=CGRectMake(400,-50, 200, 40);
            selectButton.frame=CGRectMake(80, 25, 400, 40);
            selectAllButton.frame=CGRectMake(490, 25, 400, 40);
            RightsideButton.frame=CGRectMake(900, 25, 55, 40);
            backgroundImage.frame=CGRectMake(100, 145, 840, 350);
            Table.frame=CGRectMake(101, 146, 838, 348);
            backbutton.frame=CGRectMake(130, 535, 180, 40);
            PayButton.frame=CGRectMake(710, 535, 180, 40);
            
        }
        else
        {
             mainBackgroundImage.frame=CGRectMake(00, 20, 568, 320);
            Scrollview.frame=CGRectMake(00, 55, 568,260);
            [Scrollview setContentSize:CGSizeMake(320, 430)];
            
            PaymentUIlabel.frame=CGRectMake(180,-50, 200, 40);
            selectButton.frame=CGRectMake(50, 15, 200, 40);
            selectAllButton.frame=CGRectMake(260, 15, 200, 40);
            RightsideButton.frame=CGRectMake(470, 15, 35, 40);
            backgroundImage.frame=CGRectMake(30, 75, 500, 200);
            Table.frame=CGRectMake(31, 76, 498, 198);
            backbutton.frame=CGRectMake(45, 330, 120, 40);
            PayButton.frame=CGRectMake(390, 330, 120, 40);
           
        }
    }
    else
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        {
             mainBackgroundImage.frame=CGRectMake(00, 20, 768, 1004);
            Scrollview.frame=CGRectMake(00, 60, 768,970);
            [Scrollview setContentSize:CGSizeMake(768, 800)];
            PaymentUIlabel.frame=CGRectMake(325,-50, 200, 40);
            selectButton.frame=CGRectMake(80, 25, 250, 40);
            selectAllButton.frame=CGRectMake(340, 25, 250, 40);
            RightsideButton.frame=CGRectMake(600, 25, 55, 40);
            backgroundImage.frame=CGRectMake(100, 195, 540, 500);
            Table.frame=CGRectMake(101, 196, 538, 498);
            backbutton.frame=CGRectMake(70, 770, 180, 40);
            PayButton.frame=CGRectMake(510, 770, 180, 40);
        }
        else
        {
             mainBackgroundImage.frame=CGRectMake(00, 20, 320, 548);
            Scrollview.frame=CGRectMake(00, 60, 320,510);
            [Scrollview setContentSize:CGSizeMake(320, 430)];
           
            selectButton.frame=CGRectMake(20, 30, 110, 40);
            selectAllButton.frame=CGRectMake(140, 30, 110, 40);
            RightsideButton.frame=CGRectMake(260, 30, 45, 40);
            backgroundImage.frame=CGRectMake(10, 95, 300, 200);
            Table.frame=CGRectMake(11, 96, 298, 198);
            backbutton.frame=CGRectMake(20, 360, 80, 40);
            PayButton.frame=CGRectMake(220, 360, 80, 40);
        }
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
