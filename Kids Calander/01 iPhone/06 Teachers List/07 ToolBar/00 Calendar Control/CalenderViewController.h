//
//  CalenderViewController.h
//  CalenderDemo
//
//  Created by Sushree on 19/04/13.
//  Copyright (c) 2013 Valtech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GetSpouseVctr.h"
#import "Kal.h"
#import "KalViewController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface CalenderViewController : UIViewController <GetSpouseDelegate,UITableViewDelegate>
{
    UIViewController *currentViewController;
    KalViewController *kal;
    id dataSource;
}

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) EKEventStore *eventStore;
@property (strong, nonatomic) EKEvent *event;
@property (strong, nonatomic) AppDelegate *ShareDelegate;
- (IBAction)segmentChanged:(UISegmentedControl *)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnName1;
- (IBAction)btnName1Tapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnName2;
- (IBAction)btnName2Tapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnName3;
- (IBAction)btnName3Tapped:(id)sender;
- (IBAction)btnAddTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnAdd;
@property (strong, nonatomic) IBOutlet UIButton *btnAddEvent;
- (IBAction)btnAddEventTapped:(id)sender;
- (void)GetEventList:(NSString *)stud;
- (void)GetSpouseList;
- (void)SuccessfullyReceivedSpouseresponse:(id)sender;
- (void)SpouseFailWithError:(id)sender;

@end
