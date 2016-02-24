//
//  SCDownloadTableViewCell.h
//  SuperCourse
//
//  Created by 刘芮东 on 16/2/4.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THCircularProgressView.h"

@protocol SCDownloadTableViewCellDelegate <NSObject>

-(void)pause;
-(void)continueToDownload;
- (IBAction)playClick:(NSInteger)secIndex AndRowIndex:(NSInteger)rowIndex;
- (IBAction)deleteClick:(NSInteger)secIndex AndRowIndex:(NSInteger)rowIndex;
@end



@interface SCDownloadTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *videoName;
@property (strong, nonatomic) IBOutlet UILabel *videoSize;
@property (strong, nonatomic) IBOutlet UILabel *completeLabel;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) IBOutlet UIButton *deleteBtn;
@property (strong, nonatomic) IBOutlet UIButton *pauseBtn;
- (IBAction)playBtnClick:(id)sender;
- (IBAction)deleteBtnClick:(id)sender;
- (IBAction)pauseBtnClick:(id)sender;
@property (nonatomic,strong) THCircularProgressView *example2;
@property (strong, nonatomic) IBOutlet UIImageView *circle1;
@property (strong, nonatomic) IBOutlet UIImageView *circle2;
@property (strong, nonatomic) IBOutlet UIImageView *circle3;
@property (strong, nonatomic) IBOutlet UILabel *program;
@property (nonatomic, weak) id<SCDownloadTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSString *lessonID;

@end
