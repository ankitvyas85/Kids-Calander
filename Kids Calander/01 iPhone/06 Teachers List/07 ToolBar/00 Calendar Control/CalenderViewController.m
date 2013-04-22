//
//  CalenderViewController.m
//  CalenderDemo
//
//  Created by Sushree on 19/04/13.
//  Copyright (c) 2013 Valtech. All rights reserved.
//

#import "CalenderViewController.h"
#import "DayViewExampleController.h"
#import "WeekViewExampleController.h"


#import "EventKitDataSource.h"


@implementation CalenderViewController
@synthesize ShareDelegate = _ShareDelegate;
@synthesize eventStore,event;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.ShareDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)viewDidLoad
{
    //[self GetSpouseList];
    [super viewDidLoad];
  
    currentViewController = [self viewControllerForSegmentIndex:0];
    currentViewController.view.frame = CGRectMake(0, 88, 320, 280);
    [self.view addSubview:currentViewController.view];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBarHidden=YES;

    if([self.ShareDelegate.prefsForStudent1 valueForKey:@"Stud1"]){
        [self.btnName1 setTitle:[self.ShareDelegate.prefsForStudent1 valueForKey:@"Stud1"] forState:UIControlStateNormal];
    }
    if([self.ShareDelegate.prefsForStudent2 valueForKey:@"Stud2"]){
        self.btnName2.hidden=NO;
        [self.btnName2 setTitle:[self.ShareDelegate.prefsForStudent2 valueForKey:@"Stud2"] forState:UIControlStateNormal];
    }
    if ([self.ShareDelegate.prefsForStudent3 valueForKey:@"Stud3"]) {
        self.btnName3.hidden=NO;
         [self.btnName3 setTitle:[self.ShareDelegate.prefsForStudent3 valueForKey:@"Stud3"] forState:UIControlStateNormal];
    }
}
- (IBAction)btnAddEventTapped:(id)sender {
}

- (void)GetSpouseList{
   NSLog(@"%@",[self.ShareDelegate.prefsCalendar valueForKey:@"Event ID"]);
     NSLog(@"%@",[self.ShareDelegate.prefsForStudent1 valueForKey:@"Student1"]);
}
- (void)SuccessfullyReceivedSpouseresponse:(id)sender{
    NSLog(@"%@",sender);
    
    EKEventStore* store = [[EKEventStore alloc] init] ;
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"Event ID"]){
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Event ID"]);
        EKEvent* eventToRemove = [[NSUserDefaults standardUserDefaults] valueForKey:@"Event ID"];
        if (eventToRemove!= nil) {
            NSError* error = nil;
            [store removeEvent:eventToRemove span:EKSpanThisEvent error:&error];
            [self.ShareDelegate.arrForCalendar removeAllObjects];
            [self.ShareDelegate.prefsCalendar synchronize];
        }
    }
    
    
    for (int i = 0; i<[sender count]; i++) {
        eventStore = [[EKEventStore alloc] init];
        event = [EKEvent eventWithEventStore:eventStore];
        // set the title of the event.
        event.title = [[sender valueForKey:@"title"] objectAtIndex:i];
        
        NSString *dateString = [[sender valueForKey:@"event_datetime"] objectAtIndex:i];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:dateString];
        event.startDate=dateFromString;
        
        event.endDate = [dateFromString dateByAddingTimeInterval:7200]; // 25 hours * 60 mins * 60 seconds = 86400
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        
        // store the event using EventStore.
        NSError *err;
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
        [self.ShareDelegate.arrForCalendar addObject:[event eventIdentifier]];
        [self.ShareDelegate.prefsCalendar setObject:self.ShareDelegate.arrForCalendar forKey:@"Event ID"];
        [self.ShareDelegate.prefsCalendar synchronize];
    }
    [self segmentChanged:0];
}
- (void)SpouseFailWithError:(id)sender{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (UIViewController *)viewControllerForSegmentIndex:(NSInteger)index {
    UIViewController *vc;
    switch (index) {
        case 0:
            self.navigationController.navigationBarHidden=YES;

         vc = [[DayViewExampleController alloc]initWithNibName:@"DayViewExampleController" bundle:nil];

            break;
        case 1:
            self.navigationController.navigationBarHidden=YES;
            vc = [[WeekViewExampleController alloc]initWithNibName:@"WeekViewExampleController" bundle:nil];
            break;
        case 2:
        {
            
            vc = [[KalViewController alloc] init];
            kal = [[KalViewController alloc] init];
            kal.delegate = self;
            dataSource = [[EventKitDataSource alloc] init];
            kal.dataSource = dataSource;
            self.navigationController.navigationBar.tintColor=[UIColor redColor];
            kal.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(showAndSelectToday)] ;

            }
            break;
    }
    return vc;
}

