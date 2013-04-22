//
//  SubmitVctr.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 15/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetStandardVctr.h"
@class AbstractActionSheetPicker;
@class TeachersListVctr;
@interface SubmitVctr : UIViewController <GetStandardDelegate,UIActionSheetDelegate>
@property (strong, nonatomic) NSArray *arrForStandard;
@property (strong, nonatomic) IBOutlet UITextField *txtStandard;
@property (strong, nonatomic) IBOutlet UITextField *txtStudentName;
@property (strong, nonatomic) NSString *strSname;
@property (strong, nonatomic) AbstractActionSheetPicker *actionSheetPicker;
@property (strong, nonatomic) AppDelegate *ShareDelegate;
@property (strong, nonatomic) TeachersListVctr *obj_TeachersListVctr;
- (IBAction)btnGetStandardTapped:(id)sender;
- (IBAction)btnSubmitTapped:(id)sender;

- (IBAction)btnBackTapped:(id)sender;
- (void)SuccessfullyReceivedStandardresponse:(id)sender;
- (void)FailWithError:(id)sender;
@end
