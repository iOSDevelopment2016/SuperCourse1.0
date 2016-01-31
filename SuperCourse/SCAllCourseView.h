//
//  SCAllCourseView.h
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCCourse.h"
#import "SCCourseGroup.h"
#import "SCCourseCategory.h"
@protocol SCAllCourseViewDelegate <NSObject>
//contendFieldDidClickWithSectionIndex:(NSInteger)secIndex AndRowIndex:(NSInteger)rowIndex
-(void)startBtnDidClick;
-(IBAction)contendClick:(NSInteger)secIndex AndRowIndex:(NSInteger)rouIndex AndUrl:(NSString *)url;
-(IBAction)imageClickWithUrl:(NSString *)url;
-(void)viewmove:(CGFloat) variety andUIView:(UIView *)scrollView;
-(void)videoPlayClickWithCourse:(SCCourse *)SCcourse;
@end

@interface SCAllCourseView : UIView

@property (nonatomic ,weak) id<SCAllCourseViewDelegate> delegate;

@end
