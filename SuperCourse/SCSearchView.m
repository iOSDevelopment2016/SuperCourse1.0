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
@interface SCSearchView ()<UITableViewDataSource, UITableViewDelegate,SCSearchTableViewDelegate>
@property (nonatomic ,strong) UITableView *firstSearchTableView;
@property (nonatomic ,strong) UITableView *secondSearchTableView;
@property (nonatomic, strong) SCCourseCategory *firstSearchCategory;
@property (nonatomic, strong) SCCourseCategory *secondSearchCategory;
@property (nonatomic, strong) SCCourseCategory *currentSource;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic,strong)UIView *scrollSearchView;
@property (nonatomic, strong)UIView *stateView;
@property (nonatomic,strong)UILabel *state;
@property (nonatomic,strong)NSString *keyWord;
@end
@implementation SCSearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame searchKeyWord:(NSString *)keyWord
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.keyWord = keyWord;
        [self initData];
        [self addSubview:self.firstSearchTableView];
        [self addSubview:self.scrollSearchView];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.stateView];
        [self addSubview:self.state];

    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.firstSearchTableView.frame = CGRectMake(0, 200*HeightScale+7, self.width,810*HeightScale );
    self.scrollSearchView.frame = CGRectMake(0, 0, self.width, 100*HeightScale);
    self.scrollSearchView.backgroundColor= [UIColor whiteColor];
    self.firstSearchTableView.backgroundColor=[UIColor whiteColor];
    self.stateView.backgroundColor=[UIColor whiteColor];
    self.backgroundColor=UIBackgroundColor;
    self.leftBtn.frame=CGRectMake(350, 0, 0.127*self.width, 100*HeightScale);
    self.rightBtn.frame=CGRectMake(560, 0, 0.127*self.width, 100*HeightScale);
    self.stateView.frame = CGRectMake(0, 100*HeightScale+7, self.width, 100*HeightScale);
    self.state.frame= CGRectMake(0, 100*HeightScale+7, self.width, 100*HeightScale);
}

-(UIView *)scrollSearchView{
    if(!_scrollSearchView){
        _scrollSearchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 100*HeightScale)];
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
        _state=[[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.width, 100*HeightScale)];
        _state.font=[UIFont systemFontOfSize:25];
        _state.textColor=[UIColor grayColor];
        _state.text=@"搜索“key”共找到count个视频课程";
    }
    return _state;
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
    SCCourseGroup *temp = self.currentSource.sec_arr[section];
    return temp.lesarr.count;
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
        SCCourseGroup *temp=self.currentSource.sec_arr[indexPath.section];
        SCCourse *temp_=temp.lesarr[indexPath.row];
        //cell.textLabel.text=temp_.courseTitle;
        [cell.searchBtn setTitle:temp_.les_name forState:UIControlStateNormal];
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


//数据桩（调试程序用的假数据）
-(void)initData{
    
    //网络调用
    
    self.firstSearchCategory = [self getCourseCatagory:@"大纲"];
    self.secondSearchCategory = [self getCourseCatagory:@"拓展"];

    self.currentSource = self.firstSearchCategory;
}


-(SCCourseCategory *)getCourseCatagory2:(NSString *)title{
    SCCourseCategory *temp = [[SCCourseCategory alloc]init];
    temp.course_catagory_title = title;
    temp.course_category_id = @"UUID";
    SCCourseGroup *c1 = [self getCourseGroup:@"改变了"];
    SCCourseGroup *c2 = [self getCourseGroup:@"第二分组"];
    SCCourseGroup *c3 = [self getCourseGroup:@"第三分组"];
    SCCourseGroup *c4 = [self getCourseGroup:@"第四分组"];
    temp.sec_arr = @[c1,c2,c3,c4];
    return temp;
    
}



-(SCCourseGroup *)getCourseGroup:(NSString *)title{
    SCCourseGroup *temp = [[SCCourseGroup alloc]init];
    temp.lessections_name = title;
    temp.lessections_id = @"UUID";
    SCCourse *c1 = [self getCourse:@"这是视频"];
    SCCourse *c2 = [self getCourse:@"这是网页"];
    SCCourse *c3 = [self getCourse:@"第3节课"];
    SCCourse *c4 = [self getCourse:@"第4节课"];
    SCCourse *c5 = [self getCourse:@"第5节课"];
    SCCourse *c6 = [self getCourse:@"第6节课"];
    temp.lesarr = @[c1,c2,c3,c4,c5,c6];
    return temp;
    
}
-(SCCourseCategory *)getCourseCatagory:(NSString *)title{
    SCCourseCategory *temp = [[SCCourseCategory alloc]init];
    temp.course_catagory_title = title;
    temp.course_category_id = @"UUID";
    SCCourseGroup *c1 = [self getCourseGroup:@"第一分组"];
    SCCourseGroup *c2 = [self getCourseGroup:@"第二分组"];
    SCCourseGroup *c3 = [self getCourseGroup:@"第三分组"];
    SCCourseGroup *c4 = [self getCourseGroup:@"第四分组"];
    temp.sec_arr = @[c1,c2,c3,c4];
    return temp;
    
}

//生成一个课程信息
-(SCCourse *)getCourse:(NSString *)title{
    SCCourse *temp = [[SCCourse alloc]init];
    temp.les_name = title;
    temp.les_id = @"UUID";
    //temp.courseUrl = @"";
//    temp.course_abstract = @"描述";
    return temp;
}

@end
