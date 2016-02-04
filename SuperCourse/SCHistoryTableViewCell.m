//
//  SCHistoryTableViewCell.m
//  SuperCourse
//
//  Created by 李昶辰 on 16/1/29.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCHistoryTableViewCell.h"
#import "SCPlayerViewController.h"


@interface SCHistoryTableViewCell()
- (IBAction)historyBtnClick:(id)sender;


@end




@implementation SCHistoryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma - mark getters
-(UIButton *)historyBtn{
    return _historyBtn;
    
}
-(UILabel *)state{
    return _state;
}
#pragma  - mark click
- (IBAction)historyBtnClick:(UIButton *)sender {
//    NSInteger tag = sender.tag;
//    NSInteger secIndex = tag / 1000;
//    NSInteger rowIndex = tag - secIndex * 1000;
//    [self.delegate historyBtnDidClickWithSectionIndex:secIndex AndRowIndex:rowIndex ];
}






@end
