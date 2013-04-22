//
//  CountyListingVctr.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 11/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetCountyVctr.h"
@class SchoolDistictVctr_iPad;
@interface CountyListingVctr : UIViewController <WebServiceDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tblCounty;
@property (strong, nonatomic) NSArray *arrCounty;
@property (strong, nonatomic) SchoolDistictVctr_iPad *obj_SchoolDistictVctr_iPad;
- (IBAction)btnBackTapped:(id)sender;
- (void)GetCountyList;
@end
