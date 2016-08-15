//
//  StatuView.m
//  StatuTableView
//
//  Created by Dimoo on 16/8/15.
//  Copyright © 2016年 Dimoo. All rights reserved.
//

#import "StatuView.h"
@interface StatuView()
@property (nonatomic, strong) UILabel                   *describeLabel;
@property (nonatomic, strong) UIImageView               *statuImageView;
@property (nonatomic, strong) UIActivityIndicatorView   *indicatorView;
@end

@implementation StatuView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addViews];
        [self addGesture];
    }
    return self;
}

- (void)addGesture{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClick)];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapGestureRecognizer];
}

- (void)addViews{
    [self addSubview:self.describeLabel];
    [self addSubview:self.statuImageView];
    [self addSubview:self.indicatorView];
}

- (UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _describeLabel.numberOfLines = 0;
        _describeLabel.textColor = [UIColor lightGrayColor];
        _describeLabel.font = [UIFont systemFontOfSize:13.0];
    }
    return _describeLabel;
}
- (UIImageView *)statuImageView{
    if (!_statuImageView) {
        _statuImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _statuImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _statuImageView;
}

- (UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (void)setStatu:(TableViewStatu)statu{
    _statu = statu;
    [self setStatuViewStatu:statu];
    NSString *describe;
    NSString *imageName = nil;
    switch (statu) {
        case TableViewStatuNoNetWork:
            imageName = @"noNetWork";
            describe = @"请检查网络是否链接";
            break;
        case TableViewStatuNetWorkingError:
            imageName = @"error";
            describe = @"服务器出错了，请重试";
            break;
        case TableViewStatuNoData:
            imageName = @"no_data";
            describe = @"没有任何数据哦";
            break;
        case TableViewStatuSucess:
            describe = @"";
            break;
        case TableViewStatuLoding:
            describe = @"正在获取...";
            break;
            
        default:
            break;
    }
    if (imageName) {
        self.statuImageView.image = [UIImage imageNamed:imageName];
    }else{
        self.statuImageView.image = nil;
    }
    
    self.describeLabel.text = describe;
    [self setViewPosition];
}

/**
 *	@author 施峰磊, 16-08-15 10:08:17
 *
 *	TODO:设置状态视图的状态
 *
 *	@param statu	状态
 *
 *	@since 1.0
 */
- (void)setStatuViewStatu:(TableViewStatu)statu{
    if (statu == TableViewStatuLoding) {
        if (!self.superview) {
            [self.tableView addSubview:self];
        }
        self.statuImageView.hidden = YES;
        self.statuImageView.image = nil;
        [self.indicatorView startAnimating];
    }else if (statu == TableViewStatuSucess){
        if (self.superview) {
            [self removeFromSuperview];
        }
    }else{
        if (!self.superview) {
            [self.tableView addSubview:self];
        }
        self.statuImageView.hidden = NO;
        [self.indicatorView stopAnimating];
    }
}

/**
 *	@author 施峰磊, 16-08-15 12:08:39
 *
 *	TODO:布局
 *
 *	@since 1.0
 */
- (void)setViewPosition{
    if (self.statu == TableViewStatuLoding) {
        CGFloat ndicatorSize = 22;
        CGSize describeSize = [self.describeLabel.text boundingRectWithSize:CGSizeMake(200-ndicatorSize -10, 190) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.describeLabel.font} context:nil].size;
        CGFloat width = ndicatorSize+10+describeSize.width+5;
        CGFloat height = ndicatorSize>=describeSize.height?ndicatorSize:describeSize.height;
        height +=10;
        self.frame = CGRectMake((CGRectGetWidth(self.tableView.frame)-width)/2, (CGRectGetHeight(self.tableView.frame)-height)/2, width, height);
        self.indicatorView.frame = CGRectMake(5, (self.frame.size.height-ndicatorSize)/2, ndicatorSize, ndicatorSize);
        self.describeLabel.frame = CGRectMake(CGRectGetMaxX(self.indicatorView.frame)+5, (CGRectGetHeight(self.frame)-describeSize.height)/2, describeSize.width, describeSize.height);
    }else{
        CGFloat statuImageSize = 60;
        CGSize describeSize = [self.describeLabel.text boundingRectWithSize:CGSizeMake(200-10, CGRectGetHeight(self.tableView.frame)-20-statuImageSize) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.describeLabel.font} context:nil].size;
        CGFloat width = describeSize.width+10;
        CGFloat height = 5+statuImageSize+10+describeSize.height+5;
        
        self.frame = CGRectMake((CGRectGetWidth(self.tableView.frame)-width)/2, (CGRectGetHeight(self.tableView.frame)-height)/2, width, height);
        
        self.statuImageView.frame = CGRectMake((CGRectGetWidth(self.frame)-statuImageSize)/2, 5, statuImageSize, statuImageSize);
        self.describeLabel.frame = CGRectMake(5, CGRectGetMaxY(self.statuImageView.frame)+10, describeSize.width, describeSize.height);
    }
}

- (void)didClick{
    if (self.statu != TableViewStatuSucess && self.statu != TableViewStatuLoding) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didTryLoadAgain)]) {
            [self.delegate didTryLoadAgain];
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self setViewPosition];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
