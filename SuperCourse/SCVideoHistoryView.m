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
#import "SCHistoryList.h"
@interface SCVideoHistoryView ()<UITableViewDataSource, UITableViewDelegate,SCHistoryTableViewDelegate>
@property (nonatomic ,strong) UITableView *historyTableView;
@property (nonatomic, strong) SCHistoryList *historyCategory;
@property (nonatomic, strong) SCHistoryList *currentSource;
@property (nonatomic,strong)  SCHistoryList *historyGroup;
@property (nonatomic ,strong) UIView             *hubView;
@property (nonatomic ,strong) UIWebView          *webView;
@end





@implementation SCVideoHistoryView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
         self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.historyTableView];
        [self loadCourseListFromNetwork];
       
        

    }
    return self;
}
-(void)loadCourseListFromNetwork{
     NSString *stuid = @"0000";
    NSDictionary *para = @{@"method":@"History",
                           @"param":@{@"Data":@{@"stuid":stuid}}};
    //    NSDictionary *para = @{@"method":@"Login",
    //                           @"param":@{@"Data":@{@"phone":@"111",@"password":@"111"}}};
    [HttpTool postWithparams:para success:^(id responseObject) {
        
        NSData *data = [[NSData alloc] initWithData:responseObject];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"%@",dic[@"data"]);
        
        [SCHistoryList setupObjectClassInArray:^NSDictionary *{
            return @{@"lesarr":@"SCHistory"};
        }];
//        [SCCourseCategory setupObjectClassInArray:^NSDictionary *{
//            return @{@"sec_arr":@"SCCourseGroup"};
//        }];
        SCHistoryList *historyColumn = [SCHistoryList objectWithKeyValues:dic[@"data"]];
        
        self.historyCategory=historyColumn;
//        self.secondCategory=firstColumn;
        self.currentSource=self.historyCategory;
        
        [self addSubview:self.historyTableView];
//        [self addSubview:self.secondTableView];
        
        //[self.activityIndicator stopAnimating];               !!!!!!!!!
        //        NSLog(@"%@", first.course_catagory_title);
        //        NSLog(@"%@", first.course_category_id);
        //        NSLog(@"%@", first.sec_arr);
        //        for (int i = 0; i<first.sec_arr.count; i++) {
        //            SCCourseGroup *m = first.sec_arr[i];
        //            NSLog(@"%@",m.lessections_id);
        //            NSLog(@"%@",m.lessections_name);
        //            NSLog(@"%@",m.lesarr);
        //            for (int j = 0; j<m.lesarr.count; j++) {
        //                SCCourse *c = m.lesarr[j];
        //                NSLog(@"%@", c.les_id);
        //                NSLog(@"%@", c.les_name);
        //            }
        //        }
        //        NSLog(@"%@", first.sec_arr);
        
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
        
    }
    return  _historyTableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
//    SCCourseGroup *temp = self.currentSource.sec_arr[section];
//    return temp.lesarr.count;
//    return h.count;
    SCHistoryList *h=self.currentSource;
    return h.lesarr.count;
}

//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    SCHistoryTableViewCell *cell = (SCHistoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        //        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass:@"SCSearchTableViewCell"owner:nil options:nil] lastObject];
        SCHistoryList *h = [[SCHistoryList alloc]init];
        cell= [[[NSBundle mainBundle]loadNibNamed:@"SCHistoryTableViewCell"owner:nil options:nil] firstObject];
        
        [cell.layer setBorderWidth:1];//设置边界的宽度
        [cell.layer setBorderColor:UIColorFromRGB(0xeeeeee).CGColor];
        cell.delegate=self;
//        SCCourseGroup *temp=self.currentSource.sec_arr[indexPath.section];
//        SCCourse *temp_=temp.lesarr[indexPath.row];
//        SCHistoryList *temp=self.currentSource.lesarr[indexPath.section];
//        SCHistoryList *h=self.currentSource.lesarr;
        SCHistory *h_=self.currentSource.lesarr[indexPath.row];
        //cell.textLabel.text=temp_.courseTitle;
        [cell.historyBtn setTitle:h_.les_name forState:UIControlStateNormal];
        [cell.historyBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateHighlighted];
//        cell.historyBtn.tag =indexPath.section * 1000 + indexPath.row;
//
    }
