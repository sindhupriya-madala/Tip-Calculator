//
//  ViewController.h
//  TipCalculator
//
//  Created by PriyaManoj on 2016-08-29.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *dollertf;
@property (strong, nonatomic) IBOutlet UITextField *centtf;

- (IBAction)SaveButton:(id)sender;

@end

