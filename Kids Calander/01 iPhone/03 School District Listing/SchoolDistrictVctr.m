//
//  SchoolDistrictVctr.m
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 11/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "SchoolDistrictVctr.h"
#import "SchoolVctr.h"

@implementation SchoolDistrictVctr
@synthesize arrSchooldis = _arrSchooldis;
@synthesize strcounty = _strcounty;
@synthesize obj_SchoolVctr = _obj_SchoolVctr;
@synthesize ShareDelegate = _ShareDelegate;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ShareDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
   
}

- (void)GetSchooldistict{
    GetSchoolDistrictVctr *obj_GetSchoolDistrictVctr = [[GetSchoolDistrictVctr alloc] init];
    [obj_GetSchoolDistrictVctr GetSchooldistictServiceRequest:[NSString stringWithFormat:@"%@%@",GetSchoolDistict,self.strcounty] Controller:self];
}
- (void)SuccessfullyReceivedSchoolresponse:(id)sender{
    self.arrSchooldis = [[NSArray alloc] initWithArray:sender];
    [self.tblSchool reloadData];
}
- (void)FailWithError:(id)sender{
    
}

- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrSchooldis.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Indetifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Indetifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
        cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text=[[self.arrSchooldis objectAtIndex:indexPath.row] valueForKey:@"school_district"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 
    if(!self.obj_SchoolVctr)
        self.obj_SchoolVctr = [[SchoolVctr alloc] initWithNibName:@"SchoolVctr" bundle:nil];
    self.obj_SchoolVctr.strSchool = [[self.arrSchooldis objectAtIndex:indexPath.row] valueForKey:@"school_district"];
    self.ShareDelegate.strSchoolDisctct = [[self.arrSchooldis objectAtIndex:indexPath.row] valueForKey:@"school_district"];
    [self.navigationController pushViewController:self.obj_SchoolVctr animated:YES];
    [self.obj_SchoolVctr performSelector:@selector(GetSchoolListdata) withObject:self afterDelay:0.02];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
