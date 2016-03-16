//
//  ViewController.h
//  eslpods
//
//  Created by 椛島優 on 2016/03/15.
//  Copyright © 2016年 椛島優. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultipeerHost.h"

@interface ViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *loomTextField;
@property (weak, nonatomic) IBOutlet UITableView *memberTable;

@end
