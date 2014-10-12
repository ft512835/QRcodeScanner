//
//  ReviewViewController.m
//  QRcodeScanner
//
//  Created by Neeraj Rathi on 01/04/14.
//  Copyright (c) 2014 Neeraj Rathi. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController

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
    self.navigationItem.title=@"Write a Review";
    [self CReateUI];
    // Do any additional setup after loading the view.
}
-(void)CReateUI
{
    BackgroundImage=[[UIImageView alloc]init];    
    [BackgroundImage setImage:[UIImage imageNamed:@"bg.png"]];
    [self.view addSubview:BackgroundImage];
    
    Scrollview=[[UIScrollView alloc]init];
    [self.view addSubview:Scrollview];
    
    profileimage=[[UIImageView alloc]init];
    [profileimage setImage:[UIImage imageNamed:@"user.png"]];
    [Scrollview addSubview:profileimage];
    
    BRowseButton=[[UIButton alloc]init];
    [BRowseButton setTitle:@"Browse" forState:UIControlStateNormal];
    [BRowseButton setBackgroundColor:[UIColor lightGrayColor]];
    [BRowseButton addTarget:self action:@selector(BrowseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [Scrollview addSubview:BRowseButton];
    
    menuItemScore=[[UILabel alloc]init];
    menuItemScore.text=@"Menu Item Score";
    [Scrollview addSubview:menuItemScore];
    
    servicelabel=[[UILabel alloc]init];
    servicelabel.text=@"Service";
    [Scrollview addSubview:servicelabel];
    
    menuItemCost=[[UILabel alloc]init];
    menuItemCost.text=@"Menu Item Cost";
    [Scrollview addSubview:menuItemCost];
    
    ItemCostTF=[[UITextField alloc]init];
    [ItemCostTF setDelegate:self];
    [ItemCostTF setBackgroundColor:[UIColor whiteColor]];
    ItemCostTF.placeholder=@"Tap to enter";
    [Scrollview addSubview:ItemCostTF];
    
    ReviewTitleLabel=[[UILabel alloc]init];
    ReviewTitleLabel.text=@"Review Title";
    [Scrollview addSubview:ReviewTitleLabel];

    ReviewtitleTF=[[UITextField alloc]init];
    [ReviewtitleTF setDelegate:self];
     [ReviewtitleTF setBackgroundColor:[UIColor whiteColor]];
    ReviewtitleTF.placeholder=@"Tap to enter";
    [Scrollview addSubview:ReviewtitleTF];
    
    ReviewDescription=[[UILabel alloc]init];
    ReviewDescription.text=@"Review Description";
    [Scrollview addSubview:ReviewDescription];
    
    reviewDescriptionTF=[[UITextView alloc]init];
    [reviewDescriptionTF setDelegate:self];
    [reviewDescriptionTF setBackgroundColor:[UIColor whiteColor]];
    
   // reviewDescriptionTF.placeholder=@"Tap to enter";
    [Scrollview addSubview:reviewDescriptionTF];
    
    SubmittButton=[[UIButton alloc]init];
    [SubmittButton setBackgroundImage:[UIImage imageNamed:@"button_.png"] forState:UIControlStateNormal];
    [SubmittButton setTitle:@"Submitt" forState:UIControlStateNormal];
    [Scrollview addSubview:SubmittButton];
    
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (textView == reviewDescriptionTF)
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y+150;
            self.view.frame = frame;
        }
        
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        if (textView == reviewDescriptionTF)
        {
            CGRect frame = self.view.frame;
            frame.origin.y = frame.origin.y-150;
            self.view.frame = frame;
        }
        
    }
    return YES;
}


-(void)BrowseButtonClick
   {
       UIActionSheet *actionSheet=[[UIActionSheet alloc]initWithTitle:@"Choose" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"Gallery" otherButtonTitles:@"Camera", nil];
       [actionSheet showInView:self.view];
   }


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        imagePicker =[[UIImagePickerController alloc]init];
        [imagePicker setDelegate:self];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentViewController:imagePicker animated:YES completion:Nil];
        //[self presentModalViewController:imagePicker animated:YES];

    }
    else if (buttonIndex==1)
    {
        imagePicker =[[UIImagePickerController alloc]init];
        [imagePicker setDelegate:self];
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
       [self presentViewController:imagePicker animated:YES completion:Nil];
    }
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage  *selectiamge = info[UIImagePickerControllerOriginalImage];
    NSLog(@"%@",selectiamge);
    profileimage.image = selectiamge;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}




- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
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
            Scrollview.frame=CGRectMake(00, 60, 1024,720);
            [Scrollview setContentSize:CGSizeMake(1024, 720)];
            BackgroundImage.frame=CGRectMake(00, 20, 1024, 760);
            
            profileimage.frame=CGRectMake(140, 20, 140, 140);
            BRowseButton.frame=CGRectMake(320, 120, 70, 30);
            menuItemScore.frame=CGRectMake(140, 160, 200, 30);
            servicelabel.frame=CGRectMake(140, 230, 200, 30);
            menuItemCost.frame=CGRectMake(140, 300, 200, 30);
            
            ItemCostTF.frame=CGRectMake(150, 335, 700, 50);
            ReviewTitleLabel.frame=CGRectMake(140, 400, 200, 30);
            ReviewtitleTF.frame=CGRectMake(150, 435, 700, 50);
            ReviewDescription.frame=CGRectMake(140, 490, 270,35);
            reviewDescriptionTF.frame=CGRectMake(150, 530, 700, 80);
            SubmittButton.frame=CGRectMake(420, 640, 100, 50);
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
            {
            Scrollview.frame=CGRectMake(00, 53, 568,280);
            [Scrollview setContentSize:CGSizeMake(568, 690)];
            BackgroundImage.frame=CGRectMake(00, 20, 568, 300);
            
            profileimage.frame=CGRectMake(50, 20, 140, 140);
            BRowseButton.frame=CGRectMake(220, 120, 70, 30);
            menuItemScore.frame=CGRectMake(50, 160, 200, 30);
            servicelabel.frame=CGRectMake(50, 230, 200, 30);
            menuItemCost.frame=CGRectMake(50, 300, 200, 30);
            
            ItemCostTF.frame=CGRectMake(60, 335, 400, 40);
            ReviewTitleLabel.frame=CGRectMake(50, 400, 200, 30);
            ReviewtitleTF.frame=CGRectMake(60, 435, 400, 40);
            ReviewDescription.frame=CGRectMake(50, 490, 270,35);
            reviewDescriptionTF.frame=CGRectMake(60, 530, 400, 80);
            SubmittButton.frame=CGRectMake(245, 630, 80, 40);
            }
            else if ([UIScreen mainScreen].bounds.size.height==480)
            {
                Scrollview.frame=CGRectMake(00, 53, 480,280);
                [Scrollview setContentSize:CGSizeMake(480, 690)];
                BackgroundImage.frame=CGRectMake(00, 20, 480, 300);
                
                profileimage.frame=CGRectMake(50, 20, 140, 140);
                BRowseButton.frame=CGRectMake(220, 120, 70, 30);
                menuItemScore.frame=CGRectMake(30, 160, 200, 30);
                servicelabel.frame=CGRectMake(30, 230, 200, 30);
                menuItemCost.frame=CGRectMake(30, 300, 200, 30);
                
                ItemCostTF.frame=CGRectMake(40, 335, 400, 40);
                ReviewTitleLabel.frame=CGRectMake(30, 400, 200, 30);
                ReviewtitleTF.frame=CGRectMake(40, 435, 400, 40);
                ReviewDescription.frame=CGRectMake(30, 490, 270,35);
                reviewDescriptionTF.frame=CGRectMake(40, 530, 400, 80);
                SubmittButton.frame=CGRectMake(210, 630, 80, 40);
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
            profileimage.frame=CGRectMake(80, 20, 150, 160);
            BRowseButton.frame=CGRectMake(400, 120, 70, 30);
            
            menuItemScore.frame=CGRectMake(35, 200, 200, 30);
            servicelabel.frame=CGRectMake(35, 280, 200, 30);
            menuItemCost.frame=CGRectMake(35, 360, 200, 30);
            ItemCostTF.frame=CGRectMake(45, 395, 600, 35);
            ReviewTitleLabel.frame=CGRectMake(35, 435, 200, 30);
            ReviewtitleTF.frame=CGRectMake(45, 470, 600, 35);
            ReviewDescription.frame=CGRectMake(35, 510, 270,35);
            reviewDescriptionTF.frame=CGRectMake(45, 550, 600, 200);
            SubmittButton.frame=CGRectMake(300, 830, 150, 60);
            
        }
        else
        {
            if ([UIScreen mainScreen].bounds.size.height==568)
                {
                    Scrollview.frame=CGRectMake(00, 60, 320,508);
                    [Scrollview setContentSize:CGSizeMake(320, 630)];
                    BackgroundImage.frame=CGRectMake(00, 20, 320, 550);
                    profileimage.frame=CGRectMake(30, 20, 100, 100);
                    BRowseButton.frame=CGRectMake(200, 80, 70, 30);
                    menuItemScore.frame=CGRectMake(20, 140, 200, 30);
                    servicelabel.frame=CGRectMake(20, 210, 200, 30);
                    menuItemCost.frame=CGRectMake(20, 280, 200, 30);
                    ItemCostTF.frame=CGRectMake(30, 315, 270, 35);
                    ReviewTitleLabel.frame=CGRectMake(20, 360, 200, 30);
                    ReviewtitleTF.frame=CGRectMake(30, 395, 270, 35);
                    ReviewDescription.frame=CGRectMake(20, 440, 270,35);
                    reviewDescriptionTF.frame=CGRectMake(30, 480, 270, 80);
                    SubmittButton.frame=CGRectMake(120, 570, 80, 40);
                }
            else if ([UIScreen mainScreen].bounds.size.height==480)
                {
                    Scrollview.frame=CGRectMake(00, 60, 320,480);
                    [Scrollview setContentSize:CGSizeMake(320, 680)];
                    BackgroundImage.frame=CGRectMake(00, 20, 320, 480);
                    profileimage.frame=CGRectMake(30, 20, 100, 100);
                    BRowseButton.frame=CGRectMake(200, 80, 70, 30);
                    menuItemScore.frame=CGRectMake(20, 140, 200, 30);
                    servicelabel.frame=CGRectMake(20, 210, 200, 30);
                    menuItemCost.frame=CGRectMake(20, 280, 200, 30);
                    ItemCostTF.frame=CGRectMake(30, 315, 270, 35);
                    ReviewTitleLabel.frame=CGRectMake(20, 360, 200, 30);
                    ReviewtitleTF.frame=CGRectMake(30, 395, 270, 35);
                    ReviewDescription.frame=CGRectMake(20, 440, 270,35);
                    reviewDescriptionTF.frame=CGRectMake(30, 480, 270, 80);
                    SubmittButton.frame=CGRectMake(120, 570, 80, 40);
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
