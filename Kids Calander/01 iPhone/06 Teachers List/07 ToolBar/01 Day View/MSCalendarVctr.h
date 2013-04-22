//
//  MSCalendarVctr.h
//  Kids Calendar
//
//  Created by Puja Ankit Vyas on 15/03/13.
//  Copyright (c) 2013 MRP-Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MADayView.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
#import <AddressBook/AddressBook.h>
#import "GetCalendarEvents.h"

@class MAEventKitDataSource;
@class MSEventDetailVctr;
@class AppDelegate;
@interface MSCalendarVctr : UIViewController <MADayViewDataSource,MADayViewDelegate,NSXMLParserDelegate,EKEventEditViewDelegate,GetEventsListDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btnStudent1;
@property (strong, nonatomic) IBOutlet UIButton *btnStudent2;
@property (strong, nonatomic) IBOutlet UIButton *btnStudent3;
@property (strong, nonatomic) AppDelegate *ShareDelegate;
@property (strong, nonatomic) MSEventDetailVctr *obj_MSEventDetailVctr;
@property (strong, nonatomic) IBOutlet MADayView *CalDayView;
@property (strong , nonatomic) MAEventKitDataSource *eventKitDataSource;
@property (nonatomic, strong) EKEventStore *eventStore;
@property (nonatomic, strong) EKCalendar *defaultCalendar;
@property (nonatomic, strong) NSMutableArray *eventsList;
@property (strong, nonatomic) NSString *strTName;
@property (strong, nonatomic) NSMutableData *myWebData;
@property (strong, nonatomic) NSMutableDictionary *dMain;
@property (strong, nonatomic) NSMutableString *string;
@property (strong, nonatomic) NSMutableArray *arrForDate;
- (void)Getcalendarevents:(NSString *)Parameter;
- (NSArray *) fetchEventsForToday;
- (void)SuccessfullyReceivedEventsListresponse:(id)sender;
- (void)FailWithError:(id)sender;
- (IBAction)addNewEvent:(id)sender;
- (IBAction)DayCalanderTapped:(id)sender;
- (void)doneTappedForAddingEvent:(NSDictionary *)dForEvent;
- (IBAction)btnStudent1Tapped:(id)sender;
- (IBAction)btnStudent3Tapped:(id)sender;
- (IBAction)btnStudent2Tapped:(id)sender;
@end
