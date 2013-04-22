//
//  GetLoginVctr.h
//  School Kal
//
//  Created by Puja Ankit Vyas on 19/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GetLoginDelegate<NSObject>
@required
- (void)SuccessfullyReceivedLoginresponse:(id)sender;
- (void)LoginFailWithError:(id)sender;
@end

@interface GetLoginVctr : NSObject <NSXMLParserDelegate>
@property (strong, nonatomic) UIViewController *vctr;
@property (strong, nonatomic) NSMutableArray *arrForResult;
@property (strong, nonatomic) NSMutableDictionary *dMain;
@property (strong, nonatomic) NSMutableString *string;
@property (strong, nonatomic) NSMutableData *webData;
- (void)GetLoginServiceRequest:(NSString *)SerVerUrl Controller:(UIViewController *)ViewCtr;

@end
