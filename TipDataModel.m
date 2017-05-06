//
//  TipDataModel.m
//  TipCalculator
//
//  Created by PriyaManoj on 2016-08-30.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import "TipDataModel.h"

@implementation TipDataModel

//+ (NSString *)primaryKey {
//    return @"id";
//}

-(void)addTip:(TipDataModel *)tip
{
    // Get the default Realm
    RLMRealm *realm = [RLMRealm defaultRealm];

    [realm beginWriteTransaction];
    
    [realm addObject:tip];
    [realm commitWriteTransaction];
}

-(RLMResults *)loadTipByDate:(NSDate *)seldate
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:seldate];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    NSString *dateString = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",[@(year) stringValue],[@(month) stringValue],[@(day) stringValue],@"00",@"00",@"00"];
    
    NSString *dateStringEnd = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",[@(year) stringValue],[@(month) stringValue],[@(day) stringValue],@"23",@"59",@"59"];
    
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateStartTime = [dateFormatter dateFromString:dateString];
    
    NSDate *dateEndTime = [dateFormatter dateFromString:dateStringEnd];
    
    // Query using a predicate string
    RLMResults<TipDataModel *> *results = [TipDataModel objectsWhere:@"date BETWEEN {%@, %@}", dateStartTime, dateEndTime];
//    NSMutableArray *array = [NSMutableArray new];
//    for (TipDataModel *object in results) {
//        [array addObject:object];
//    }
    /*
    NSLog(@"in tip data model controller:%@",seldate);
    NSDateComponents *component1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:seldate];
    
    int selyear = [component1 year];
    int selmonth = [component1 month];
    int selday = [component1 day];
    
    
    
    for (TipDataModel *object in results) {
        NSDateComponents *component2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:object.date];
        
        int year = [component2 year];
        int month = [component2 month];
        int day = [component2 day];
        
        if (selyear==year && selmonth==month && selday==day) {
            [array addObject:object];
        }
    }
     */
    return results;

}

-(void)deleteTip:(TipDataModel *)deltip
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RLMResults *deleteTips = [TipDataModel objectsWhere:@"date == %@",deltip.date];
    if([deleteTips count] > 0){
        [realm beginWriteTransaction];
        [realm deleteObjects:deleteTips];
        [realm commitWriteTransaction];
    }
    
}

-(void)editTip:(TipDataModel *)editTip edited:(float) tip
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    [realm beginWriteTransaction];
    editTip.amount = tip;
    [realm addOrUpdateObject:editTip];
    [realm commitWriteTransaction];
}
@end

