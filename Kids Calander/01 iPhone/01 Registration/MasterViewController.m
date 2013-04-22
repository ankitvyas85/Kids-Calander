//
//  MasterViewController.m
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 10/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CalenderViewController.h"


@implementation MasterViewController
@synthesize APPDEL = _APPDEL;
@synthesize obj_CalenderViewController = _obj_CalenderViewController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.APPDEL = (AppDelegate *)[[UIApplication sharedApplication] delegate];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnRegistrationTapped:(id)sender {
    self.VForLogin.hidden=NO;
    NSLog(@"%@",[self.APPDEL.prefs valueForKey:@"Success"]);
    if([self.APPDEL.prefs valueForKey:@"Success"]){
        if(!self.detailViewController)
            self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        [self.navigationController pushViewController:self.detailViewController animated:YES];
        [self.detailViewController performSelector:@selector(GetCountyList) withObject:nil afterDelay:0.02];
        self.VForLogin.hidden=YES;
    }
}

- (IBAction)btnLogInTapped:(id)sender {
    
    if([self.txtPassword.text length] != 4){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"School Kal"
                                                     message:@"Please Provide 4 digit Password"
                                                    delegate:self
                                           cancelButtonTitle:@"Ok"
                                           otherButtonTitles:nil];
        [av show];
        return;
    }
    if([self.txtUserName.text length]==0){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"School Kal"
                                                     message:@"Please Provide UserName"
                                                    delegate:self
                                           cancelButtonTitle:@"Ok"
                                           otherButtonTitles:nil];
        [av show];
        return;
    }
   
    if([self.txtUserName.text length]>0 && [self.txtPassword.text length]>0){
        
        self.VForLogin.hidden=YES;
        GetLoginVctr *obj_GetLoginVctr = [[GetLoginVctr alloc] init];
        [obj_GetLoginVctr GetLoginServiceRequest:[NSString stringWithFormat:@"%@%@&password=%@",LogInService,self.txtUserName.text,self.txtPassword.text] Controller:self];
    }
}
- (void)SuccessfullyReceivedLoginresponse:(id)sender{
    if([[[sender valueForKey:@"status"] objectAtIndex:0] isEqualToString:@"Success"]){
        [self.APPDEL.prefs setInteger:[self.txtPassword.text intValue] forKey:@"Success"];
        [self.APPDEL.prefs synchronize];
         self.VForLogin.hidden=YES;
        [self.txtPassword resignFirstResponder];
        [self.txtUserName resignFirstResponder];
        if(!self.detailViewController)
            self.detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
        [self.navigationController pushViewController:self.detailViewController animated:YES];
        [self.detailViewController performSelector:@selector(GetCountyList) withObject:nil afterDelay:0.02];
    }else{
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"School Kid"
                                                     message:[[sender valueForKey:@"status"] objectAtIndex:0]
                                                    delegate:self
                                           cancelButtonTitle:@"Ok"
                                           otherButtonTitles: nil];
        [av show];
    }
}
- (void)LoginFailWithError:(id)sender{
    
}

- (IBAction)btnSpouseTapped:(id)sender {
    self.VForLogin.hidden=NO;
    if([self.APPDEL.prefs valueForKey:@"Success"]){
        if(!self.obj_CalenderViewController)
            self.obj_CalenderViewController = [[CalenderViewController alloc] initWithNibName:@"CalenderViewController" bundle:nil];
        [self.navigationController pushViewController:self.obj_CalenderViewController animated:YES];
        [self.obj_CalenderViewController performSelector:@selector(GetSpouseList) withObject:nil afterDelay:0.02];

        self.VForLogin.hidden=YES;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
