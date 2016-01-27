//
//  SCAllCourseView.m
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCAllCourseView.h"
#import "SCCustomButton.h"
#import "SCCourse.h"
#import "SCCourseGroup.h"
#import "SCCourseCategory.h"
#import "SCCourseTableViewCell.h"

@interface SCAllCourseView ()<UITableViewDataSource, UITableViewDelegate,SCCourseTableViewDelegate>

@property (nonatomic ,strong) UIImageView *topImageView;
@property (nonatomic ,strong) UIImageView *headImageView;
@property (nonatomic ,strong) UIImageView *characterImageView;
@property (nonatomic ,strong) SCCustomButton *startBtn;

@property (nonatomic ,strong) UITableView *firstTableView;
@property (nonatomic ,strong) UITableView *secondTableView;

@property (nonatomic ,strong) UIButton     *leftBtn;
@property (nonatomic ,strong) UIButton     *rightBtn;

@property (nonatomic ,strong) UIView       *scrollView;

@property (nonatomic, strong) SCCourseCategory *firstCategory;
@property (nonatomic, strong) SCCourseCategory *secondCategory;
@property (nonatomic, strong) SCCourseCategory *currentSource;


@end

@implementation SCAllCourseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.topImageView];
        [self.topImageView addSubview:self.startBtn];
        [self.topImageView addSubview:self.characterImageView];
        [self.topImageView addSubview:self.headImageView];
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self addSubview:self.scrollView];
        //[self addSubview:self.secondTableView];
        [self addSubview:self.firstTableView];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.leftBtn.selected = YES;
    self.topImageView.frame = CGRectMake(0, 0, self.width, 670*HeightScale);
    self.startBtn.frame = CGRectMake((self.topImageView.width-225)/2, self.topImageView.height-100, 225, 60);
    self.headImageView.frame=CGRectMake(744*WidthScale,65*HeightScale, 158*WidthScale, 158*HeightScale);
    self.characterImageView.frame=CGRectMake(270*WidthScale,280*HeightScale, 1087*WidthScale, 138*HeightScale);
    self.leftBtn.frame=CGRectMake(0.312*self.width, 670*HeightScale, 0.127*self.width, 130*HeightScale);
    self.rightBtn.frame=CGRectMake(0.562*self.width, 670*HeightScale, 0.127*self.width, 130*HeightScale);
    self.firstTableView.frame = CGRectMake(0, 800*HeightScale, self.width, 500*HeightScale);
    self.secondTableView.frame = CGRectMake(0, 800*HeightScale, self.width, 500*HeightScale);
}

#pragma mark - delegate
//-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
// {
//        UITableViewCell*cell =[self tableView:tableView cellForRowAtIndexPath:indexPath];
//         return cell.frame.size.height;
//}

# pragma mark - 私有方法
-(void)move:(CGFloat)x{
    [self.delegate viewmove:x andUIView:self.scrollView];
    //CGFloat ScaleHeight=[self getScaleHeight];
//    [UIView animateWithDuration:0.5 animations:^{
//        self.scrollView.transform=CGAffineTransformMakeTranslation(self.variety,0);
//    }];
//    [UIView animateWithDuration:0.5 animations:^{
//        self.scrollView.transform=CGAffineTransformMakeTranslation(x , 0);
//    }];
}


#pragma mark - 响应事件
-(void)startBtnClick{
    
    [self.delegate startBtnDidClick];
}
-(IBAction)contendFieldDidClickWithSectionIndex:(NSInteger)secIndex AndRowIndex:(NSInteger)rowIndex{
    [self.delegate contendClick:secIndex AndRowIndex:rowIndex];
}

-(IBAction)imageBtnDidClick{
    [self.delegate imageClick];
}

-(void)leftBtnClick{
    self.leftBtn.selected=YES;
    self.rightBtn.selected=NO;
    self.currentSource=self.firstCategory;
    [self.firstTableView reloadData];
    CGFloat variety=self.leftBtn.frame.origin.x-self.scrollView.frame.origin.x;
    [self move:variety];
    
}
-(void)rightBtnClick{
    self.leftBtn.selected=NO;
    self.rightBtn.selected=YES;
    self.currentSource=self.secondCategory;
    [self.firstTableView reloadData];
    CGFloat variety=self.rightBtn.frame.origin.x-self.scrollView.frame.origin.x;
    [self move:variety];
}

#pragma mark - getters

-(UIImageView *)topImageView{
    if (!_topImageView){
        _topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SC_background"]];
        _topImageView.userInteractionEnabled = YES;
    }
    return _topImageView;
}

-(SCCustomButton *)startBtn{
    if (!_startBtn){
        _startBtn = [SCCustomButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setImage:[UIImage imageNamed:@"SC_start"] forState:UIControlStateNormal];
        [_startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}


-(UIImageView *)headImageView{
    if(!_headImageView){
        
        _headImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iOS"]];
        
    }
    return _headImageView;
    
}

-(UIImageView *)characterImageView{
    if(!_characterImageView){
        
        _characterImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SC_c"]];
        
    }
    
    return _characterImageView;
    
}

-(UITableView *)firstTableView{
    if(!_firstTableView){
        _firstTableView = [[UITableView alloc]init];
        _firstTableView.delegate = self;
        _firstTableView.dataSource = self;
        
    }
    return  _firstTableView;
}

-(UITableView *)secondTableView{
    if(!_secondTableView){
        _secondTableView = [[UITableView alloc]init];
        _secondTableView.dataSource = self;
        _secondTableView.delegate = self;
    }
    return  _secondTableView;
}




- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
   // NSString *key = [keys objectAtIndex:section];
    
    
    // create the parent view that will hold header Label
    
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , self.width, 670*HeightScale)];
    
    customView.backgroundColor=UIColorFromRGB(0xeeeeee);
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    
    headerLabel.opaque = NO;
    
    headerLabel.textColor = [UIColor blackColor];
    
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    
    headerLabel.font = [UIFont italicSystemFontOfSize:35*HeightScale];
    
    headerLabel.frame = CGRectMake(40.0, 10.0, 300.0, 44.0);
    
    SCCourseGroup *temp = self.currentSource.courseGroupArr[section];
    
    headerLabel.text = temp.courseGroupTitle;
    
    
    [customView addSubview:headerLabel];
    
    
    return customView;
    
}
















