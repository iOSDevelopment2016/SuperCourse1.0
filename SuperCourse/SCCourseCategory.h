//
//  SCCourseCategory.h
//  SuperCourse
//
//  Created by 刘芮东 on 16/1/25.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCCourseCategory : NSObject

@property (nonatomic, strong) NSString *courseCategoryId;       //分类内码
@property (nonatomic, strong) NSString *courseCatagoryTitle;            //分类标题
@property (nonatomic, strong) NSArray *courseGroupArr;          //分组列表

@end
