//
//  SCSearchView.m
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCSearchView.h"
#import "SCCustomButton.h"
#import "SCCourse.h"
#import "SCCourseGroup.h"
#import "SCCourseCategory.h"
#import "SCSearchTableViewCell.h"
#import "AFNetworking.h"
#import "NSData+SZYKit.h"
#import "AFDownloadRequestOperation.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "SCSearchResult.h"
#import "SClesson_list.h"
#import "SCsearchCategory.h"
@interface SCSearchView ()<UITableViewDataSource, UITableViewDelegate,SCSearchTableViewDelegate>
@property (nonatomic ,strong) UITableView *firstSearchTableView;
@property (nonatomic ,strong) UITableView *secondSearchTableView;
@property (nonatomic, strong) SCsearchCategory *firstSearchCategory;
@property (nonatomic, strong) SCsearchCategory *secondSearchCategory;
@property (nonatomic, strong) SCsearchCategory *currentSource;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic,strong)UIView *scrollSearchView;
@property (nonatomic, strong)UIView *stateView;
@property (nonatomic,strong)UILabel *state;
@property (nonatomic, strong)UILabel *label;
@end
@implementation SCSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initData];
        [self addSubview:self.firstSearchTableView];
        [self addSubview:self.scrollSearchView];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.stateView];
        [self addSubview:self.state];
        [self addSubview:self.label];

    }
    return self;
}
       
-(void)layoutSubviews{
    [super layoutSubviews];
    self.firstSearchTableView.frame = CGRectMake(0, 200*HeightScale+7, self.width,810*HeightScale );
    self.scrollSearchView.frame = CGRectMake(0,100*HeightScale+7 , self.width, 100*HeightScale);
    self.scrollSearchView.backgroundColor= [UIColor whiteColor];
    self.firstSearchTableView.backgroundColor=[UIColor whiteColor];
    self.stateView.backgroundColor=[UIColor whiteColor];
    self.backgroundColor=UIBackgroundColor;
    self.leftBtn.frame=CGRectMake(350, 100*HeightScale+7 , 0.127*self.width, 100*HeightScale);
    self.rightBtn.frame=CGRectMake(560, 100*HeightScale+7 , 0.127*self.width, 100*HeightScale);
    self.stateView.frame = CGRectMake(0, 0, self.width, 100*HeightScale);
    self.state.frame= CGRectMake(500, 0, 0.5*self.width, 100*HeightScale);
    self.label.frame= CGRectMake(0, 0, self.width, 100*HeightScale);
//    [self loadCourseListFromNetwork];
    NSString *ti = self.keyWord;

}





