//
//  TeachersListVctr.m
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 15/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "TeachersListVctr.h"
#import "CalenderViewController.h"

@implementation TeachersListVctr
@synthesize ShareDelegate = _ShareDelegate;
@synthesize arrForTeacherList = _arrForTeacherList;
@synthesize arrForSelectedList = _arrForSelectedList;
- (void)GetTeachersList{
  [self.arrForTeacherList removeAllObjects];
  [self.tblTeacher reloadData];
   GetTeachersVctr *obj_GetTeachersVctr = [[GetTeachersVctr alloc] init];
    [obj_GetTeachersVctr GetTeacherListServiceRequest:[NSString stringWithFormat:@"%@%@&school_district=%@&school=%@&standard=%@",GetTeacherNo,self.ShareDelegate.strCountyName,self.ShareDelegate.strSchoolDisctct,self.ShareDelegate.strSchoolName,self.ShareDelegate.strStandard] Controller:self];
}

- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSubmitTapped:(id)sender {
    NSLog(@"%@",self.arrForSelectedList);
    NSString *strName;
    int count=0;
    for (int i = 0; i<[self.arrForSelectedList count]; i++) {
        switch (i) {
            case 0:
                
                strName = [NSString stringWithFormat:@"teacher_name%d=%@",i+1,[self.arrForSelectedList objectAtIndex:i]];
                count++;
                break;
            case 1:
                strName = [strName stringByAppendingFormat:@"&teacher_name%d=%@",i+1,[self.arrForSelectedList objectAtIndex:1]];
                count++;
                break;
            case 2:
                strName = [strName stringByAppendingFormat:@"&teacher_name%d=%@",i+1,[self.arrForSelectedList objectAtIndex:2]];
                count++;
                break;
            case 3:
                strName = [strName stringByAppendingFormat:@"&teacher_name%d=%@",i+1,[self.arrForSelectedList objectAtIndex:3]];
                count++;
                break;
   
            default:
                break;
        }
    }
    NSLog(@"%@",strName);
    NSLog(@"%d",count);
    strName = [strName stringByAppendingFormat:@"&count=%d",count];
    self.ShareDelegate.strStudent1Teachers = strName;
    

    if(!self.obj_CalenderViewController)
        self.obj_CalenderViewController = [[CalenderViewController alloc] initWithNibName:@"CalenderViewController" bundle:nil];
    [self.navigationController pushViewController:self.obj_CalenderViewController animated:YES];
    if(![self.ShareDelegate.prefsForRequest1 valueForKey:@"Request1"]){
        [self.obj_CalenderViewController performSelector:@selector(GetEventList:) withObject:@"1" afterDelay:0.02];
    }else if(![self.ShareDelegate.prefsForRequest2 valueForKey:@"Request2"])
        [self.obj_CalenderViewController performSelector:@selector(GetEventList:) withObject:@"2" afterDelay:0.02];
    else if(![self.ShareDelegate.prefsForRequest3 valueForKey:@"Request3"])
        [self.obj_CalenderViewController performSelector:@selector(GetEventList:) withObject:@"3" afterDelay:0.02];

}
- (void)SuccessfullyReceivedTeacherListresponse:(id)sender{
    NSLog(@"%@",sender);
    self.arrForTeacherList = [[NSMutableArray alloc] initWithArray:sender];
    [self.tblTeacher reloadData];
}
- (void)FailWithError:(id)sender{
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrForTeacherList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Indetifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Indetifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Indetifier];
    }
    cell.textLabel.text=[[self.arrForTeacherList objectAtIndex:indexPath.row] valueForKey:@"data"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)path {
    
   
    [tableView deselectRowAtIndexPath:path animated:YES];

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:path];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if([self.arrForSelectedList count]>0)
            [self.arrForSelectedList removeLastObject];
    } else {
        if([self.arrForSelectedList count]>3){
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"School Kal"
                                                         message:@"You Can't Select More than 4 Teachers..."
                                                        delegate:self
                                               cancelButtonTitle:@"Ok"
                                               otherButtonTitles: nil];
            [av show];
            return;
        }
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [self.arrForSelectedList addObject:[[self.arrForTeacherList objectAtIndex:path.row] valueForKey:@"data"]];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ShareDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.arrForSelectedList = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