#pragma mark Segment Control Action
- (IBAction)segmentChanged:(UISegmentedControl *)sender {
 
    if (![currentViewController.view isKindOfClass:[KalViewController class]]) {
        [currentViewController.view removeFromSuperview];
    }
    
    UIViewController *vc = [self viewControllerForSegmentIndex:sender.selectedSegmentIndex];
    if (![vc isKindOfClass:[KalViewController class]]) {
        self.navigationController.navigationBarHidden=YES;
        vc.view.frame = CGRectMake(0, 88, 320, 280);
        currentViewController = vc;
        self.btnAddEvent.hidden=NO;
        self.navigationItem.title = vc.title;
    }else
    {
        self.navigationController.navigationBarHidden=YES;
        vc.view.frame = CGRectMake(0, 44, 320, 350);
        kal.view.frame = CGRectMake(0, 44, 320, 350);
        currentViewController = kal;
        self.btnAddEvent.hidden=YES;
        self.navigationItem.title = @"Month View";
    }
    [self.view addSubview:currentViewController.view];
}
- (void)showAndSelectToday
{
    [kal showAndSelectDate:[NSDate date]];
}

#pragma mark UITableViewDelegate protocol conformance

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.navigationController.navigationBarHidden=NO;
    // Display a details screen for the selected event/row.
    EKEventViewController *vc = [[EKEventViewController alloc] init];
    vc.event = [dataSource eventAtIndexPath:indexPath];
    vc.allowsEditing = NO;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)btnName1Tapped:(id)sender {
    NSLog(@"%@",self.ShareDelegate.prefsCalendar);
    //http://schoolkal.com/webservices/refreshevents.php?county_name=Alameda&school_district=Alameda%20County%20Office%20of%20Education&school=Alameda%20County%20Community&standard=7&teacher_name1=Testing%20Class%20-%20Maths&teacher_name2=Testing%20Class1%20-%20English&teacher_name3=Testing%20Class2%20-%20Science&teacher_name4=Testing%20Class3%20-%20Social&count=4
    
    
    
    /*EKEventStore* store = [[EKEventStore alloc] init] ;
    EKEvent* eventToRemove = [store eventWithIdentifier:[[NSUserDefaults standardUserDefaults] valueForKey:@"Event ID"]];
    if (eventToRemove!= nil) {
        NSError* error = nil;
        [store removeEvent:eventToRemove span:EKSpanThisEvent error:&error];
        [self.ShareDelegate.arrForCalendar removeAllObjects];
        [self.ShareDelegate.prefsCalendar synchronize];
    }*/
    
    
    
}
- (IBAction)btnName2Tapped:(id)sender {
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"Event ID"]);
}
- (IBAction)btnName3Tapped:(id)sender {
}

