//
//  GetSpouseVctr.h
//  School Kal
//
//  Created by Puja Ankit Vyas on 20/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol GetSpouseDelegate<NSObject>
@required
- (void)SuccessfullyReceivedSpouseresponse:(id)sender;
- (void)SpouseFailWithError:(id)sender;
@end
@interface GetSpouseVctr : NSObject <NSXMLParserDelegate>
@property (strong, nonatomic) UIViewController *vctr;
@property (strong, nonatomic) NSMutableArray *arrForResult;
@property (strong, nonatomic) NSMutableDictionary *dMain;
@property (strong, nonatomic) NSMutableString *string;
@property (strong, nonatomic) NSMutableData *webData;
- (void)GetSpouseServiceRequest:(NSString *)SerVerUrl Controller:(UIViewController *)ViewCtr;

@end
