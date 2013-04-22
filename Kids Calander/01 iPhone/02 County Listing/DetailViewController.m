//
//  DetailViewController.m
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 10/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "DetailViewController.h"
#import "GetCountyVctr.h"
#import "SchoolDistrictVctr.h"
#import "CalenderViewController.h"

@implementation DetailViewController
@synthesize arrCounty = _arrCounty;
@synthesize obj_SchoolDistrictVctr = _obj_SchoolDistrictVctr;
@synthesize ShareDelegate = _ShareDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ShareDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	// Do any additional setup after loading the view, typically from a nib.
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     self.navigationController.navigationBarHidden=YES;
}
- (void)GetSpouseList1{
    CalenderViewController *obj_CalenderViewController = [[CalenderViewController alloc] initWithNibName:@"CalenderViewController" bundle:nil];
    [self.navigationController pushViewController:obj_CalenderViewController animated:NO];
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
    if(!self.obj_SchoolDistrictVctr)
        self.obj_SchoolDistrictVctr = [[SchoolDistrictVctr alloc] initWithNibName:@"SchoolDistrictVctr" bundle:nil];
    self.obj_SchoolDistrictVctr.strcounty = [[self.arrCounty objectAtIndex:indexPath.row] valueForKey:@"county"];
    self.ShareDelegate.strCountyName = [[self.arrCounty objectAtIndex:indexPath.row] valueForKey:@"county"];
    if(![self.ShareDelegate.prefsForstrCountyName1 valueForKey:@"CountyName1"])
        [self.ShareDelegate.prefsForstrCountyName1 setObject:self.ShareDelegate.strCountyName forKey:@"CountyName1"];
    else if(![self.ShareDelegate.prefsForstrCountyName2 valueForKey:@"CountyName2"])
        [self.ShareDelegate.prefsForstrCountyName2 setObject:self.ShareDelegate.strCountyName forKey:@"CountyName2"];
    else if(![self.ShareDelegate.prefsForstrCountyName3 valueForKey:@"CountyName3"])
        [self.ShareDelegate.prefsForstrCountyName3 setObject:self.ShareDelegate.strCountyName forKey:@"CountyName3"];
    [self.navigationController pushViewController:self.obj_SchoolDistrictVctr animated:YES];
    [self.obj_SchoolDistrictVctr performSelector:@selector(GetSchooldistict) withObject:nil afterDelay:0.02];
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
