//
//  SCVideoLinkMode.m
//  SuperCourse
//
//  Created by 孙锐 on 16/1/31.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCVideoLinkMode.h"

@interface SCVideoLinkMode ()
 



@end

@implementation SCVideoLinkMode

- (instancetype)initWithTitle:(NSString *)title AndBeginTime:(float)beginTime AndTargetType:(NSString *)targetType AndLessonId:(NSString *)lessonId AndWebUrl:(NSString *)webUrl
{
    self = [super init];
    if (self) {
        self.title = title;
        self.beginTime = beginTime;
        self.targetType = targetType;
        self.lessonId = lessonId;
        self.webUrl = webUrl;
    }
    return self;
}
@end
