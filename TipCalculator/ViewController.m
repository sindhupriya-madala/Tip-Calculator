//
//  ViewController.m
//  TipCalculator
//
//  Created by PriyaManoj on 2016-08-29.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "TipDataModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Enter Tip";
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)SaveButton:(id)sender {
    float i,j;
    
    i =  [self.dollertf.text integerValue];
    j = [self.centtf.text integerValue];
    float num;
    
    num = (i+(j/100));
 /*   NSArray *viewControllers = self.navigationController.viewControllers;
    for (UIViewController *anVC in viewControllers)
    {
        if ([anVC isKindOfClass:[TableViewController class]])
        {
            [((TableViewController *)anVC).tipArray addObject:[NSNumber numberWithFloat:num]];
            DBManager *manager = [[DBManager alloc]init];
            
            [self.navigationController popToViewController:anVC animated:YES];
            break;
        }
    }*/
    
    TipDataModel *newTipObj = [[TipDataModel alloc]init];
    newTipObj.amount = num;
    newTipObj.date = [NSDate date];
    [newTipObj addTip:newTipObj];
    
   /* NSArray *viewControllers = self.navigationController.viewControllers;
    for (UIViewController *anVC in viewControllers)
    {
        if ([anVC isKindOfClass:[TableViewController class]])
        {
            [((TableViewController *)anVC).tipArray addObject:[NSNumber numberWithFloat:num]];
//DBManager *manager = [[DBManager alloc]init];
            
            [self.navigationController popToViewController:anVC animated:YES];
            break;
        }
    }*/
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
