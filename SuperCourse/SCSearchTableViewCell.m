//
//  SCSearchTableViewCell.m
//  SuperCourse
//
//  Created by 李昶辰 on 16/1/28.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCSearchTableViewCell.h"
#import "SCPlayerViewController.h"
@interface SCSearchTableViewCell()
- (IBAction)searchBtnClick:(id)sender;


@end
@implementation SCSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma - mark getters
-(UIButton *)searchBtn{
    return _searchBtn;
    
}
-(UILabel *)status{
    return _status;
}
#pragma  - mark click
- (IBAction)searchBtnClick:(UIButton *)sender {
    NSInteger tag = sender.tag;
    NSInteger secIndex = tag / 1000;
    NSInteger rowIndex = tag - secIndex * 1000;
    [self.delegate searchBtnDidClickWithSectionIndex:secIndex AndRowIndex:rowIndex ];
}





@end