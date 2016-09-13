//
//  TableViewController.h
//  TipCalculator
//
//  Created by PriyaManoj on 2016-08-29.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "ViewController.h"

@interface TableViewController : UITableViewController
@property (strong,nonatomic) NSMutableArray *tipArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBar;
@end
