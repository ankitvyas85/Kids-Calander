//
//  RegistrationVctr.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 11/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CountyListingVctr;
@interface RegistrationVctr : UIViewController
@property (nonatomic, strong) CountyListingVctr *obj_CountyListingVctr;
- (IBAction)btnParentRegastrationTapped:(id)sender;

@end