//        if ([h.is_ready isEqualToString:@"是"]) {
//           cell.state.text=@"已看完";
//        }else{
//            cell.state.text=time;
//        }
    return cell;
}
//- (IBAction)historyBtnDidClickWithSectionIndex:(NSInteger)secIndex AndRowIndex:(NSInteger)rowIndex{
//    
//    [SCVideoHistoryView addSubview:self.hubView];
//    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(100, 100, 1000, 800)];
//    
//    
//    
//    [self.view addSubview:self.webView];
//    
//    
//    
//    
//    
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
//    
//    
//    
//    //运行一下，百度页面就出来了
//    
//    
//    
//    [self.webView loadRequest:request];
//    
//    
//    
//    
//    
//}
//数据桩（调试程序用的假数据）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell =[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(void)initData{
//    self.historyCategory = [self getCourseCatagory:@"大纲"];
    self.historyCategory=[self gethistoryCategory];
    self.currentSource = self.historyCategory;
}

-(SCHistoryList *)gethistoryCategory{
    SCHistoryList *temp=[[SCHistoryList alloc]init];
    SCHistory *c1 = [self getCourse:@"这是视频"];
    SCHistory *c2 = [self getCourse:@"这是网页"];
    SCHistory *c3 = [self getCourse:@"第3节课"];
    SCHistory *c4 = [self getCourse:@"第4节课"];
    SCHistory *c5 = [self getCourse:@"第5节课"];
    SCHistory *c6 = [self getCourse:@"第6节课"];
    temp.lesarr= @[c1,c2,c3,c4,c5,c6];
    return temp;

    
    
    
    
}
//-(SCCourseCategory *)getCourseCatagory2:(NSString *)title{
//    SCCourseCategory *temp = [[SCCourseCategory alloc]init];
//    temp.lesgrouping_name = title;
//    temp.lesgrouping_id = @"UUID";
//    SCCourseGroup *c1 = [self getCourseGroup:@"改变了"];
//    SCCourseGroup *c2 = [self getCourseGroup:@"第二分组"];
//    SCCourseGroup *c3 = [self getCourseGroup:@"第三分组"];
//    SCCourseGroup *c4 = [self getCourseGroup:@"第四分组"];
//    
//    temp.sec_arr = @[c1,c2,c3,c4];
//    return temp;
//    
//}



//-(SCCourseGroup *)getCourseGroup:(NSString *)title{
//    SCCourseGroup *temp = [[SCCourseGroup alloc]init];
////    temp.lessections_name = title;
////    temp.lessections_id = @"UUID";
////    NSArray *arr = @[@"这是视频",@"这是视频",@"这是视频",@"这是视频",@"这是视频",@"这是视频"];
////    
////    for (int i = 0; i<6; i++) {
////        SCCourse *c = [self getCourse:arr[i]];
////        [temp.lesarr addObject:c];
////    }
//    
//    SCCourse *c1 = [self getCourse:@"这是视频"];
//    SCCourse *c2 = [self getCourse:@"这是网页"];
//    SCCourse *c3 = [self getCourse:@"第3节课"];
//    SCCourse *c4 = [self getCourse:@"第4节课"];
//    SCCourse *c5 = [self getCourse:@"第5节课"];
//    SCCourse *c6 = [self getCourse:@"第6节课"];
//    temp.lesarr = @[c1,c2,c3,c4,c5,c6];
//    return temp;
//    
//}
//-(SCCourseCategory *)getCourseCatagory:(NSString *)title{
//    SCCourseCategory *temp = [[SCCourseCategory alloc]init];
//    temp.lesgrouping_name = title;
//    temp.lesgrouping_id = @"UUID";
//    SCCourseGroup *c1 = [self getCourseGroup:@"第一分组"];
//    SCCourseGroup *c2 = [self getCourseGroup:@"第二分组"];
//    SCCourseGroup *c3 = [self getCourseGroup:@"第三分组"];
//    SCCourseGroup *c4 = [self getCourseGroup:@"第四分组"];
//    temp.sec_arr = @[c1,c2,c3,c4];
//    return temp;
//    
//}

//生成一个课程信息
-(SCHistory *)getCourse:(NSString *)title{
    SCHistory *temp=[[SCHistory alloc]init];
    temp.les_name= title;
    temp.les_id=@"UUID";
//    SCCourse *temp = [[SCCourse alloc]init];
//    temp.les_name = title;
//    temp.les_id = @"UUID";
    //temp.courseUrl = @"";
//    temp.course_abstract = @"描述";
    return temp;
}


@end
