//
//  SCSearchView.h
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCSearchViewDelegate <NSObject>
//contendFieldDidClickWithSectionIndex:(NSInteger)secIndex AndRowIndex:(NSInteger)rowIndex

-(IBAction)searchBtnClick:(NSInteger)secIndex AndRowIndex:(NSInteger)rouIndex;
-(void)viewmove:(CGFloat) variety andUIView:(UIView *)scrollSearchView;
@end


@interface SCSearchView : UIView

@property (nonatomic ,weak) id<SCSearchViewDelegate> delegate;


@end
