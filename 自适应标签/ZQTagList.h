//
//  ZQTagList.h
//  yousheng
//
//  Created by Zery on 15/2/2.
//  Copyright (c) 2015年 张洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZQTagListDelegate <NSObject>

- (void)searchThis:(id)sender;

@end

@interface ZQTagList : UIView
{
    CGSize sizeFit;
    UIColor *lblBackgroundColor;
}

@property (nonatomic, strong) UIView                    *view;
@property (nonatomic, strong) NSMutableArray            *textArray;
@property (nonatomic, assign) id <ZQTagListDelegate>    delegate;

- (void)setLabelBackgroundColor:(UIColor *)color;
- (void)setTags:(NSArray *)array;
- (void)display;
- (CGSize)fittedSize;
@end
