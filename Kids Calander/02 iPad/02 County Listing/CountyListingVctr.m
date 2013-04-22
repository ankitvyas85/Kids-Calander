//
//  CountyListingVctr.m
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 11/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "CountyListingVctr.h"
#import "SchoolDistictVctr_iPad.h"

@implementation CountyListingVctr
@synthesize arrCounty = _arrCounty;
@synthesize obj_SchoolDistictVctr_iPad = _obj_SchoolDistictVctr_iPad;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)GetCountyList{
    GetCountyVctr *obj = [[GetCountyVctr alloc] init];
    [obj GetCountyServiceRequest:GetCounty Controller:self];
}
- (void)SuccessfullyReceivedresponse:(id)sender{
    NSLog(@"%d",[sender count]);
    self.arrCounty = [[NSArray alloc] initWithArray:sender];
    [self.tblCounty reloadData];
    
}
- (void)FailWithError:(id)sender{
    NSLog(@"%@",sender);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrCounty.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Indetifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Indetifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
        cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text=[[self.arrCounty objectAtIndex:indexPath.row] valueForKey:@"county"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(!self.obj_SchoolDistictVctr_iPad)
        self.obj_SchoolDistictVctr_iPad = [[SchoolDistictVctr_iPad alloc] initWithNibName:@"SchoolDistictVctr_iPad" bundle:nil];
    self.obj_SchoolDistictVctr_iPad.strcounty = [[self.arrCounty objectAtIndex:indexPath.row] valueForKey:@"county"];
    [self.navigationController pushViewController:self.obj_SchoolDistictVctr_iPad animated:YES];
    [self.obj_SchoolDistictVctr_iPad performSelector:@selector(GetSchooldistict) withObject:nil afterDelay:0.02];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
