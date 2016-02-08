//
//  SCVideoHistoryView.m
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCVideoHistoryView.h"
#import "SCCustomButton.h"
#import "SCCourse.h"
#import "SCCourseGroup.h"
#import "SCCourseCategory.h"
#import "SCHistoryTableViewCell.h"
#import "AFNetworking.h"
#import "NSData+SZYKit.h"
#import "AFDownloadRequestOperation.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "SCHistory.h"
#import "UIAlertController+SZYKit.h"
@interface SCVideoHistoryView ()<UITableViewDataSource, UITableViewDelegate,SCHistoryTableViewDelegate>
@property (nonatomic ,strong) UITableView *historyTableView;
@property (nonatomic ,strong) UIView             *hubView;
@property (nonatomic ,strong) UIWebView          *webView;
@end


@implementation SCVideoHistoryView{
    NSMutableArray *historyArr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self initData];
         self.backgroundColor = [UIColor whiteColor];
//        [self addSubview:self.historyTableView];
        [self loadCourseListFromNetwork];
       
    }
    return self;
}
-(void)loadCourseListFromNetwork{
    
    NSString *stuid = ApplicationDelegate.userSession;
    NSDictionary *para = @{@"method":@"History",
                           @"param":@{@"Data":@{@"stuid":stuid}}};
    [HttpTool postWithparams:para success:^(id responseObject) {
        
        NSData *data = [[NSData alloc] initWithData:responseObject];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        historyArr = [NSMutableArray array];
        for (NSDictionary *tempDict in dic[@"data"][@"har_des"]) {
            SCHistory *tempHistory  = [SCHistory objectWithKeyValues:tempDict];
            [historyArr addObject:tempHistory];
        }

        [self addSubview:self.historyTableView];

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.historyTableView.frame = CGRectMake(0, 0, self.width, self.height);
    self.historyTableView.backgroundColor= [UIColor whiteColor];
//    [self loadCourseListFromNetwork];
}
-(UITableView *)historyTableView{
    if(!_historyTableView){
        _historyTableView = [[UITableView alloc]init];
        _historyTableView.delegate = self;
        _historyTableView.dataSource = self;
        _historyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return  _historyTableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
//    SCCourseGroup *temp = self.currentSource.sec_arr[section];
//    return temp.lesarr.count;
//    return h.count;
    return historyArr.count;
}

//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    SCHistoryTableViewCell *cell = (SCHistoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        //        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass:@"SCSearchTableViewCell"owner:nil options:nil] lastObject];
        cell= [[[NSBundle mainBundle]loadNibNamed:@"SCHistoryTableViewCell"owner:nil options:nil] firstObject];
        [cell.layer setBorderWidth:1];//设置边界的宽度
        [cell.layer setBorderColor:UIColorFromRGB(0xeeeeee).CGColor];
        cell.delegate=self;
//        SCCourseGroup *temp=self.currentSource.sec_arr[indexPath.section];
//        SCCourse *temp_=temp.lesarr[indexPath.row];
//        SCHistoryList *temp=self.currentSource.lesarr[indexPath.section];
//        SCHistoryList *h=self.currentSource.lesarr;
        SCHistory *h=historyArr[indexPath.row];
        //cell.textLabel.text=temp_.courseTitle;
        [cell.historyBtn setTitle:h.les_name forState:UIControlStateNormal];
        [cell.historyBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateHighlighted];
        cell.historyBtn.tag =indexPath.section * 1000 + indexPath.row;
//
        if ([h.is_ready isEqualToString:@"是"]) {
            cell.state.text=@"已看完";
        }else{
            cell.state.text= [NSString stringWithFormat:@"%d",(int)h.oversty_time];
        }
    }
    
    return cell;
}
//数据桩（调试程序用的假数据）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell =[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *state = [ApplicationDelegate getNetWorkStates];
    if ([state isEqualToString:@"无网络"]) {
        [UIAlertController showAlertAtViewController:self.viewController withMessage:@"请检查您的网络" cancelTitle:@"取消" confirmTitle:@"我知道了" cancelHandler:^(UIAlertAction *action) {
            
        } confirmHandler:^(UIAlertAction *action) {
            
        }];
    }
    else if ([state isEqualToString:@"wifi"]){
        SCHistory *currentHis = historyArr[indexPath.row];
        [self.delegate historyDidClick:currentHis.les_id];
    }
    else{
        [UIAlertController showAlertAtViewController:self.viewController withMessage:@"您正在使用3G/4G流量" cancelTitle:@"取消" confirmTitle:@"继续播放" cancelHandler:^(UIAlertAction *action) {
            
        } confirmHandler:^(UIAlertAction *action) {
            SCHistory *currentHis = historyArr[indexPath.row];
            [self.delegate historyDidClick:currentHis.les_id];

        }];
    }
}



@end
