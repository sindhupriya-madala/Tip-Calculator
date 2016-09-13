//
//  TipDataModel.m
//  TipCalculator
//
//  Created by PriyaManoj on 2016-08-30.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import "TipDataModel.h"

@implementation TipDataModel

-(void)addTip:(TipDataModel *)tip
{
    // Get the default Realm
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    [realm addObject:tip];
    [realm commitWriteTransaction];
}

-(NSMutableArray *)loadTipByDate:(NSDate *)date
{
    // Query using a predicate string
    RLMResults<TipDataModel *> *results = [TipDataModel allObjects];
    
    NSMutableArray *array = [NSMutableArray new];
    
    for (TipDataModel *object in results) {
        [array addObject:object];
    }

    return array;
}

@end
