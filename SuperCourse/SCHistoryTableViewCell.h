//
//  SCHistoryTableViewCell.h
//  SuperCourse
//
//  Created by 李昶辰 on 16/1/29.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>





@protocol SCHistoryTableViewDelegate <NSObject>

- (IBAction)historyBtnDidClickWithSectionIndex:(NSInteger)secIndex AndRowIndex:(NSInteger)rowIndex;


@end

@interface SCHistoryTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *historyBtn;
@property (strong, nonatomic) IBOutlet UILabel *state;
@property (nonatomic ,weak) id<SCHistoryTableViewDelegate> delegate;

@end
