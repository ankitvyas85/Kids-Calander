//
//  School_iPad_Vctr.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 13/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetSchoolVctr.h"

@interface School_iPad_Vctr : UIViewController <GetSchoolDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblSchool;
@property (strong, nonatomic) NSArray *arrSchoolList;
@property (strong, nonatomic) NSString *strSchool;
- (IBAction)btnBackTapped:(id)sender;
- (void)SuccessfullyReceivedSchoolresponse:(id)sender;
- (void)FailWithError:(id)sender;
- (void)GetSchoolListdata;

@end
