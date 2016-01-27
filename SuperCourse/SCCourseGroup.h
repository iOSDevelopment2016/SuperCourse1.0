//
//  SCCourseGroup.h
//  SuperCourse
//
//  Created by 刘芮东 on 16/1/25.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCCourseGroup : NSObject

@property (nonatomic, strong) NSString *courseGroupId;      //课程分组内码
@property (nonatomic, strong) NSString *courseGroupTitle;   //课程分组标题


@property (nonatomic, strong) NSArray *courseArr;           //课程列表


@end
