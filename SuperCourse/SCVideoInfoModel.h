//
//  SCVideoInfoModel.h
//  SuperCourse
//
//  Created by 孙锐 on 16/1/31.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCVideoInfoModel : NSObject


@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) NSString *videoTitle;
@property (nonatomic, strong) NSString *videoFileSize;
@property (nonatomic, strong) NSMutableArray *videoSubTitles;
@property (nonatomic, strong) NSMutableArray *videoLinks;


- (instancetype)initWithVideoUrl:(NSString *)url AndTitle:(NSString *)title AndFileSize:(NSString *)fileSize AndSubTitles:(NSMutableArray *)subTitles AndLinks:(NSMutableArray *)links;

@end
