//
//  UITableView+Statu.m
//  StatuTableView
//
//  Created by Dimoo on 16/8/12.
//  Copyright © 2016年 Dimoo. All rights reserved.
//

#import "UITableView+Statu.h"
#import <objc/runtime.h>


@implementation UITableView (Statu)

- (void)setStatu:(TableViewStatu)statu{
    objc_setAssociatedObject(self, @"statu", @(statu), OBJC_ASSOCIATION_ASSIGN);
    if (![self getStatuView]) {
        [self setStatuView];
    }
}

- (TableViewStatu)statu{
    NSNumber *statuNunber = objc_getAssociatedObject(self, @"statu");
    return [statuNunber integerValue];
}

- (void)setStatuView{
    StatuView *statuView = [[StatuView alloc] initWithFrame:CGRectZero];
    statuView.tableView = self;
    statuView.delegate = self;
    objc_setAssociatedObject(self, @"statuView", statuView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (StatuView *)getStatuView{
    return objc_getAssociatedObject(self, @"statuView");
}

- (void)setDidClick:(didClickBlock)clickBlock{
    objc_setAssociatedObject(self, @"clickBlock", clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (didClickBlock)getClickBlock{
    return objc_getAssociatedObject(self, @"clickBlock");
}

- (void)show{
    TableViewStatu statu = [self statu];
    StatuView *statuView = [self getStatuView];
    statuView.statu = statu;
}

#pragma mark - StatuViewDelegate
/**
 *	@author 施峰磊, 16-08-15 11:08:34
 *
 *	TODO:尝试加载
 *
 *	@since 1.0
 */
- (void)didTryLoadAgain{
    didClickBlock block = [self getClickBlock];
    [self setStatu:TableViewStatuLoding];
    StatuView *statuView = [self getStatuView];
    statuView.statu = TableViewStatuLoding;
    if (block) {
        block();
    }
}
@end
