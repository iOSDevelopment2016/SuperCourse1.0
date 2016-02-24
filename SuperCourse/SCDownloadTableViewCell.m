//
//  SCDownloadTableViewCell.m
//  SuperCourse
//
//  Created by 刘芮东 on 16/2/4.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCDownloadTableViewCell.h"

@implementation SCDownloadTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showTime:) name:@"sendTime" object:nil];
    self.example2 = [[THCircularProgressView alloc] initWithFrame:CGRectMake(650*WidthScale, 33*HeightScale, 60*HeightScale, 60*HeightScale)];
    self.example2.lineWidth = 8.0f;
    self.example2.progressColor = [UIColor greenColor];
    self.example2.centerLabel.font = [UIFont boldSystemFontOfSize:40];
    self.example2.centerLabelVisible = YES;
    self.example2.percentage=ApplicationDelegate.pram;
    [self addSubview:self.example2];
    
   

    // [self.examples addObject:self.example2];
    
    //出界面了再完善
    //[self.example2 setHidden:YES];
}



-(void)showTime:(NSNotification *)time{
    self.example2.percentage = [time.userInfo[@"time"]floatValue];
    //    if((self.example2.percentage=1)){
    //        [self.example2 setHidden:YES];
    //        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(1000*WidthScale, 20*HeightScale, 50*HeightScale, 50*HeightScale)];
    //        label.text=@"下载完成";
    //        [self addSubview:label];
    //    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"sendTime" object:nil];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)playBtnClick:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    NSInteger secIndex = tag / 1000;
    NSInteger rowIndex = tag - secIndex * 1000;
    //[self.delegate imageBtnDidClickWithSectionIndex:secIndex AndRowIndex:rowIndex];
    [self.delegate playClick:secIndex AndRowIndex:rowIndex];
    
}

- (IBAction)deleteBtnClick:(UIButton *)sender {
    
    NSInteger tag = sender.tag;
    NSInteger secIndex = tag / 1000;
    NSInteger rowIndex = tag - secIndex * 1000;
   // [self.delegate imageBtnDidClickWithSectionIndex:secIndex AndRowIndex:rowIndex];
    [self.delegate deleteClick:secIndex AndRowIndex:rowIndex];
    
}

- (IBAction)pauseBtnClick:(id)sender {
//    if(_pauseBtn.selected==NO){
//        [_pauseBtn setTitle:@"继续下载" forState:UIControlStateNormal];
//        _pauseBtn.selected=YES;
//        [self.delegate pause];
//    }else{
//        [_pauseBtn setTitle:@"暂停下载" forState:UIControlStateNormal];
//        _pauseBtn.selected=NO;
//        [self.delegate continueToDownload];
//        
//    }
    if([[_pauseBtn titleForState:UIControlStateNormal] isEqualToString:@"继续下载"]){
        [_pauseBtn setTitle:@"暂停下载" forState:UIControlStateNormal];
        
        [self.delegate continueToDownload];
    }else if([[_pauseBtn titleForState:UIControlStateNormal] isEqualToString:@"暂停下载"]){
        [_pauseBtn setTitle:@"继续下载" forState:UIControlStateNormal];
        
        [self.delegate pause];
    }
}

//-(UIButton *)pauseBtn{
//    if(_pauseBtn.selected==NO){
//        [_pauseBtn setTitle:@"暂停下载" forState:UIControlStateNormal];
//    }else{
//        [_pauseBtn setTitle:@"继续下载" forState:UIControlStateNormal];
//    }
//    return _pauseBtn;
//}
-(void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
