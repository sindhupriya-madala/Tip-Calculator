//
//  SignUpViewController.m
//  TipCalculator
//
//  Created by PriyaManoj on 2016-09-14.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SignUP:(id)sender {
    NSString *fname,*lname,*mailid,*passwd,*repasswd;
    fname = _first_name.text;
    lname = _last_name.text;
    mailid = _mail_id.text;
    passwd = _password.text;
    repasswd = _reenter_password.text;
    if(![fname length] || ![lname length] || ![mailid length] || ![passwd length] || ![repasswd length])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Empty"
                                     message:@"Please Enter Empty Fields"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];

    }
    if(![passwd isEqualToString:repasswd])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"MisMatch"
                                     message:@"Password Mismatch with Re-Enter Password"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
}
@end
