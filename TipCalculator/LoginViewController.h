//
//  LoginViewController.h
//  TipCalculator
//
//  Created by PriyaManoj on 2016-09-14.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *id_login;
@property (weak, nonatomic) IBOutlet UITextField *password_login;

- (IBAction)login_button:(id)sender;
- (IBAction)signup_button:(id)sender;
@end
