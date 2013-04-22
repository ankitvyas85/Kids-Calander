//
//  DetailViewController.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 10/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SchoolDistrictVctr;
#import "AppDelegate.h"

@interface DetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tblCounty;
@property (strong, nonatomic) NSArray *arrCounty;
@property (strong, nonatomic) AppDelegate *ShareDelegate;
@property (strong, nonatomic) SchoolDistrictVctr *obj_SchoolDistrictVctr;
- (IBAction)btnBackTapped:(id)sender;
- (void)GetCountyList;
- (void)GetSpouseList1;
@end
