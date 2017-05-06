//
//  VerificationCodeViewController.h
//  TipCalculator
//
//  Created by PriyaManoj on 2016-09-14.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerificationCodeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *verification_code;
- (IBAction)verify:(id)sender;
@end
