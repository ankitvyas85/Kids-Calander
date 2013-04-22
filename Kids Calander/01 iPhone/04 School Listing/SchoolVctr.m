//
//  SchoolVctr.m
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 12/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "SchoolVctr.h"
#import "SubmitVctr.h"

@implementation SchoolVctr
@synthesize arrSchoolList = _arrSchoolList;
@synthesize strSchool = _strSchool;
@synthesize obj_SubmitVctr = _obj_SubmitVctr;
@synthesize ShareDelegate = _ShareDelegate;

- (void)SuccessfullyReceivedSchoolresponse:(id)sender{
    NSLog(@"%@",sender);
    self.arrSchoolList = [[NSArray alloc] initWithArray:sender];
    [self.tblSchoolListing reloadData];
}
- (void)FailWithError:(id)sender{
    
}

- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)GetSchoolListdata{
    GetSchoolVctr *obj_GetSchoolVctr = [[GetSchoolVctr alloc] init];
    [obj_GetSchoolVctr GetSchoolListServiceRequest:[NSString stringWithFormat:@"%@%@",GetSchoolList,self.strSchool] Controller:self];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrSchoolList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Indetifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Indetifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
        cell.accessoryType= UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text=[[self.arrSchoolList objectAtIndex:indexPath.row] valueForKey:@"school"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(!self.obj_SubmitVctr)
        self.obj_SubmitVctr = [[SubmitVctr alloc] initWithNibName:@"SubmitVctr" bundle:nil];
    self.obj_SubmitVctr.strSname = [[self.arrSchoolList objectAtIndex:indexPath.row] valueForKey:@"school"];
    self.ShareDelegate.strSchoolName = [[self.arrSchoolList objectAtIndex:indexPath.row] valueForKey:@"school"];
    [self.navigationController pushViewController:self.obj_SubmitVctr animated:YES];
    [self.obj_SubmitVctr performSelector:@selector(getstandards) withObject:self afterDelay:0.02];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ShareDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
