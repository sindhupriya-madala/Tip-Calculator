//
//  TableViewCell.h
//  TipCalculator
//
//  Created by PriyaManoj on 2016-08-29.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;

//@property (weak, nonatomic) IBOutlet UILabel *cellLabel;
@end
