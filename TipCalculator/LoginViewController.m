//
//  LoginViewController.m
//  TipCalculator
//
//  Created by PriyaManoj on 2016-09-14.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import "LoginViewController.h"
#import "Service.h"
#import "UserModel.h"
#import "TableViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

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

- (IBAction)login_button:(id)sender {
    NSString *mailid, *passwd;
    mailid = _id_login.text;
    passwd = _password_login.text;
    
    if(![mailid length] || ![passwd length])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Empty"
                                     message:@"Please Enter Mail-id and Password"
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
    else
    {
        UserModel *user = [[UserModel alloc]init];
        user.userName = mailid; //@"sindhupriya";
        user.password = passwd; //@"manoj";
        
        Service *service = [[Service alloc]init];
        [service login:user].then(^(id responseObject){
            NSLog(@"JSON %@", responseObject);
            self.tabBarController.selectedIndex = 0;
            
        }).catch(^(NSError *error){
            NSLog(@"Error %@", [error localizedDescription]);
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:@"Empty"
                                         message:@"Please Enter Mail-id and Password"
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
        });
        
    }
}

- (IBAction)signup_button:(id)sender {
}
@end
