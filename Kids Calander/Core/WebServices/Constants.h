//
//  Constants.h
//  Kids Calander
//
//  Created by Puja Ankit Vyas on 11/04/13.
//  Copyright (c) 2013 MRP Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject
#define LogInService @"http://schoolkal.com/webservices/register.php?username="
#define GetCounty @"http://schoolkal.com/webservices/getcounty.php"
#define GetSchoolDistict @"http://schoolkal.com/webservices/getdistrict.php?county_name="
#define GetSchoolList  @"http://schoolkal.com/webservices/getschools.php?%20sd_name="
#define GetStandard  @"http://schoolkal.com/webservices/getstandard.php?school_name="
#define GetTeacherNo @"http://schoolkal.com/webservices/getteachers.php?county_name="
@end
