//
//  MSCalendarVctr.m
//  Kids Calendar
//
//  Created by Puja Ankit Vyas on 15/03/13.
//  Copyright (c) 2013 MRP-Solutions. All rights reserved.
//

#import "MSCalendarVctr.h"
#import "MAEvent.h"
#import "MAEventKitDataSource.h"
#import "AppDelegate.h"
// Uncomment the following line to use the built in calendar as a source for events:
#define USE_EVENTKIT_DATA_SOURCE 1

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]


@interface MSCalendarVctr(PrivateMethods)
@property (readonly) MAEvent *event;
@property (readonly) MAEventKitDataSource *eventKitDataSource;
@end



@implementation MSCalendarVctr
@synthesize eventKitDataSource = _eventKitDataSource;
@synthesize strTName = _strTName;
@synthesize myWebData = _myWebData;
@synthesize dMain = _dMain;
@synthesize string = _string;
@synthesize arrForDate = _arrForDate;
@synthesize obj_MSEventDetailVctr = _obj_MSEventDetailVctr;
@synthesize ShareDelegate = _ShareDelegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ShareDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    //[self Getcalendarevents];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //NSLog(@"%@",[WNWebService GetDictionaryForHome]);
}
- (void)doneTappedForAddingEvent:(NSDictionary *)dForEvent{
    NSLog(@"Delegate Implemented==>%@",dForEvent);
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    
    // set the title of the event.
    event.title = [dForEvent valueForKey:@"Event"];
    
    NSString *dateString = [NSString stringWithFormat:@"%@",[dForEvent valueForKey:@"STime"]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm a"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    event.startDate=dateFromString;
    event.endDate = [dateFromString dateByAddingTimeInterval:3600]; // 25 hours * 60 mins * 60 seconds = 86400
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:[event.startDate dateByAddingTimeInterval:-1*60*15]];
    [event addAlarm:alarm];
    // store the event using EventStore.
    NSError *err;
    //[eventStore removeEvent:event span:EKSpanThisEvent error:&err];
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
    
    
}


- (void)Getcalendarevents:(NSString *)Parameter{
    NSString *strUrl=[NSString stringWithFormat:@"http://schoolkal.com/webservices/insertdetails.php?stud_name=%@&county_name=%@&school_district=%@&school=%@&standard=%@&%@&password=1234",self.ShareDelegate.strStudentName,self.ShareDelegate.strCountyName,self.ShareDelegate.strSchoolDisctct,self.ShareDelegate.strSchoolName,self.ShareDelegate.strStandard,Parameter];
      NSLog(@"strUrl==>%@",strUrl);
    GetCalendarEvents *obj_GetCalendarEvents = [[GetCalendarEvents alloc] init];
    [obj_GetCalendarEvents GetEventsListServiceRequest:strUrl Controller:self];
    
}
- (void)SuccessfullyReceivedEventsListresponse:(id)sender{
    NSLog(@"%@",sender);
    for (int i = 0; i< [sender count]; i++) {
        EKEventStore *eventStore = [[EKEventStore alloc] init];
        
        
        EKEvent *event = [EKEvent eventWithEventStore:eventStore];
        
        // set the title of the event.
        event.title = [[sender objectAtIndex:i] valueForKey:@"title"];
        
        NSString *dateString = [NSString stringWithFormat:@"%@",[[sender objectAtIndex:i] valueForKey:@"date_time"]];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *dateFromString = [[NSDate alloc] init];
        dateFromString = [dateFormatter dateFromString:dateString];
        event.startDate=dateFromString;
        
        event.endDate = [dateFromString dateByAddingTimeInterval:3600]; // 25 hours * 60 mins * 60 seconds = 86400
        [event setCalendar:[eventStore defaultCalendarForNewEvents]];
        
        // store the event using EventStore.
        NSError *err;
        //[eventStore removeEvent:event span:EKSpanThisEvent error:&err];
        [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
    }
    
}
- (void)FailWithError:(id)sender{
    
}


/* Implementation for the MADayViewDataSource protocol */

static NSDate *date = nil;

#ifdef USE_EVENTKIT_DATA_SOURCE

- (NSArray *)dayView:(MADayView *)dayView eventsForDate:(NSDate *)startDate {
    dayView.backgroundColor=[UIColor blackColor];
    return [self.eventKitDataSource dayView:dayView eventsForDate:startDate];
}
#else
- (NSArray *)dayView:(MADayView *)dayView eventsForDate:(NSDate *)startDate {
	date = startDate;
    
	NSArray *arr = [NSArray arrayWithObjects: self.event, self.event, self.event,
					self.event, self.event, self.event, self.event,  self.event, self.event, nil];
	static size_t generateAllDayEvents;
	
	generateAllDayEvents++;
	
	if (generateAllDayEvents % 4 == 0) {
		((MAEvent *) [arr objectAtIndex:0]).title = @"All-day events test";
		((MAEvent *) [arr objectAtIndex:0]).allDay = YES;
		
		((MAEvent *) [arr objectAtIndex:1]).title = @"All-day events test";
		((MAEvent *) [arr objectAtIndex:1]).allDay = YES;
	}
	return arr;
}
#endif
- (MAEvent *)event {
	static int counter;
	static BOOL flag;
	
	NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
	
	[dict setObject:[NSString stringWithFormat:@"number %i", counter++] forKey:@"test"];
	
	unsigned int r = arc4random() % 24;
	int rr = arc4random() % 3;
	
	MAEvent *event = [[MAEvent alloc] init];
	event.backgroundColor = ((flag = !flag) ? [UIColor purpleColor] : [UIColor brownColor]);
	event.textColor = [UIColor whiteColor];
	event.allDay = NO;
	event.userInfo = dict;
	
	if (rr == 0) {
		event.title = @"Event lorem ipsum es dolor test. This a long text, which should clip the event view bounds.";
	} else if (rr == 1) {
		event.title = @"Foobar.";
	} else {
		event.title = @"Dolor test.";
	}
	
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
	[components setHour:r];
	[components setMinute:0];
	[components setSecond:0];
	
	event.start = [CURRENT_CALENDAR dateFromComponents:components];
	
	[components setHour:r+rr];
	[components setMinute:0];
	
	event.end = [CURRENT_CALENDAR dateFromComponents:components];
	
	return event;
}

- (MAEventKitDataSource *)eventKitDataSource {
    if (!_eventKitDataSource) {
        _eventKitDataSource = [[MAEventKitDataSource alloc] init];
    }
    return _eventKitDataSource;
}

/* Implementation for the MADayViewDelegate protocol */

- (void)dayView:(MADayView *)dayView eventTapped:(MAEvent *)event {
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:event.start];
	NSString *eventInfo = [NSString stringWithFormat:@"Hour %i. Userinfo: %@", [components hour], [event.userInfo objectForKey:@"test"]];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:event.title
                                                    message:eventInfo delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
}



