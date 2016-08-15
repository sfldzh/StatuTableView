//
//  StatuView.h
//  StatuTableView
//
//  Created by Dimoo on 16/8/15.
//  Copyright © 2016年 Dimoo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TableViewStatu) {
    TableViewStatuNoNetWork = -2,
    TableViewStatuNetWorkingError = -1,
    TableViewStatuNoData = 0,
    TableViewStatuSucess = 1,
    TableViewStatuLoding = 2
};
@protocol StatuViewDelegate <NSObject>

@optional
/**
 *	@author 施峰磊, 16-08-15 11:08:34
 *
 *	TODO:尝试加载
 *
 *	@since 1.0
 */
- (void)didTryLoadAgain;

@end

@interface StatuView : UIView
@property (nonatomic, assign) id<StatuViewDelegate>delegate;
@property (nonatomic, assign) TableViewStatu statu;
@property (nonatomic, strong) UITableView *tableView;

@end
