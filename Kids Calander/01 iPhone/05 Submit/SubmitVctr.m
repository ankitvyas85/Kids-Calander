//
//  SubmitVctr.m
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 15/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import "SubmitVctr.h"
#import "ActionSheetPicker.h"
#import "TeachersListVctr.h"
@interface SubmitVctr ()

@end

@implementation SubmitVctr
@synthesize strSname = _strSname;
@synthesize arrForStandard = _arrForStandard;
@synthesize actionSheetPicker = _actionSheetPicker;
@synthesize ShareDelegate = _ShareDelegate;
@synthesize obj_TeachersListVctr = _obj_TeachersListVctr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)SuccessfullyReceivedStandardresponse:(id)sender{
    NSLog(@"%@",sender);
    self.arrForStandard = [[NSArray alloc] initWithArray:sender];
}
- (void)FailWithError:(id)sender{
    
}
- (void)getstandards{
    GetStandardVctr *obj_GetStandardVctr = [[GetStandardVctr alloc] init];
    [obj_GetStandardVctr GetStandardListServiceRequest:[NSString stringWithFormat:@"%@%@",GetStandard,self.strSname] Controller:self];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.ShareDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnGetStandardTapped:(id)sender {
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        if ([sender respondsToSelector:@selector(setText:)]) {
            [sender performSelector:@selector(setText:) withObject:selectedValue];
            self.ShareDelegate.strStandard = selectedValue;
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {
        NSLog(@"Block Picker Canceled");
    };
    [ActionSheetStringPicker showPickerWithTitle:@"Select a Block" rows:[self.arrForStandard valueForKey:@"standard"] initialSelection:0 doneBlock:done cancelBlock:cancel origin:sender];
}

- (IBAction)btnSubmitTapped:(id)sender {
    if([self.txtStudentName.text length]==0){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"School Kids"
                                                     message:@"Please Enter Student Name..."
                                                    delegate:self
                                           cancelButtonTitle:@"Ok"
                                           otherButtonTitles: nil];
        [av show];
        return;
    }
    self.ShareDelegate.strStudentName=self.txtStudentName.text;
    
    if(![self.ShareDelegate.prefsForStudent1 valueForKey:@"Stud1"])
        [self.ShareDelegate.prefsForStudent1 setObject:self.ShareDelegate.strStudentName forKey:@"Stud1"];
    else if(![self.ShareDelegate.prefsForStudent2 valueForKey:@"Stud2"])
        [self.ShareDelegate.prefsForStudent2 setObject:self.ShareDelegate.strStudentName forKey:@"Stud2"];
    else if(![self.ShareDelegate.prefsForStudent3 valueForKey:@"Stud3"])
        [self.ShareDelegate.prefsForStudent3 setObject:self.ShareDelegate.strStudentName forKey:@"Stud3"];
    self.txtStudentName.text=nil;
    self.txtStandard.text=nil;
    if(!self.obj_TeachersListVctr)
        self.obj_TeachersListVctr = [[TeachersListVctr alloc] initWithNibName:@"TeachersListVctr" bundle:nil];
    [self.navigationController pushViewController:self.obj_TeachersListVctr animated:YES];
    [self.obj_TeachersListVctr performSelector:@selector(GetTeachersList) withObject:nil afterDelay:0.02];
}

- (IBAction)btnBackTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end
