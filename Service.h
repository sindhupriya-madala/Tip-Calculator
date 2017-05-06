//
//  Service.h
//  TipCalculator
//
//  Created by PriyaManoj on 2016-09-16.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import <PromiseKit/PromiseKit.h>
#import "AFNetworking.h"

@interface Service : NSObject

- (PMKPromise *)login:(UserModel *)user;

@end
