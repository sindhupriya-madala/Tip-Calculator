//
//  DisplayTableViewController.m
//  TipCalculator
//
//  Created by PriyaManoj on 2016-09-08.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import "DisplayTableViewController.h"
#import "TableViewCell.h"
#import "TipDataModel.h"

@interface DisplayTableViewController ()

@end

@implementation DisplayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSDateFormatter *titleFormater = [[NSDateFormatter alloc] init];
    [titleFormater setDateFormat:@"dd-MM-yyyy"];
    //NSDate *curDate = [NSDate date];
    NSString *titleStr = [titleFormater stringFromDate:_selectedDate];
    

    self.navigationController.visibleViewController.title = titleStr;

    
    if(self.tipArray == nil)
    {
        self.tipArray = [[NSMutableArray alloc] init];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSString* str = @"footer";
    self.tipArray = [[[TipDataModel alloc] init]loadTipByDate:_selectedDate];
    float tipAmount=0;
    for (int i = [self.tipArray  count]; i>0; i--) {
        tipAmount  += ((TipDataModel*) [self.tipArray objectAtIndex:i-1]).amount;
    }
    str = [NSNumber numberWithFloat:tipAmount].stringValue;
    NSString *str1 =[NSString stringWithFormat:@"%@%@",@"Total Tip : ",str];
    return str1;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return [self.tipArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static int i = 0;
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    }
    
        cell.idLabel.text =  [NSString stringWithFormat:@"%d",++i];
        
        NSString *str ;
        float tip = ((TipDataModel*)[self.tipArray objectAtIndex:indexPath.row]).amount;
        str = [[NSNumber numberWithFloat:tip] stringValue];
        cell.tipLabel.text = str;
        NSDate *tipDate = ((TipDataModel*)[self.tipArray objectAtIndex:indexPath.row]).date;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm:ss"];
        
        NSString *labelData = [formatter stringFromDate:tipDate];
        cell.dateLabel.text = labelData;
        
        
    
    return cell;
    

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
