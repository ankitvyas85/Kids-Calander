//
//  RegistrationVctr.m
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 11/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "RegistrationVctr.h"
#import "CountyListingVctr.h"

@implementation RegistrationVctr
@synthesize obj_CountyListingVctr = _obj_CountyListingVctr;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnParentRegastrationTapped:(id)sender {
    if(!self.obj_CountyListingVctr)
        self.obj_CountyListingVctr = [[CountyListingVctr alloc] initWithNibName:@"CountyListingVctr" bundle:nil];
    [self.navigationController pushViewController:self.obj_CountyListingVctr animated:YES];
    [self.obj_CountyListingVctr performSelector:@selector(GetCountyList) withObject:nil afterDelay:0.02];
}
@end
