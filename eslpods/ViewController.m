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
@property  NSArray *memberArray;
@property BOOL isParent;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // ここに実行したいコード
    UITapGestureRecognizer *tapG=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onSingleTap:)];
    [self.view addGestureRecognizer:tapG];
    self.loomTextField.delegate=self;
    
    _myMulti=[[MultipeerHost alloc]init];
    self.memberArray=[[NSArray alloc]init];
    self.memberTable.delegate=self;
    self.memberTable.dataSource=self;
    _hud=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:self.hud];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(connectedOtherDevice:)
                                                 name:@"conn"
                                               object:_myMulti];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnectedOtherDevice)
                                                 name:@"disconn"
                                               object:_myMulti];


    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createBtnTapped:(id)sender {
    _isParent=YES;
    self.hud.labelText=@"公開中...タップして終了";
    [self.hud show:YES];
    [_myMulti startHostwithName:_loomTextField.text];
   
}
- (IBAction)searchBtnTapped:(id)sender {
    _isParent=NO;
    self.hud.labelText=@"検索中";
    [self.hud show:YES];
    [_myMulti startClientwithName:_loomTextField.text];
}
-(void)connectedOtherDevice:(NSNotification *)notification{
    NSString*str=[notification.userInfo objectForKey:@"KEY"];
    NSLog(str);
    self.memberArray=[self.memberArray arrayByAddingObject:str];
    dispatch_async(
                   dispatch_get_main_queue(),
                   ^{
                      [self.memberTable reloadData];
                      [self.hud hide:NO];
                       if (_isParent==YES) {
                          
                           UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"セッション" message:@"メンバーを締め切りますか？" preferredStyle:UIAlertControllerStyleAlert];
                           [alert addAction:[UIAlertAction actionWithTitle:@"はい" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                               [self startButtonPushed];
                           }]];
                           
                           [alert addAction:[UIAlertAction actionWithTitle:@"いいえ" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                               [self cancelButtonPushed];
                           }]];
                          
                           [self presentViewController:alert animated:YES completion:NULL];
                           
                       }else{
                           self.hud.labelText=@"待機中";
                           [self.hud show:YES];
                       }
                   }
                   );

    
    
}
-(void)disconnectedOtherDevice{
    
}
-(void)startButtonPushed{
    
}
-(void)cancelButtonPushed{
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
//table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger dataCount;
    
    // テーブルに表示するデータ件数を返す
    dataCount = self.memberArray.count;
    
    return dataCount;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    // 再利用できるセルがあれば再利用する
    UITableViewCell *cell = [self.memberTable dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        // 再利用できない場合は新規で作成
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.memberArray[indexPath.row];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
-(void)onSingleTap:(UITapGestureRecognizer *)sender{
    [self.hud hide:YES];
    [self.view endEditing:YES];
    NSLog(@"unk");
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
