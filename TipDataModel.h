//
//  TipDataModel.h
//  TipCalculator
//
//  Created by PriyaManoj on 2016-08-30.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface TipDataModel : RLMObject

@property(nonatomic)  float amount;
@property(strong,nonatomic) NSDate* date;

-(void)addTip:(TipDataModel *)tip;
-(NSMutableArray *)loadTipByDate:(NSDate *)date;
@end
