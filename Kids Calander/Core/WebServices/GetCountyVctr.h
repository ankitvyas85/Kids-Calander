//
//  GetCountyVctr.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 11/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol WebServiceDelegate <NSObject>
- (void)SuccessfullyReceivedresponse:(id)sender;
- (void)FailWithError:(id)sender;
@end


@interface GetCountyVctr : NSObject <NSXMLParserDelegate>
@property (strong, nonatomic) UIViewController *vctr;
@property (strong, nonatomic) NSMutableArray *arrForResult;
@property (strong, nonatomic) NSMutableDictionary *dMain;
@property (strong, nonatomic) NSMutableString *string;
@property (strong, nonatomic) NSMutableData *webData;
- (void)GetCountyServiceRequest:(NSString *)SerVerUrl Controller:(UIViewController *)ViewCtr;
@end
