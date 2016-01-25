//
//  SCPlayerViewController.m
//  SuperCourse
//
//  Created by Develop on 16/1/24.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCPlayerViewController.h"
#import "SCRightView.h"
#import "SCVIdeoInfo.h"

@interface SCPlayerViewController ()

@property (nonatomic ,strong) UIButton *backBtn;
@property (nonatomic ,strong) UIImageView *playerImageView;
@property (nonatomic ,strong) UIButton *openRightBtn;
@property (nonatomic ,strong) SCRightView *rightView;

@end

@implementation SCPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.playerImageView];
    [self.view addSubview:self.openRightBtn];
    [self.view addSubview:self.rightView];
    
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    CGFloat topBarH = 70;
    CGFloat bottomBarH = 100;
    self.backBtn.frame = CGRectMake(10, 0, 100, topBarH);
    self.playerImageView.frame = CGRectMake(0, topBarH, self.view.width, self.view.height-topBarH-bottomBarH);
    self.openRightBtn.frame = CGRectMake(self.view.width-100, self.view.height-bottomBarH, 100, bottomBarH);
    self.rightView.frame = CGRectMake(self.view.width, 0, 430, self.view.height-bottomBarH);
}

-(void)loadData{
    

    
}

#pragma mark - 响应事件
-(void)backBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)openRightBtnClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.rightView.transform = sender.selected ? CGAffineTransformMakeTranslation(-430, 0) : CGAffineTransformIdentity;
    }];
    
}

#pragma mark - getters
-(UIImageView *)playerImageView{
    if (!_playerImageView){
        _playerImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SC_background"]];
    }
    return _playerImageView;
}

-(UIButton *)backBtn{
    if (!_backBtn){
        _backBtn = [[UIButton alloc]init];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setTitleColor:UIThemeColor forState:UIControlStateNormal];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:23];
    }
    return _backBtn;
}

-(UIButton *)openRightBtn{
    if (!_openRightBtn){
        _openRightBtn = [[UIButton alloc]init];
        [_openRightBtn addTarget:self action:@selector(openRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_openRightBtn setTitleColor:UIThemeColor forState:UIControlStateNormal];
        [_openRightBtn setTitle:@"打开" forState:UIControlStateNormal];
        [_openRightBtn setTitle:@"收起" forState:UIControlStateSelected];
        _openRightBtn.titleLabel.font = [UIFont systemFontOfSize:23];
    }
    return _openRightBtn;
}

-(SCRightView *)rightView{
    if (!_rightView){
        _rightView = [[SCRightView alloc]init];
        
    }
    return _rightView;
}

@end
