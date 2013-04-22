//
//  AppDelegate.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 10/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <CoreLocation/CoreLocation.h>
@class KalViewController;
@class DetailViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate,UITabBarControllerDelegate,UITableViewDelegate>
{
    KalViewController *kal;
    id dataSource;
}


@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) DetailViewController *obj_DetailViewController;
@property (strong, nonatomic) UITabBarController *tbCtr;
@property (strong, nonatomic) UINavigationController *nvCtr3;
@property (readwrite, nonatomic) BOOL isVisible;
@property (strong, nonatomic) NSString *strCountyName;
@property (strong, nonatomic) NSUserDefaults *prefsForstrCountyName1;
@property (strong, nonatomic) NSUserDefaults *prefsForstrCountyName2;
@property (strong, nonatomic) NSUserDefaults *prefsForstrCountyName3;

@property (strong, nonatomic) NSString *strSchoolDisctct;
@property (strong, nonatomic) NSString *strSchoolName;
@property (strong, nonatomic) NSString *strStandard;
@property (strong, nonatomic) NSString *strStudentName;

@property (strong, nonatomic) NSString *strStudent1Teachers;
@property (strong, nonatomic) NSString *strSName;
@property (strong, nonatomic) NSUserDefaults *prefs;
@property (strong, nonatomic) NSUserDefaults *prefsForSCount;
@property (strong, nonatomic) NSUserDefaults *prefsCalendar;
@property (strong, nonatomic) NSUserDefaults *prefsForStudent1;
@property (strong, nonatomic) NSUserDefaults *prefsForRequest1;
@property (strong, nonatomic) NSUserDefaults *prefsForRequest2;
@property (strong, nonatomic) NSUserDefaults *prefsForRequest3;

@property (strong, nonatomic) NSUserDefaults *prefsForStudent2;
@property (strong, nonatomic) NSUserDefaults *prefsForStudent3;
@property (strong, nonatomic) NSMutableArray *arrForCalendar;
@property (readwrite, nonatomic) float lat;
@property (readwrite, nonatomic) float lng;
@property (strong, nonatomic) MBProgressHUD *mbProcess;
@property (strong, nonatomic) CLLocationManager *locationManager;
-(void)showProgressHUDaView:(UIView *)aView;
-(void)hideProgressHUD;
@end
