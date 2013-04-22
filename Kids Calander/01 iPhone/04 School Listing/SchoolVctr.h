//
//  SchoolVctr.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 12/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetSchoolVctr.h"
@class SubmitVctr;
@interface SchoolVctr : UIViewController <GetSchoolDelegate>
@property (strong, nonatomic) SubmitVctr *obj_SubmitVctr;
@property (strong, nonatomic) IBOutlet UITableView *tblSchoolListing;
@property (strong, nonatomic) NSArray *arrSchoolList;
@property (strong, nonatomic) NSString *strSchool;
@property (strong, nonatomic) AppDelegate *ShareDelegate;
- (void)SuccessfullyReceivedSchoolresponse:(id)sender;
- (void)FailWithError:(id)sender;
- (IBAction)btnBackTapped:(id)sender;
- (void)GetSchoolListdata;
@end
