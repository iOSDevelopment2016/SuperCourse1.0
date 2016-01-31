//
//  SCVideoHistoryView.h
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SCHistoryViewDelegate <NSObject>
//contendFieldDidClickWithSectionIndex:(NSInteger)secIndex AndRowIndex:(NSInteger)rowIndex

-(IBAction)historyBtnClick:(NSInteger)secIndex AndRowIndex:(NSInteger)rouIndex;

@end

@interface SCVideoHistoryView : UIView
@property (nonatomic ,weak) id<SCHistoryViewDelegate> delegate;
@end
