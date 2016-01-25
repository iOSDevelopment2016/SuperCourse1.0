//
//  SCLoginView.h
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SCLoginViewDelegate <NSObject>

-(void)regBtnDidClick:(UIButton *)sender;

@end

@interface SCLoginView : UIView

@property (nonatomic ,weak) id<SCLoginViewDelegate> delegate;

@end
