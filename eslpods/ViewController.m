//
//  ViewController.m
//  eslpods
//
//  Created by 椛島優 on 2016/03/15.
//  Copyright © 2016年 椛島優. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property MultipeerHost * myMulti;
@property MBProgressHUD *hud;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myMulti=[[MultipeerHost alloc]init];
    _hud=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:self.hud];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)createBtnTapped:(id)sender {
    self.hud.labelText=@"検索中";
    [self.hud show:YES];
    [_myMulti startHostwithName:_loomTextField.text];
   
}
- (IBAction)searchBtnTapped:(id)sender {
    [_myMulti startClientwithName:_loomTextField.text];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