//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    //return 2;//返回标题数组中元素的个数来确定分区的个数
    return self.currentSource.courseGroupArr.count;
    
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    SCCourseGroup *temp = self.firstCategory.courseGroupArr[section];
//    
//    return temp.courseGroupTitle;
//    
//    
//    
//}



//调整标题宽度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 59;
}





//每组中的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 0;
    SCCourseGroup *temp = self.currentSource.courseGroupArr[section];
    return temp.courseArr.count;
}

//返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    SCCourseTableViewCell;
    static NSString *CellIdentifier = @"Cell";
    SCCourseTableViewCell *cell = (SCCourseTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil){
        cell = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SCCourseTableViewCell class]) owner:nil options:nil] lastObject];
        [cell.layer setBorderWidth:1];//设置边界的宽度
        [cell.layer setBorderColor:UIColorFromRGB(0xeeeeee).CGColor];
        cell.delegate=self;
        SCCourseGroup *temp=self.currentSource.courseGroupArr[indexPath.section];
        SCCourse *temp_=temp.courseArr[indexPath.row];
        //cell.textLabel.text=temp_.courseTitle;
        [cell.contentField setTitle:temp_.lesName forState:UIControlStateNormal];
        [cell.contentField setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateHighlighted];
        cell.contentField.tag =indexPath.section * 1000 + indexPath.row;
        
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell =[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}






//数据桩（调试程序用的假数据）
-(void)initData{
    self.firstCategory = [self getCourseCatagory:@"大纲"];
    self.secondCategory = [self getCourseCatagory2:@"拓展"];
    self.currentSource = self.firstCategory;
}


-(SCCourseCategory *)getCourseCatagory2:(NSString *)title{
    SCCourseCategory *temp = [[SCCourseCategory alloc]init];
    temp.courseCatagoryTitle = title;
    temp.courseCategoryId = @"UUID";
    SCCourseGroup *c1 = [self getCourseGroup:@"改变了"];
    SCCourseGroup *c2 = [self getCourseGroup:@"第二分组"];
    SCCourseGroup *c3 = [self getCourseGroup:@"第三分组"];
    SCCourseGroup *c4 = [self getCourseGroup:@"第四分组"];
    temp.courseGroupArr = @[c1,c2,c3,c4];
    return temp;
    
}



-(SCCourseGroup *)getCourseGroup:(NSString *)title{
    SCCourseGroup *temp = [[SCCourseGroup alloc]init];
    temp.courseGroupTitle = title;
    temp.courseGroupId = @"UUID";
    SCCourse *c1 = [self getCourse:@"这是视频"];
    SCCourse *c2 = [self getCourse:@"这是网页"];
    SCCourse *c3 = [self getCourse:@"第3节课"];
    SCCourse *c4 = [self getCourse:@"第4节课"];
    SCCourse *c5 = [self getCourse:@"第5节课"];
    SCCourse *c6 = [self getCourse:@"第6节课"];
    temp.courseArr = @[c1,c2,c3,c4,c5,c6];
    return temp;
    
}
-(SCCourseCategory *)getCourseCatagory:(NSString *)title{
    SCCourseCategory *temp = [[SCCourseCategory alloc]init];
    temp.courseCatagoryTitle = title;
    temp.courseCategoryId = @"UUID";
    SCCourseGroup *c1 = [self getCourseGroup:@"第一分组"];
    SCCourseGroup *c2 = [self getCourseGroup:@"第二分组"];
    SCCourseGroup *c3 = [self getCourseGroup:@"第三分组"];
    SCCourseGroup *c4 = [self getCourseGroup:@"第四分组"];
    temp.courseGroupArr = @[c1,c2,c3,c4];
    return temp;
    
}

//生成一个课程信息
-(SCCourse *)getCourse:(NSString *)title{
    SCCourse *temp = [[SCCourse alloc]init];
    temp.lesName = title;
    temp.lesId = @"UUID";
    //temp.courseUrl = @"";
    temp.courseAbstract = @"描述";
    return temp;
}

-(UIButton *)leftBtn{
    if(!_leftBtn){
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        //[_leftBtn setBackgroundColor:[UIColor greenColor]];
        [_leftBtn setTitle:@"大纲" forState:UIControlStateNormal];
        [_leftBtn setFont:[UIFont systemFontOfSize:35]];
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
        [_rightBtn setFont:[UIFont systemFontOfSize:35]];
        [_rightBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateSelected];
        //[_rightBtn setFont:[UIFont systemFontOfSize:<#(CGFloat)#>]];
        [_rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _rightBtn;
}

-(UIView *)scrollView{
    _scrollView=[[UIView alloc]initWithFrame:CGRectMake(520*WidthScale, 780*HeightScale, 200*HeightScale, 9*HeightScale)];
    [_scrollView setBackgroundColor:UIColorFromRGB(0x6fccdb)];
    return _scrollView;
}


@end