-(void)loadCourseListFromNetwork{
    
    
    NSString *userSession = ApplicationDelegate.userSession;
    
    NSDictionary *para = @{@"method":@"Search",
                           @"param":@{@"Data":@{@"search_info":self.keyWord,@"stuid":ApplicationDelegate.userSession}}};
    //    NSDictionary *para = @{@"method":@"Login",
    //                           @"param":@{@"Data":@{@"phone":@"111",@"password":@"111"}}};
    [HttpTool postWithparams:para success:^(id responseObject) {
        
        NSData *data = [[NSData alloc] initWithData:responseObject];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        
//        
//        courseCategoryArr = [NSMutableArray array];
//        for (NSDictionary *catDict in dic[@"data"][@"categoryArr"]) {
//            SCCourseCategory *cat = [SCCourseCategory objectWithKeyValues:catDict];
//            NSMutableArray *secArr = [[NSMutableArray alloc]init];
////            for (NSDictionary *secDict in catDict[@"sec_arr"]) {
////                [SCCourseGroup setupObjectClassInArray:^NSDictionary *{
////                    return @{@"lesarr":@"SCCourse"};
////                }];
////                SCCourseGroup *sec = [SCCourseGroup objectWithKeyValues:secDict];
////                [secArr addObject:sec ];
//            }
//            cat.sec_arr = secArr;
//            [courseCategoryArr addObject:cat];
//        }
//        
//        
        
        
                [SCSearchResult setupObjectClassInArray:^NSDictionary *{
                    return @{@"lesson_list":@"SClesson_list"};
                }];
        //        [SCCourseCategory setupObjectClassInArray:^NSDictionary *{
        //            return @{@"sec_arr":@"SCCourseGroup"};
        //        }];
        //        [SCCourseCategory setupObjectClassInArray:^NSDictionary *{
        //            return @{@"categoryArr":@"SCCourseCategory"};
        //        }];
                SCSearchResult *SearchResult = [SCSearchResult objectWithKeyValues:dic[@"data"]];
        
//        self.firstSearchCategory=(SCSearchResult *)(SearchResult.grouping_id[0]);
//        
//        self.secondSearchCategory=(SCSearchResult *)(SearchResult.grouping_id[1]);
        //        self.firstCategory=(SCCourseCategory *)(categoryList.categoryArr[0]);
        //        self.secondCategory=(SCCourseCategory *)(categoryList.categoryArr[1]);
        if ( self.currentSource==self.firstSearchCategory)
        {
            [self addSubview:self.firstSearchTableView];
        }else if(self.currentSource==self.secondSearchCategory){
            [self addSubview:self.secondSearchTableView];
        }
   
  
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(UIView *)scrollSearchView{
    if(!_scrollSearchView){
        _scrollSearchView=[[UIView alloc]initWithFrame:CGRectMake(0, 100*HeightScale+7, self.width, 100*HeightScale)];
        _scrollSearchView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollSearchView;
}
-(UIView *)stateView{
    if(!_stateView){
        _stateView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 100*HeightScale)];
        _stateView.backgroundColor = [UIColor whiteColor];
    }
    return _stateView;
}
-(UILabel *)state{
    if(! _state){
        _state=[[UILabel alloc]init];
        _state.font=[UIFont systemFontOfSize:25];
        _state.textColor=[UIColor grayColor];
        _state.text=@"搜索keyWord共找到lescount个视频课程";
    }
    return _state;
}
-(UILabel *)label{
    if(! _label){
        _label=[[UILabel alloc]init];
        _label.font=[UIFont systemFontOfSize:25];
        _label.textColor=[UIColor grayColor];
        _label.text=@"搜索结果";
    }
    return _label;
}


-(UITableView *)firstSearchTableView{
    if(!_firstSearchTableView){
        _firstSearchTableView = [[UITableView alloc]init];
        _firstSearchTableView.delegate = self;
        _firstSearchTableView.dataSource = self;
        _firstSearchTableView.backgroundColor=[UIColor whiteColor];
    }
    return  _firstSearchTableView;
}
-(UITableView *)secondSearchTableView{
    if(!_secondSearchTableView){
        _secondSearchTableView = [[UITableView alloc]init];
        _secondSearchTableView.delegate = self;
        _secondSearchTableView.dataSource = self;
        
    }
    return  _secondSearchTableView;
}
//每组中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 0;
    SCsearchCategory *temp = self.currentSource;
    return temp.lesson_list.count;
}

//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    SCSearchTableViewCell *cell = (SCSearchTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

        if(cell == nil){
//        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass:@"SCSearchTableViewCell"owner:nil options:nil] lastObject];
            cell= [[[NSBundle mainBundle]loadNibNamed:@"SCSearchTableViewCell"owner:nil options:nil] firstObject];
         
        [cell.layer setBorderWidth:1];//设置边界的宽度
        [cell.layer setBorderColor:UIColorFromRGB(0xeeeeee).CGColor];
        cell.delegate=self;
     
            SClesson_list *temp= self.currentSource.lesson_list[indexPath.row];
//            SClesson_list *op =op.les_name;
        //cell.textLabel.text=temp_.courseTitle;
        [cell.searchBtn setTitle:temp.les_name forState:UIControlStateNormal];
        [cell.searchBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateHighlighted];
        cell.searchBtn.tag =indexPath.section * 1000 + indexPath.row;
    
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell =[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(UIButton *)leftBtn{
    if(!_leftBtn){
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //[_leftBtn setBackgroundColor:[UIColor greenColor]];
        [_leftBtn setTitle:@"大纲" forState:UIControlStateNormal];
        [_leftBtn setFont:[UIFont systemFontOfSize:30]];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateSelected];
        [_leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _leftBtn;
}
-(UIButton *)rightBtn{
    if(!_rightBtn){
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"拓展" forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_rightBtn setFont:[UIFont systemFontOfSize:30]];
        [_rightBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateSelected];
        //[_rightBtn setFont:[UIFont systemFontOfSize:<#(CGFloat)#>]];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rightBtn;
}

//-(UIView *)scrollView{
//    if(!_scrollView){
//        _scrollView=[[UIView alloc]initWithFrame:CGRectMake(520*WidthScale, 780*HeightScale, 200*HeightScale, 9*HeightScale)];
//        [_scrollView setBackgroundColor:UIColorFromRGB(0x6fccdb)];
//    }
//    return _scrollView;
//}


-(UIView *)leftView{
    if(_leftView){
        _leftView=[[UIView alloc]initWithFrame:CGRectMake(0.312*self.width, 670*HeightScale, 0.127*self.width, 9*HeightScale)];
        [_leftView setBackgroundColor:UIColorFromRGB(0x6fccdb)];
    }
    return _leftView;
}
-(UIView *)rightView{
    if(_rightView){
        _rightView=[[UIView alloc]initWithFrame:CGRectMake(0.312*self.width, 670*HeightScale, 0.127*self.width, 9*HeightScale)];
        [_rightView setBackgroundColor:UIColorFromRGB(0x6fccdb)];
    }
    return _rightView;
    
}
# pragma mark - 私有方法
-(void)move:(CGFloat)x{
    if(x>0){
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollSearchView.transform=CGAffineTransformMakeTranslation(x,0);
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            self.scrollSearchView.transform=CGAffineTransformIdentity;
        }];
        //self.scrollView.transform=CGAffineTransformIdentity;
    }
}
#pragma mark - 响应事件

-(void)leftBtnClick{
    self.leftBtn.selected=YES;
    self.rightBtn.selected=NO;
    self.currentSource=self.firstSearchCategory;
    [self.firstSearchTableView reloadData];
    [self.leftBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateSelected];
    [self move:-1];
    
}
-(void)rightBtnClick{
    self.leftBtn.selected=NO;
    self.rightBtn.selected=YES;
    self.currentSource=self.secondSearchCategory;
    [self.secondSearchTableView reloadData];
    CGFloat variety=self.rightBtn.frame.origin.x-self.scrollSearchView.frame.origin.x;
    [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [self move:variety];
}
-(IBAction)searchBtnDidClickWithSectionIndex:(NSInteger)secIndex AndRowIndex:(NSInteger)rowIndex{
//    SCCourseGroup *courseGroup=self.firstSearchCategory.sec_arr[secIndex];
    SClesson_list *selectedCourse = self.currentSource.lesson_list[rowIndex];
    if ([selectedCourse.operations isEqualToString:@"视频"]) {
        //NSString *urlvideo = selectedCourse.les_url;
        [self.delegate videoPlayClickWithCourse:selectedCourse];
    }else if ([selectedCourse.operations isEqualToString:@"网页"]) {
        NSString *urlWeb=selectedCourse.les_url;
        [self.delegate searchBtnClick:secIndex AndRowIndex:rowIndex AndUrl:urlWeb];
    }
}

//数据桩（调试程序用的假数据）
-(void)initData{
    
    //网络调用
    
    self.firstSearchCategory = [self getSearchCategory1:@"大纲"];
//    self.secondSearchCategory = [self getSearchCatagory2:@"拓展"];

    self.currentSource = self.firstSearchCategory;
}
//
////
//-(SCCourseCategory *)getCourseCatagory2:(NSString *)title{
//    SCCourseCategory *temp = [[SCCourseCategory alloc]init];
//    temp.lesgrouping_name = title;
//    temp.lesgrouping_id = @"UUID";
//    SCCourseGroup *c1 = [self getCourseGroup:@"改变了"];
//    SCCourseGroup *c2 = [self getCourseGroup:@"第二分组"];
//    SCCourseGroup *c3 = [self getCourseGroup:@"第三分组"];
//    SCCourseGroup *c4 = [self getCourseGroup:@"第四分组"];
//    temp.sec_arr = @[c1,c2,c3,c4];
//    return temp;
//    
//}
//-(SCCourseCategory *)getCourseCatagory1:(NSString *)title{
//    SCCourseCategory *temp = [[SCCourseCategory alloc]init];
//    temp.lesgrouping_name = title;
//    temp.lesgrouping_id = @"UUID";
//    SCCourseGroup *c1 = [self getCourseGroup:@"改变了"];
//    SCCourseGroup *c2 = [self getCourseGroup:@"第二分组"];
//    SCCourseGroup *c3 = [self getCourseGroup:@"第三分组"];
//    SCCourseGroup *c4 = [self getCourseGroup:@"第四分组"];
//    temp.sec_arr = @[c1,c2,c3,c4];
//    return temp;

//
//
//
-(SCsearchCategory *)getSearchCategory1:(NSString *)title{
    SCsearchCategory *temp = [[SCsearchCategory alloc]init];
//    temp.lesgrouping_name = title;
//    temp.lesgrouping_id = @"UUID";
    SClesson_list *c1 = [self getCourse:@"这是视频"];
    SClesson_list *c2 = [self getCourse:@"这是网页"];
    SClesson_list *c3 = [self getCourse:@"第3节课"];
    SClesson_list *c4 = [self getCourse:@"第4节课"];
    SClesson_list *c5 = [self getCourse:@"第5节课"];
    SClesson_list *c6 = [self getCourse:@"第6节课"];
    temp.lesson_list = @[c1,c2,c3,c4,c5,c6];
    return temp;

}
-(SCsearchCategory *)getSearchCategory2:(NSString *)title{
    SCsearchCategory *temp = [[SCsearchCategory alloc]init];
//    temp.lesgrouping_name = title;
//    temp.lesgrouping_id = @"UUID";
    SClesson_list *c1 = [self getCourse:@"这是视频"];
    SClesson_list *c2 = [self getCourse:@"这是网页"];
    SClesson_list *c3 = [self getCourse:@"第3节课"];
    SClesson_list *c4 = [self getCourse:@"第4节课"];
    SClesson_list *c5 = [self getCourse:@"第5节课"];
    SClesson_list *c6 = [self getCourse:@"第6节课"];
    temp.lesson_list = @[c1,c2,c3,c4,c5,c6];
    return temp;
    
}
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
//
//生成一个课程信息
-(SClesson_list *)getCourse:(NSString *)title{
    SClesson_list *temp = [[SClesson_list alloc]init];
    temp.les_name = title;
    temp.les_id = @"UUID";
    //temp.courseUrl = @"";
//    temp.course_abstract = @"描述";
    return temp;
}

@end
