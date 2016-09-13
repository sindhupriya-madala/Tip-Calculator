//
//  DBManager.h
//  TipCalculator
//
//  Created by PriyaManoj on 2016-08-30.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "TipDataModel.h"

@interface DBManager : NSObject

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;

- (void)inserTip:(TipDataModel*)insertTipContent;

- (void)deleteTip:(TipDataModel*)deleteTipContent;

- (void)updateTip:(TipDataModel*)updateTipContent;

- (NSMutableArray*)getAllTipContentByDate:(NSDate*)date;


@end