- (IBAction)btnAddTapped:(id)sender {
  
    
    if(self.btnName2.hidden==NO){
         self.ShareDelegate.strSName = @"three";
        self.btnName3.hidden=NO;
        self.btnAdd.enabled=NO;
        if([self.ShareDelegate.prefsForStudent3 valueForKey:@"Stud3"])
            return;
        NSArray *array = [self.navigationController viewControllers];
        if([array count]==2){
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[array objectAtIndex:0] performSelector:@selector(GetCountyList) withObject:nil afterDelay:0.02];
        }
        else{
            [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
            [[array objectAtIndex:0] performSelector:@selector(GetCountyList) withObject:nil afterDelay:0.02];
        }
        return;
    }else if (self.btnName2.hidden==YES){
        self.btnName2.hidden=NO;
        self.ShareDelegate.strSName = @"two";
        NSArray *array = [self.navigationController viewControllers];
        if([array count]==2){
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[array objectAtIndex:0] performSelector:@selector(GetCountyList) withObject:nil afterDelay:0.02];
        }
        else{
            [self.navigationController popToViewController:[array objectAtIndex:1] animated:YES];
            [[array objectAtIndex:1] performSelector:@selector(GetCountyList) withObject:nil afterDelay:0.02];
        }
    }
    
    
}
- (void)GetEventList:(NSString *)stud{
    NSLog(@"Student Name:==>%@",self.ShareDelegate.strStudentName);
    NSLog(@"County Name:==>%@",self.ShareDelegate.strCountyName);
     NSLog(@"County Name:==>%@",self.ShareDelegate.strSchoolName);
     NSLog(@"County Name:==>%@",self.ShareDelegate.strStandard);
     NSLog(@"%@",[self.ShareDelegate.prefs valueForKey:@"Success"]);
     NSLog(@"Teachers==>%@",self.ShareDelegate.strStudent1Teachers);
    if([stud isEqualToString:@"1"]){
        NSString *Request = [NSString stringWithFormat:@"http://schoolkal.com/webservices/insertdetails.php?stud_name=%@&county_name=%@&school_district=%@&school=%@&standard=%@&%@&password=%@",self.ShareDelegate.strStudentName,self.ShareDelegate.strCountyName,self.ShareDelegate.strSchoolDisctct,self.ShareDelegate.strSchoolName,self.ShareDelegate.strStandard,self.ShareDelegate.strStudent1Teachers,[self.ShareDelegate.prefs valueForKey:@"Success"]];
        [self.ShareDelegate.prefsForRequest1 setObject:Request forKey:@"Request1"];
        GetSpouseVctr *obj_GetSpouseVctr = [[GetSpouseVctr alloc] init];
        [obj_GetSpouseVctr GetSpouseServiceRequest:Request Controller:self];
    }else if([stud isEqualToString:@"2"]){
        NSString *Request = [NSString stringWithFormat:@"http://schoolkal.com/webservices/insertdetails.php?stud_name=%@&county_name=%@&school_district=%@&school=%@&standard=%@&%@&password=%@",self.ShareDelegate.strStudentName,self.ShareDelegate.strCountyName,self.ShareDelegate.strSchoolDisctct,self.ShareDelegate.strSchoolName,self.ShareDelegate.strStandard,self.ShareDelegate.strStudent1Teachers,[self.ShareDelegate.prefs valueForKey:@"Success"]];
        [self.ShareDelegate.prefsForRequest2 setObject:Request forKey:@"Request2"];
        GetSpouseVctr *obj_GetSpouseVctr = [[GetSpouseVctr alloc] init];
        [obj_GetSpouseVctr GetSpouseServiceRequest:Request Controller:self];
        
    }else if([stud isEqualToString:@"3"]){
        NSString *Request = [NSString stringWithFormat:@"http://schoolkal.com/webservices/insertdetails.php?stud_name=%@&county_name=%@&school_district=%@&school=%@&standard=%@&%@&password=%@",self.ShareDelegate.strStudentName,self.ShareDelegate.strCountyName,self.ShareDelegate.strSchoolDisctct,self.ShareDelegate.strSchoolName,self.ShareDelegate.strStandard,self.ShareDelegate.strStudent1Teachers,[self.ShareDelegate.prefs valueForKey:@"Success"]];
        [self.ShareDelegate.prefsForRequest3 setObject:Request forKey:@"Request3"];
        GetSpouseVctr *obj_GetSpouseVctr = [[GetSpouseVctr alloc] init];
        [obj_GetSpouseVctr GetSpouseServiceRequest:Request Controller:self];
        
    }
    
    
   
    
    /*http://schoolkal.com/webservices/insertdetails.php?stud_name=MRP&county_name=Alameda&school_district=Alameda%20County%20Office%20of%20Education&school=Alameda%20County%20Community&standard=7&teacher_name1=Testing%20Class%20-%20Maths&teacher_name2=Testing%20Class1%20-%20English&teacher_name3=Testing%20Class2%20-%20Science&teacher_name4=Testing%20Class3%20-%20Social&count=4&password=1234*/
}
@end
