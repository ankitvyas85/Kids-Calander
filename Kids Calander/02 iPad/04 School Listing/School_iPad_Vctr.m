//
//  School_iPad_Vctr.m
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 13/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "School_iPad_Vctr.h"

@interface School_iPad_Vctr ()

@end

@implementation School_iPad_Vctr
@synthesize arrSchoolList = _arrSchoolList;
@synthesize strSchool = _strSchool;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (void)GetSchoolListdata{
    GetSchoolVctr *obj_GetSchoolVctr = [[GetSchoolVctr alloc] init];
    [obj_GetSchoolVctr GetSchoolListServiceRequest:[NSString stringWithFormat:@"%@%@",GetSchoolList,self.strSchool] Controller:self];
}
- (void)SuccessfullyReceivedSchoolresponse:(id)sender{
    NSLog(@"%@",sender);
    self.arrSchoolList = [[NSArray alloc] initWithArray:sender];
    [self.tblSchool reloadData];
}
- (void)FailWithError:(id)sender{
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
