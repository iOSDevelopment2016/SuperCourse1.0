//
//  SCPointView.h
//  SuperCourse
//
//  Created by 孙锐 on 16/1/25.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCPointViewDelegate <NSObject>

-(void)turnToTime:(UIButton *)sender;


@end


@interface SCPointView : UIView

@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UILabel *currentLabel;
@property (nonatomic, weak) id<SCPointViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame AndObject:(NSMutableArray *)tempModel;
- (void)changeSubTitleViewWithTime:(NSTimeInterval)elapsedTime;
- (NSString *)getCurrentSubTitle:(NSTimeInterval)elapsedTime;
@end
