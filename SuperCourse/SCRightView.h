//
//  SCRightView.h
//  SuperCourse
//
//  Created by Develop on 16/1/24.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCPointView.h"
#import "ZQTagList.h"
@interface SCRightView : UIView<ZQTagListDelegate>
@property (nonatomic, strong) IBOutlet UIView *topView;
@property (nonatomic, strong) IBOutlet UIButton *pointBtn;
@property (nonatomic, strong) IBOutlet UIButton *extendBtn;
@property (nonatomic, strong) IBOutlet UIView *extendView;
//@property (nonatomic, strong) IBOutlet UIScrollView *pointView;
@property (nonatomic, strong) IBOutlet UIView *blueBottom;
@property (nonatomic, strong) IBOutlet UIButton *noteViewBtn;
@property (nonatomic, strong) IBOutlet UIView *backgroundView;
@property (nonatomic, strong) IBOutlet ZQTagList *tagList;
@property (nonatomic, strong) IBOutlet SCPointView *pointView;

//@property NSArray *letterArr;
//@property NSArray *dataArr;
@property NSArray *extendArr;
@property (nonatomic, strong) NSMutableArray *subTitleArr;

@property (nonatomic, assign) id<SCPointViewDelegate> pointViewDelegate;
@end

