//
//  MasterViewController.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 10/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "GetLoginVctr.h"
@class CalenderViewController;
@class DetailViewController;
@interface MasterViewController : UIViewController <GetLoginDelegate>

@property(strong, nonatomic) CalenderViewController *obj_CalenderViewController;
@property(strong, nonatomic) AppDelegate *APPDEL;
@property(strong, nonatomic) DetailViewController *detailViewController;
@property(strong, nonatomic) IBOutlet UIView *VForLogin;
@property(strong, nonatomic) IBOutlet UITextField *txtUserName;

@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnRegistrationTapped:(id)sender;
- (IBAction)btnLogInTapped:(id)sender;
- (void)SuccessfullyReceivedLoginresponse:(id)sender;
- (void)LoginFailWithError:(id)sender;
- (IBAction)btnSpouseTapped:(id)sender;

@end
