//
//  StreamViewController.h
//  eslpods
//
//  Created by 椛島優 on 2015/11/27.
//  Copyright © 2015年 椛島優. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StreamingPlayer.h"
#import "MultipeerHost.h"
@interface StreamViewController : UIViewController<MultipeerDataDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
