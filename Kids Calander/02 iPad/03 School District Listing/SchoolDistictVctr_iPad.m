//
//  SchoolDistictVctr_iPad.m
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 11/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "SchoolDistictVctr_iPad.h"
#import "School_iPad_Vctr.h"

@implementation SchoolDistictVctr_iPad
@synthesize arrSchooldis = _arrSchooldis;
@synthesize strcounty = _strcounty;
@synthesize obj_School_iPad_Vctr = _obj_School_iPad_Vctr;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    if(!self.obj_School_iPad_Vctr)
     self.obj_School_iPad_Vctr = [[School_iPad_Vctr alloc] initWithNibName:@"School_iPad_Vctr" bundle:nil];
     self.obj_School_iPad_Vctr.strSchool = [[self.arrSchooldis objectAtIndex:indexPath.row] valueForKey:@"school_district"];
    [self.navigationController pushViewController:self.obj_School_iPad_Vctr animated:YES];
    [self.obj_School_iPad_Vctr performSelector:@selector(GetSchoolListdata) withObject:nil afterDelay:0.02];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBackTapped:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
