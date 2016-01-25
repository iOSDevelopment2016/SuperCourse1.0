//
//  SCAllCourseView.m
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCAllCourseView.h"
#import "SCCustomButton.h"

@interface SCAllCourseView ()

@property (nonatomic ,strong) UIImageView *topImageView;
@property (nonatomic ,strong) UIImageView *HeadImageView;
@property (nonatomic ,strong) UIImageView *CharacterImageView;
@property (nonatomic ,strong) SCCustomButton *startBtn;

@end

@implementation SCAllCourseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topImageView];
        [self.topImageView addSubview:self.startBtn];
        [self.topImageView addSubview:self.CharacterImageView];
        [self.topImageView addSubview:self.HeadImageView];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.topImageView.frame = CGRectMake(0, 0, self.width, 670*HeightScale);
    self.startBtn.frame = CGRectMake((self.topImageView.width-225)/2, self.topImageView.height-100, 225, 60);
    self.HeadImageView.frame=CGRectMake(744*WidthScale,65*HeightScale, 158*WidthScale, 158*HeightScale);
    self.CharacterImageView.frame=CGRectMake(270*WidthScale,280*HeightScale, 1087*WidthScale, 138*HeightScale);
}

#pragma mark - 响应事件
-(void)startBtnClick{
    
    [self.delegate startBtnDidClick];
}


#pragma mark - getters

-(UIImageView *)topImageView{
    if (!_topImageView){
        _topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SC_background"]];
        _topImageView.userInteractionEnabled = YES;
    }
    return _topImageView;
}

-(SCCustomButton *)startBtn{
    if (!_startBtn){
        _startBtn = [SCCustomButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setImage:[UIImage imageNamed:@"SC_start"] forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}


-(UIImageView *)HeadImageView{
    if(!_HeadImageView){
        
        _HeadImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iOS"]];

    }
    
    return _HeadImageView;
    
}

-(UIImageView *)CharacterImageView{
    if(!_CharacterImageView){
        
        _CharacterImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SC_c"]];
        
    }
    
    return _CharacterImageView;
    
}


@end
