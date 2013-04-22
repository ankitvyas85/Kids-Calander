//
//  AppDelegate.m
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 10/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "RegistrationVctr.h"
#import "CalenderViewController.h"
#import "DetailViewController.h"

@implementation AppDelegate
@synthesize mbProcess = _mbProcess;
@synthesize isVisible = _isVisible;
@synthesize strCountyName = _strCountyName;
@synthesize strSchoolDisctct = _strSchoolDisctct;
@synthesize strSchoolName = _strSchoolName;
@synthesize strStandard = _strStandard;
@synthesize prefs = _prefs;
@synthesize strSName = _strSName;
@synthesize strStudentName = _strStudentName;
@synthesize lat = _lat;
@synthesize lng = _lng;
@synthesize tbCtr = _tbCtr;
@synthesize nvCtr3 = _nvCtr3;
@synthesize prefsCalendar = _prefsCalendar;
@synthesize arrForCalendar = _arrForCalendar;
@synthesize strStudent1Teachers = _strStudent1Teachers;
@synthesize prefsForStudent1 = _prefsForStudent1;
@synthesize prefsForStudent2 = _prefsForStudent2;
@synthesize prefsForStudent3 = _prefsForStudent3;
@synthesize prefsForstrCountyName1 = _prefsForstrCountyName1;
@synthesize prefsForstrCountyName2 = _prefsForstrCountyName2;
@synthesize prefsForstrCountyName3 = _prefsForstrCountyName3;
@synthesize prefsForSCount = _prefsForSCount;
@synthesize prefsForRequest1 = _prefsForRequest1;
@synthesize prefsForRequest2 = _prefsForRequest2;
@synthesize prefsForRequest3 = _prefsForRequest3;
@synthesize locationManager = _locationManager;
@synthesize obj_DetailViewController = _obj_DetailViewController;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.strSName= @"one";
    self.locationManager = [[CLLocationManager alloc] init] ;
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    self.isVisible=YES;
    
    
    self.arrForCalendar = [[NSMutableArray alloc] init];
    [self SetNSUSerDefaults];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
      if([self.prefs valueForKey:@"Success"]){
          self.obj_DetailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
          self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.obj_DetailViewController];

          
         // CalenderViewController *obj_CalenderViewController = [[CalenderViewController alloc] initWithNibName:@"CalenderViewController" bundle:nil];
          //self.navigationController = [[UINavigationController alloc] initWithRootViewController:obj_CalenderViewController];
          self.window.rootViewController = self.navigationController;
          [self.obj_DetailViewController performSelector:@selector(GetSpouseList1) withObject:nil afterDelay:0.02];
      }else{
          MasterViewController *masterViewController = [[MasterViewController alloc] initWithNibName:@"MasterViewController" bundle:nil];
          self.navigationController = [[UINavigationController alloc] initWithRootViewController:masterViewController];
          self.window.rootViewController = self.navigationController;
      }
    
  }else{
      RegistrationVctr *obj_RegistrationVctr = [[RegistrationVctr alloc] initWithNibName:@"RegistrationVctr" bundle:nil];
      self.navigationController = [[UINavigationController alloc] initWithRootViewController:obj_RegistrationVctr];
      self.window.rootViewController = self.navigationController;
  }
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)SetNSUSerDefaults{
    self.prefs = [NSUserDefaults standardUserDefaults];
    self.prefsCalendar = [NSUserDefaults standardUserDefaults];
    self.prefsForStudent1 = [NSUserDefaults standardUserDefaults];
    self.prefsForStudent2 = [NSUserDefaults standardUserDefaults];
    self.prefsForStudent3 = [NSUserDefaults standardUserDefaults];
    self.prefsForSCount = [NSUserDefaults standardUserDefaults];
    self.prefsForstrCountyName1 = [NSUserDefaults standardUserDefaults];
    self.prefsForstrCountyName2 = [NSUserDefaults standardUserDefaults];
    self.prefsForstrCountyName3 = [NSUserDefaults standardUserDefaults];
    
    self.prefsForRequest1 = [NSUserDefaults standardUserDefaults];
    self.prefsForRequest2 = [NSUserDefaults standardUserDefaults];
    self.prefsForRequest3 = [NSUserDefaults standardUserDefaults];
}
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    self.lat = newLocation.coordinate.latitude;
    self.lng = newLocation.coordinate.longitude;
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"%@",[error description]);
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"testCookie" forKey:NSHTTPCookieName];
    [cookieProperties setObject:@"someValue123456" forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"http://iosrider.wordpress.com/" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"http://iosrider.wordpress.com/" forKey:NSHTTPCookieOriginURL];
    [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
    [cookieProperties setObject:@"1" forKey:NSHTTPCookieVersion];
    
    // set expiration to one month from now or any NSDate of your choosing
    // this makes the cookie sessionless and it will persist across web sessions and app launches
    /// if you want the cookie to be destroyed when your app exits, don't set this
    [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
    
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(void)showProgressHUDaView:(UIView *)aView{
	if(self.mbProcess!=nil){ [self.mbProcess hide:NO]; [self.mbProcess removeFromSuperview]; self.mbProcess=nil; }
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	self.mbProcess=[[MBProgressHUD alloc] initWithView:aView];
	self.mbProcess.labelText=NSLocalizedString(@"Loading Data",@"");
	self.mbProcess.detailsLabelText=NSLocalizedString(@"Please wait",@"");
    self.mbProcess.mode=MBProgressHUDModeIndeterminate;
	[aView addSubview:self.mbProcess];
	//	[self.mbProcess setDelegate:self];
    self.mbProcess.dimBackground=YES;
	[self.mbProcess show:YES];
}

-(void)hideProgressHUD{
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	[self.mbProcess hide:YES];
	if(self.mbProcess!=nil){ [self.mbProcess removeFromSuperview];self.mbProcess=nil; }
}

/*- (void)CreateTabbarController{
   self.obj_MSCalendarVctr = [[MSCalendarVctr alloc] initWithNibName:@"MSCalendarVctr" bundle:nil];
    self.obj_MSCalendarVctr.title=@"Day";
    UINavigationController *nvCtr1 = [[UINavigationController alloc] initWithRootViewController:self.obj_MSCalendarVctr];

    
    MSWeekVctr *obj_MSWeekVctr = [[MSWeekVctr alloc] initWithNibName:@"MSWeekVctr" bundle:nil];
    obj_MSWeekVctr.title=@"WeeK";
    UINavigationController *nvCtr2 = [[UINavigationController alloc] initWithRootViewController:obj_MSWeekVctr];
    
    
    
    kal = [[KalViewController alloc] init];
    kal.title = @"Month";
    */
    /*
     *    Kal Configuration
     *
     */
    /*kal.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Today" style:UIBarButtonItemStyleBordered target:self action:@selector(showAndSelectToday)] ;
    kal.delegate = self;
    dataSource = [[EventKitDataSource alloc] init];
    kal.dataSource = dataSource;
    //MSMonthVctr *obj_MSMonthVctr = [[MSMonthVctr alloc] initWithNibName:@"MSMonthVctr" bundle:nil];
    //obj_MSMonthVctr.title=@"Month";
    self.nvCtr3 = [[UINavigationController alloc] initWithRootViewController:kal];
    self.nvCtr3.navigationBar.tintColor = [UIColor blackColor];
    [nvCtr1 setNavigationBarHidden:YES animated:NO];
    [nvCtr2 setNavigationBarHidden:YES animated:NO];
    [self.nvCtr3 setNavigationBarHidden:NO animated:NO];
    
    
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    [tabBar setDelegate:self];
    tabBar.view.backgroundColor=[UIColor clearColor];
    [tabBar setViewControllers:[NSArray arrayWithObjects:nvCtr1,nvCtr2,self.nvCtr3, nil]];
    self.tbCtr=tabBar;
    
}*/
// Action handler for the navigation bar's right bar button item.
/*- (void)showAndSelectToday
{
    [kal showAndSelectDate:[NSDate date]];
}

#pragma mark UITableViewDelegate protocol conformance

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Display a details screen for the selected event/row.
    EKEventViewController *vc = [[EKEventViewController alloc] init];
    vc.event = [dataSource eventAtIndexPath:indexPath];
    vc.allowsEditing = NO;
    
    [self.nvCtr3 pushViewController:vc animated:YES];
}
*/
@end
