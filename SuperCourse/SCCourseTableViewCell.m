//
//  SCCourseTableViewCell.m
//  SuperCourse
//
//  Created by 刘芮东 on 16/1/25.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCCourseTableViewCell.h"
#import "SCPlayerViewController.h"
@interface SCCourseTableViewCell ()

- (IBAction)contendFieldClick:(id)sender;
- (IBAction)imageBtnClick:(id)sender;
- (IBAction)downloadBtnClick:(id)sender;

@end
@implementation SCCourseTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma - mark getters
-(UIButton *)contentField{
    return _contentField;
}
-(UIButton *)imageBtn{
    
    return _imageBtn;
}
-(UILabel *)courseLabel{
    return _courseLabel;
}

-(UIButton *)downloadBtn{
    return _downloadBtn;
}

#pragma - mark click
- (IBAction)contendFieldClick:(UIButton *)sender {
    NSInteger tag = sender.tag;
    NSInteger secIndex = tag / 1000;
    NSInteger rowIndex = tag - secIndex * 1000;
    [self.delegate contendFieldDidClickWithSectionIndex:secIndex AndRowIndex:rowIndex ];
}

- (IBAction)imageBtnClick:(id)sender {
    [self.delegate imageBtnDidClick];
}

- (IBAction)downloadBtnClick:(id)sender {
    
    
}
@end
