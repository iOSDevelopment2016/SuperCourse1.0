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


//[{"les_id":"0002","lessections_id":"0001","order_num":"2","les_name":"\u9879\u76ee\u5185\u5bb9","les_url":"","les_alltime":"","les_size":"200M","operations":"\u89c6\u9891"}]}]


@end
