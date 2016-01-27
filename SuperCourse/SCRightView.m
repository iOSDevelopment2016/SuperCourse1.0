//
//  SCRightView.m
//  SuperCourse
//
//  Created by Develop on 16/1/24.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCRightView.h"
#import "SCPointView.h"
#import "ZQTagList.h"
#import "SCtempModel.h"


@implementation SCRightView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundView];
        [self setBackgroundColor:[UIColor clearColor]];
        [self addSubview:self.topView];
        [self.topView addSubview:self.extendBtn];
        [self.topView addSubview:self.pointBtn];
        [self.topView addSubview:self.blueBottom];
        self.extendBtn.selected = YES;
        
        [self getSubTitleData];
        self.extendArr = @[@"软件编程",@"互联网和局域网",@"类的定义",@"xcode的使用",@"系统",@"视频"];
        [self addSubview:self.tagList];
    }
    return self;
    
}

-(NSMutableArray *)getSubTitleData{
    NSArray *letterArr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L"];
    NSArray *dataArr = @[@"iOS的历史来源和发展历程",@"iOS的系统特性",@"局域网和互联网",@"编程环境的搭建"];
    NSArray *timeArr = @[@"10.0",@"17.0",@"24.0",@"27.0"];
    
//    for (int i=0 ; i<=dataArr.count; i++) {
//        
//        SCtempModel *m = [[SCtempModel alloc] init];
//        m.title = dataArr[i];
//        m.letter = letterArr[i];
//        m.beginTime = timeArr[i];
//        [self.subTitleArr insertObject:m atIndex:i];
//    }
    SCtempModel *m = [[SCtempModel alloc] init];
    m.title = dataArr[0];
    m.letter = letterArr[0];
    m.beginTime = timeArr[0];
    [self.subTitleArr insertObject:m atIndex:0];
    SCtempModel *m1 = [[SCtempModel alloc] init];
    m1.title = dataArr[1];
    m1.letter = letterArr[1];
    m1.beginTime = timeArr[1];
    [self.subTitleArr insertObject:m1 atIndex:1];
    SCtempModel *m2 = [[SCtempModel alloc] init];
    m2.title = dataArr[2];
    m2.letter = letterArr[2];
    m2.beginTime = timeArr[2];
    [self.subTitleArr insertObject:m2 atIndex:2];
    SCtempModel *m3 = [[SCtempModel alloc] init];
    m3.title = dataArr[3];
    m3.letter = letterArr[3];
    m3.beginTime = timeArr[3];
    [self.subTitleArr insertObject:m3 atIndex:3];
    
    return self.subTitleArr;
    
}

#pragma mark - 响应事件

-(void)extendBtnClick{
    
    self.extendBtn.selected = YES;
    self.pointBtn.selected = NO;
    if (self.blueBottom.bounds.origin.x != 108*WidthScale) {
        [UIView animateWithDuration:0.3 animations:^{
            self.blueBottom.transform = CGAffineTransformMakeTranslation(0, 0);
        }];
    }
    [self.pointView removeFromSuperview];
    [self addSubview:self.tagList];
}

-(void)pointBtnClick{
    
    self.extendBtn.selected = NO;
    self.pointBtn.selected = YES;
    if (self.blueBottom.bounds.origin.x != 338*WidthScale) {
        [UIView animateWithDuration:0.3 animations:^{
            self.blueBottom.transform = CGAffineTransformMakeTranslation(230*WidthScale, 0);
        }];
    }
    [self.tagList removeFromSuperview];
    [self addSubview:self.pointView];

    
}


#pragma mark - getters

-(UIView *)topView{
    
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.frame = CGRectMake(12*WidthScale, 0, self.bounds.size.width, 100*HeightScale);
        [_topView setBackgroundColor:[UIColor whiteColor]];
    }
    return _topView;
}

-(UIButton *)extendBtn{
    
    if (!_extendBtn) {
        _extendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_extendBtn setTitle:@"拓展" forState:UIControlStateNormal];
        _extendBtn.titleLabel.font = [UIFont systemFontOfSize:45*WidthScale];
        [_extendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_extendBtn setTitleColor:UIThemeColor forState:UIControlStateSelected];
        _extendBtn.frame = CGRectMake(108*WidthScale, 0, 200*WidthScale, 100*HeightScale);
        [_extendBtn addTarget:self action:@selector(extendBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.extendView addSubview:self.tagList];
    }
    return _extendBtn;
}

-(UIButton *)pointBtn{
    
    if (!_pointBtn) {
        _pointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pointBtn setTitle:@"节点" forState:UIControlStateNormal];
        _pointBtn.titleLabel.font = [UIFont systemFontOfSize:45*WidthScale];
        [_pointBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_pointBtn setTitleColor:UIThemeColor forState:UIControlStateSelected];
        _pointBtn.frame = CGRectMake(338*WidthScale, 0, 200*WidthScale, 100*HeightScale);
        [_pointBtn addTarget:self action:@selector(pointBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pointBtn;
}

-(UIView *)blueBottom{

    if (!_blueBottom) {
        _blueBottom = [[UIView alloc]initWithFrame:CGRectMake(108*WidthScale, 90*HeightScale, 200*WidthScale, 10*HeightScale)];
        _blueBottom.backgroundColor = UIThemeColor;
    }
    return _blueBottom;
}



-(UIView *)extendView{
    
    if (!_extendView) {
        _extendView = [[UIView alloc]initWithFrame:CGRectMake(12*WidthScale, 100*HeightScale, 647*WidthScale, 1282*HeightScale)];
        _extendView.backgroundColor = UIBackgroundColor;
       
        
    }
    return _extendView;
}

-(UIView *)backgroundView{

    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]initWithFrame:CGRectMake(12*WidthScale, 100*HeightScale, 647*WidthScale, 1282*HeightScale)];
        _backgroundView.backgroundColor = UIBackgroundColor;
    }
    return _backgroundView;
}

-(SCPointView *)pointView{

    if (!_pointView) {
        _pointView = [[SCPointView alloc]initWithFrame:CGRectMake(0, 100*HeightScale, 659*WidthScale, 1282*HeightScale) AndObject:self.subTitleArr];
    }
    return _pointView;
}

-(ZQTagList *)tagList{

    if (!_tagList) {
        _tagList = [[ZQTagList alloc]initWithFrame:CGRectMake(22*WidthScale, 110*HeightScale, 637*WidthScale, 1272*HeightScale)];
//        _tagList.view = self.extendView;
        [_tagList setLabelBackgroundColor:[UIColor whiteColor]];
        [_tagList setTags:self.extendArr];
//        [_tagList display];
//        [_tagList fittedSize];
    }
    return _tagList;
}

-(NSMutableArray *)subTitleArr{

    if (!_subTitleArr) {
        _subTitleArr = [[NSMutableArray alloc]initWithCapacity:10];
    }
    return _subTitleArr;
}

@end