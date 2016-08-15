//
//  UITableView+Statu.h
//  StatuTableView
//
//  Created by Dimoo on 16/8/12.
//  Copyright © 2016年 Dimoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatuView.h"

typedef void(^didClickBlock)();

@interface UITableView (Statu)<StatuViewDelegate>
- (void)setStatu:(TableViewStatu)statu;
- (void)show;
- (void)setDidClick:(didClickBlock)clickBlock;

@end
