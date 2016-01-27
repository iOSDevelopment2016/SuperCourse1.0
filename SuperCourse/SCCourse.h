//
//  SCCourse.h
//  SuperCourse
//
//  Created by 刘芮东 on 16/1/25.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCCourse : NSObject

// 属性名必须和数据库中的字段名匹配
@property (nonatomic, strong) NSString *lesId;       //课程内码
@property (nonatomic, strong) NSString *lesName;    //课程名称
@property (nonatomic, strong) NSString *lesUrl;      //课程视频文件链接
@property (nonatomic, strong) NSString *courseAbstract; //课程文字介绍
//@property (nonatomic, strong) NSArray *picArr;          //轮播图片Url列表


@property (nonatomic, strong) NSString *lessectionsId;
@property (nonatomic, strong) NSString *orderNum;
@property (nonatomic, strong) NSString *lesAlltime;
@property (nonatomic, strong) NSString *lesSize;
@property (nonatomic, strong) NSString *operations;


@end
