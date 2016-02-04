//
//  SCSearchView.h
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SClesson_list.h"
#import "SCCourse.h"
@protocol SCSearchViewDelegate <NSObject>
//contendFieldDidClickWithSectionIndex:(NSInteger)secIndex AndRowIndex:(NSInteger)rowIndex

-(IBAction)searchBtnClick:(NSInteger)secIndex AndRowIndex:(NSInteger)rouIndex AndUrl:(NSString *)url;
-(void)viewmove:(CGFloat) variety andUIView:(UIView *)scrollSearchView;
-(void)videoPlayClickWithCourse:(SCCourse *)SCcourse;
@end


@interface SCSearchView : UIView

@property (nonatomic ,weak) id<SCSearchViewDelegate> delegate;
@property (nonatomic,strong)NSString *keyWord;


@end
