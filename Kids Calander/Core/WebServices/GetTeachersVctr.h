//
//  GetTeachersVctr.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 15/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GetTeachersListDelegate <NSObject>
@required
- (void)SuccessfullyReceivedTeacherListresponse:(id)sender;
- (void)FailWithError:(id)sender;
@end
@interface GetTeachersVctr : NSObject <NSXMLParserDelegate>
@property (strong, nonatomic) UIViewController *vctr;
@property (strong, nonatomic) NSMutableArray *arrForResult;
@property (strong, nonatomic) NSMutableDictionary *dMain;
@property (strong, nonatomic) NSMutableString *string;
@property (strong, nonatomic) NSMutableData *webData;
- (void)GetTeacherListServiceRequest:(NSString *)SerVerUrl Controller:(UIViewController *)ViewCtr;
@end
