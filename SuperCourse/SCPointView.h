//
//  SCPointView.h
//  SuperCourse
//
//  Created by 孙锐 on 16/1/25.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>








@interface SCPointView : UIView

@property (nonatomic, strong) UIImageView *currentImageView;
@property (nonatomic, strong) UILabel *currentLabel;

- (instancetype)initWithFrame:(CGRect)frame AndObject:(NSMutableArray *)tempModel;


@end
