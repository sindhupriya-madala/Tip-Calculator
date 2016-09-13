//
//  DisplayTableViewController.h
//  TipCalculator
//
//  Created by PriyaManoj on 2016-09-08.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DisplayTableViewController : UITableViewController
@property (nonatomic)NSDate *selectedDate;
@property (strong,nonatomic) NSMutableArray *tipArray;

@end