- (void)viewDidUnload {
    [self setCalDayView:nil];
    [self setBtnStudent1:nil];
    [self setBtnStudent2:nil];
    [self setBtnStudent3:nil];
    [super viewDidUnload];
}
- (IBAction)addNewEvent:(id)sender {
  /*if(!self.obj_MSEventDetailVctr)
      self.obj_MSEventDetailVctr = [[MSEventDetailVctr alloc] initWithNibName:@"MSEventDetailVctr" bundle:nil];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.obj_MSEventDetailVctr.obj_MSCalendarVctr = self;
    [self.navigationController presentModalViewController:self.obj_MSEventDetailVctr animated:YES];
    */
    // Initialize an event store object with the init method. Initilize the array for events.
/*	self.eventStore = [[EKEventStore alloc] init];
    
	self.eventsList = [[NSMutableArray alloc] initWithArray:0];
	
	// Get the default calendar from store.
	self.defaultCalendar = [self.eventStore defaultCalendarForNewEvents];
	
	// Fetch today's event on selected calendar and put them into the eventsList array
	[self.eventsList addObjectsFromArray:[self fetchEventsForToday]];
    
    
    // When add button is pushed, create an EKEventEditViewController to display the event.
	EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:nil bundle:nil];
	
	// set the addController's event store to the current event store.
	addController.eventStore = self.eventStore;
	
	// present EventsAddViewController as a modal view controller
	[self presentModalViewController:addController animated:YES];
	
	addController.editViewDelegate = self;*/
}

- (IBAction)DayCalanderTapped:(id)sender {
    
  	MADayView *dayView = (MADayView *) self.CalDayView;
	/* The default is not to autoscroll, so let's override the default here */
	dayView.autoScrollToFirstEvent = YES;

}
#pragma mark -
#pragma mark Table view data source

// Fetching events happening in the next 24 hours with a predicate, limiting to the default calendar
- (NSArray *)fetchEventsForToday {
	
	NSDate *startDate = [NSDate date];
	
	// endDate is 1 day = 60*60*24 seconds = 86400 seconds from startDate
	NSDate *endDate = [NSDate dateWithTimeIntervalSinceNow:86400];
	
	// Create the predicate. Pass it the default calendar.
	NSArray *calendarArray = [NSArray arrayWithObject:self.defaultCalendar];
	NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate endDate:endDate
                                                                    calendars:calendarArray];
	
	// Fetch all events that match the predicate.
	NSArray *events = [self.eventStore eventsMatchingPredicate:predicate];
    
	return events;
}


#pragma mark -
#pragma mark EKEventEditViewDelegate

// Overriding EKEventEditViewDelegate method to update event store according to user actions.
- (void)eventEditViewController:(EKEventEditViewController *)controller
          didCompleteWithAction:(EKEventEditViewAction)action {
	
	NSError *error = nil;
	EKEvent *thisEvent = controller.event;
	
	switch (action) {
		case EKEventEditViewActionCanceled:
			// Edit action canceled, do nothing.
			break;
			
		case EKEventEditViewActionSaved:
			// When user hit "Done" button, save the newly created event to the event store,
			// and reload table view.
			// If the new event is being added to the default calendar, then update its
			// eventsList.
			if (self.defaultCalendar ==  thisEvent.calendar) {
				[self.eventsList addObject:thisEvent];
			}
			[controller.eventStore saveEvent:controller.event span:EKSpanThisEvent error:&error];
			break;
			
		case EKEventEditViewActionDeleted:
			// When deleting an event, remove the event from the event store,
			// and reload table view.
			// If deleting an event from the currenly default calendar, then update its
			// eventsList.
			if (self.defaultCalendar ==  thisEvent.calendar) {
				[self.eventsList removeObject:thisEvent];
			}
			[controller.eventStore removeEvent:thisEvent span:EKSpanThisEvent error:&error];
			break;
			
		default:
			break;
	}
	// Dismiss the modal view controller
//	[controller dismissModalViewControllerAnimated:YES];
    [controller dismissViewControllerAnimated:YES completion:nil];
	
}


// Set the calendar edited by EKEventEditViewController to our chosen calendar - the default calendar.
- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller {
	EKCalendar *calendarForEdit = self.defaultCalendar;
	return calendarForEdit;
}
- (IBAction)btnStudent1Tapped:(id)sender {
}
- (IBAction)btnStudent3Tapped:(id)sender{
}

- (IBAction)btnStudent2Tapped:(id)sender {
}
@end
