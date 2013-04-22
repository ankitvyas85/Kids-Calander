//
//  TeachersListVctr.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 15/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetTeachersVctr.h"
@class CalenderViewController;
@interface TeachersListVctr : UIViewController <GetTeachersListDelegate>
@property (strong, nonatomic) AppDelegate *ShareDelegate;
@property (strong, nonatomic) CalenderViewController *obj_CalenderViewController;
@property (strong, nonatomic) IBOutlet UITableView *tblTeacher;
@property (strong, nonatomic) NSMutableArray *arrForTeacherList;
@property (strong, nonatomic) NSMutableArray *arrForSelectedList;
- (void)SuccessfullyReceivedTeacherListresponse:(id)sender;
- (void)FailWithError:(id)sender;
- (void)GetTeachersList;
- (IBAction)btnBackTapped:(id)sender;
- (IBAction)btnSubmitTapped:(id)sender;
@end
