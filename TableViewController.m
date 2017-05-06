//
//  TableViewController.m
//  TipCalculator
//
//  Created by PriyaManoj on 2016-08-29.
//  Copyright © 2016 PriyaManoj. All rights reserved.
//

#import "TableViewController.h"
#import "TipDataModel.h"

@interface TableViewController ()
 
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
    
    NSDateFormatter *titleFormater = [[NSDateFormatter alloc] init];
    [titleFormater setDateFormat:@"dd-MM-yyyy"];
    NSDate *curDate = [NSDate date];
    NSString *titleStr = [titleFormater stringFromDate:curDate];

    self.navigationController.visibleViewController.title = titleStr;
    self.navigationController.tabBarItem.title = @"Today";
    if(self.tipArray == nil)
    {
        self.tipArray = [[NSMutableArray alloc] init];
    }
   }

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tipArray = [[[TipDataModel alloc] init]loadTipByDate:[NSDate date]];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tipArray count]+1;
}
/*- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString* str = @"header";
    return str;
}*/
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSString* str = @"footer";
    self.tipArray = [[[TipDataModel alloc] init]loadTipByDate:[NSDate date]];
    NSLog(@"in table view controller:%@",[NSDate date]);
    float tipAmount=0;
    for (int i = [self.tipArray  count]; i>0; i--) {
        tipAmount  += ((TipDataModel*) [self.tipArray objectAtIndex:i-1]).amount;
    }
    str = [NSNumber numberWithFloat:tipAmount].stringValue;
    NSString *str1 =[NSString stringWithFormat:@"%@%@",@"Total Tip : ",str];
    return str1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
  
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    }
   if(indexPath.row == 0)
   {
       [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
      // cell.textLabel.frame = CGRectMake(0,0,50,40);
      // cell.detailTextLabel.frame =CGRectMake(55,0,50,40);

      // cell.textLabel.text = @"Enter Tip";
       cell.tipLabel.text = @"Enter Tip";
       cell.idLabel.text = @"";
       cell.dateLabel.text = @"";

   }
   else{
       cell.idLabel.text =  [NSString stringWithFormat:@"%d",indexPath.row];

       NSString *str ;
       float tip = ((TipDataModel*)[self.tipArray objectAtIndex:indexPath.row-1]).amount;
       str = [[NSNumber numberWithFloat:tip] stringValue];
       cell.tipLabel.text = str;
       NSDate *tipDate = ((TipDataModel*)[self.tipArray objectAtIndex:indexPath.row-1]).date;
       
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       [formatter setDateFormat:@"HH:mm:ss"];
       
       NSString *labelData = [formatter stringFromDate:tipDate];
       cell.dateLabel.text = labelData;
       
  
   }
    return cell;
    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row == 0)
    {
        ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
        [self.navigationController pushViewController:vc animated:YES];
      
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0)
    {
        NSLog(@"new tip is: %lu",(unsigned long)[_tipArray count]);
        [tableView reloadData];
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
/*- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
 
        TipDataModel *deltip = (TipDataModel*)[self.tipArray objectAtIndex:indexPath.row-1];
        [deltip deleteTip:deltip];
        [tableView reloadData];
       // [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleNone) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}*/
- (IBAction)editButton:(UIBarButtonItem*)sender {
   // self.edit = [[UIBarButtonItem alloc]init];

    NSString* title = [self.edit title];
    if([title isEqualToString:@"Edit"])
    {
        [self.edit setTitle:@"Fix" ];
        NSLog(@"EDIT Button Clicled");
      
    }
}
-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //float modtip;
        UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
            //insert your editAction here
            UIAlertController *alertController = [UIAlertController
                                                  alertControllerWithTitle:@"Edit"
                                                  message:@"enter new tip below"
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
             {
                 textField.placeholder = NSLocalizedString(@"TipPlaceholder", @"Tip");
                 
             }];
            UIAlertAction *cancelAction = [UIAlertAction
                                           actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                           style:UIAlertActionStyleCancel
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Cancel action");
                                           }];
            
            UIAlertAction *okAction = [UIAlertAction
                                       actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           TipDataModel *modifytip = (TipDataModel*)[self.tipArray objectAtIndex:indexPath.row-1];
                                           UITextField *tipTF = alertController.textFields.firstObject;
                                           float modtip = [tipTF.text floatValue];
                                           [modifytip editTip:modifytip edited:modtip];
                                           [tableView reloadData];
                                       }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];


        }];
        editAction.backgroundColor = [UIColor blueColor];
        
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
            TipDataModel *modifytip = (TipDataModel*)[self.tipArray objectAtIndex:indexPath.row-1];
            [modifytip deleteTip:modifytip];
            [tableView reloadData];
            //insert your deleteAction here
        }];
        deleteAction.backgroundColor = [UIColor redColor];
        return @[deleteAction,editAction];
    
}

/*-(void)edit:(UIBarButtonItem*)sender{
    NSString* title = sender.title;
    
    if ([title isEqualToString:EDIT]) {[barBtn2 setTitle:FIX];
        [_tableVIew setEditing:YES animated:YES];
        
    }else{
        
        [barBtn2 setTitle:EDIT];
        [_tableVIew setEditing:NO animated:YES];
    }
    
}*/

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
