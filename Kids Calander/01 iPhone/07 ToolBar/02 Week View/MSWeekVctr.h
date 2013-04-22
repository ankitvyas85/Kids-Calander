//
//  MSWeekVctr.h
//  Kids Calendar
//
//  Created by Puja Ankit Vyas on 21/03/13.
//  Copyright (c) 2013 MRP-Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MAWeekView.h"
@class MAEventKitDataSource;

@interface MSWeekVctr : UIViewController<MAWeekViewDataSource,MAWeekViewDelegate> {
    MAEventKitDataSource *_eventKitDataSource;
}


@end
