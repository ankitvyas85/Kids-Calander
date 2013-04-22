//
//  SchoolDistrictVctr.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 11/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetSchoolDistrictVctr.h"
@class SchoolVctr;

@interface SchoolDistrictVctr : UIViewController <GetSchoolWebServiceDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblSchool;
@property (strong, nonatomic) NSArray *arrSchooldis;
@property (strong, nonatomic) NSString *strcounty;
@property (strong, nonatomic) SchoolVctr *obj_SchoolVctr;
@property (strong, nonatomic) AppDelegate *ShareDelegate;
- (void)SuccessfullyReceivedSchoolresponse:(id)sender;
- (void)FailWithError:(id)sender;
- (IBAction)btnBackTapped:(id)sender;
- (void)GetSchooldistict;
@end
