//
//  SCRootViewController.m
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCRootViewController.h"
#import "SCAllCourseView.h"
#import "SCVideoHistoryView.h"
#import "SCMyNotesView.h"
#import "SCSearchView.h"
#import "SCLoginView.h"
//#import "SCRegViewController.h" 不实现注册功能
#import "SCSettingViewController.h"
#import "SCPlayerViewController.h"
#import "SCCourseTableViewCell.h"
#import "SCItemView.h"
typedef NS_ENUM(NSInteger,SCShowViewType) {
    SCShowViewType_MyNotes = 0,
    SCShowViewType_VideoHistory,
    SCShowViewType_AllCourse
};


@interface SCRootViewController ()<SCLoginViewDelegate,SCAllCourseViewDelegate,UITextFieldDelegate,SCCourseTableViewDelegate>

@property (nonatomic ,strong) UIButton           *loginBtn;
@property (nonatomic ,strong) UIButton           *loginBtnImage;
@property (nonatomic ,strong) UIView             *leftView;
//@property (nonatomic ,strong) UIView             *searchView;
@property (nonatomic ,strong) UITextField        *searchTextField;

@property (nonatomic ,strong) UIButton           *allCourseBtn;
@property (nonatomic ,strong) UIButton           *allCourseBtnImage;
@property (nonatomic ,strong) UIButton           *videoHistoryBtn;
@property (nonatomic ,strong) UIButton           *videoHistoryBtnImage;
@property (nonatomic ,strong) UIButton           *myNotesBtn;
@property (nonatomic ,strong) UIButton           *myNotesBtnImage;
@property (nonatomic ,strong) UIButton           *favouriteSettingBtn;
@property (nonatomic ,strong) UIButton           *favouriteSettingBtnImage;
@property (nonatomic ,strong) UIView             *scroll;


@property (nonatomic ,strong) UIView             *hubView;
@property (nonatomic ,strong) SCLoginView        *loginView;
@property (nonatomic ,strong) SCItemView         *itemView;
@property (nonatomic ,strong) SCAllCourseView    *allCourseView;
@property (nonatomic ,strong) SCVideoHistoryView *videoHistoryView;
@property (nonatomic ,strong) SCMyNotesView      *myNotesView;
@property (nonatomic ,strong) UIButton           *selectedBtn;

@property (nonatomic ,strong) UIView             *mainView;

@property (nonatomic ,strong) UIWebView          *webView;

@property CGFloat Variety;


@end

@implementation SCRootViewController{
    CGRect mainFrame;
    NSArray *allCourseArr;
    NSString *testStr;
    //这里是我的git测试
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.allCourseBtn.selected=YES;
    self.allCourseBtnImage.selected=YES;
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.loginBtnImage];
    [self.view addSubview:self.leftView];
    
    [self.leftView addSubview:self.allCourseBtn];
    [self.leftView addSubview:self.allCourseBtnImage];
    [self.leftView addSubview:self.videoHistoryBtn];
    [self.leftView addSubview:self.videoHistoryBtnImage];
    [self.leftView addSubview:self.myNotesBtn];
    [self.leftView addSubview:self.myNotesBtnImage];
    [self.leftView addSubview:self.favouriteSettingBtn];
    [self.leftView addSubview:self.favouriteSettingBtnImage];
    
    //[self.view addSubview:self.searchView];
    [self.view addSubview:self.searchTextField];
    [self.view addSubview:self.mainView];
    
    [self.mainView addSubview:self.myNotesView];//0
    [self.mainView addSubview:self.videoHistoryView];//1
    [self.mainView addSubview:self.allCourseView];//2
    
    
    self.selectedBtn = self.allCourseBtn;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.loginBtn.frame = CGRectMake(0, 0, 400*WidthScale, 200*HeightScale);
    self.loginBtnImage.frame=CGRectMake(51*WidthScale, 48*HeightScale, 94*WidthScale, 94*WidthScale);
    self.leftView.frame = CGRectMake(0, self.loginBtn.bottom, self.loginBtn.width, self.view.height-self.loginBtn.height);
    self.allCourseBtn.frame=CGRectMake(0, 50*HeightScale, 400*WidthScale, 150*HeightScale);
    self.allCourseBtnImage.frame=CGRectMake(51*WidthScale, 50*HeightScale+44*HeightScale, 64*WidthScale, 50*HeightScale);
    self.videoHistoryBtn.frame=CGRectMake(0, 200*HeightScale, 400*WidthScale, 150*HeightScale);
    self.videoHistoryBtnImage.frame=CGRectMake(51*WidthScale, 200*HeightScale+35*HeightScale, 64*WidthScale, 64*HeightScale);
    self.myNotesBtn.frame=CGRectMake(0, 350*HeightScale, 400*WidthScale, 150*HeightScale);
    self.myNotesBtnImage.frame=CGRectMake(51*WidthScale, 350*HeightScale+35*HeightScale, 64*WidthScale, 64*HeightScale);
    self.favouriteSettingBtn.frame = CGRectMake(0, self.leftView.height-150*HeightScale,400*WidthScale, 150*HeightScale);
    self.favouriteSettingBtnImage.frame = CGRectMake(51*WidthScale, self.leftView.height-150*HeightScale+35*HeightScale,64*WidthScale, 64*HeightScale);
    //self.searchView.frame = CGRectMake(1224*WidthScale, 56*HeightScale, 718*WidthScale, 100*HeightScale);
    self.searchTextField.frame= CGRectMake(1234*WidthScale, 56*HeightScale, 708*WidthScale, 100*HeightScale);
    
    //中央视图尺寸
    mainFrame = CGRectMake(self.leftView.right, self.leftView.top, self.view.width-self.leftView.width, self.leftView.height);
    self.mainView.frame = mainFrame;
    
    self.allCourseView.frame = CGRectMake(0, 0, mainFrame.size.width, mainFrame.size.height);
    self.myNotesView.frame = self.allCourseView.frame;
    self.videoHistoryView.frame = self.allCourseView.frame;
}


-(void)loadData{
    //调用接口
    //获得数据
    allCourseArr = @[@"1",@"2",@"3"];
    
    
}

#pragma mark - SCLoginViewDelegate
//-(void)regBtnDidClick:(UIButton *)sender{
//
//    SCRegViewController *regVC = [[SCRegViewController alloc]init];
//    [self presentViewController:regVC animated:YES completion:nil];
//}

#pragma mark - SCAllCourseViewDelegate
-(IBAction)contendClick:(NSInteger)secIndex AndRowIndex:(NSInteger)rouIndex{
    [self.view addSubview:self.hubView];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(100, 100, 1000, 800)];
    
    
    
    [self.view addSubview:self.webView];
    
    
    
    
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    
    
    
    //运行一下，百度页面就出来了
    
    
    
    [self.webView loadRequest:request];

}
-(IBAction)imageClick{
    [self.view addSubview:self.hubView];
    [self.view addSubview:self.itemView];
}
-(void)startBtnDidClick{
    
    SCPlayerViewController *playVC = [[SCPlayerViewController alloc]init];
    playVC.currentVideoInfo = allCourseArr[5];
    [self.navigationController pushViewController:playVC animated:YES];
    
}

//-(IBAction)contendFieldDidClick{
//    SCPlayerViewController *playVC = [[SCPlayerViewController alloc]init];
//    playVC.currentVideoInfo = allCourseArr[5];
//    [self.navigationController pushViewController:playVC animated:YES];
//
//}
//-(IBAction)imageBtnDidClick{
//    SCPlayerViewController *playVC = [[SCPlayerViewController alloc]init];
//    playVC.currentVideoInfo = allCourseArr[5];
//    [self.navigationController pushViewController:playVC animated:YES];
//
//}
#pragma mark - 私有方法
-(void)move{
    //CGFloat ScaleHeight=[self getScaleHeight];
    [UIView animateWithDuration:0.5 animations:^{
        self.scroll.transform=CGAffineTransformMakeTranslation(0,self.Variety);
    }];
}
-(void)viewmove:(CGFloat)variety andUIView:(UIView *)scrollView{
    [UIView animateWithDuration:0.5 animations:^{
        scrollView.transform=CGAffineTransformMakeTranslation(variety,0);
    }];
}

#pragma mark - 响应事件



-(void)allCourseBtnClick:(UIButton *)sender{
    self.allCourseBtn.selected=YES;
    self.allCourseBtnImage.selected=YES;
    self.videoHistoryBtn.selected=NO;
    self.videoHistoryBtnImage.selected=NO;
    self.myNotesBtn.selected=NO;
    self.myNotesBtnImage.selected=NO;
    self.favouriteSettingBtn.selected=NO;
    self.favouriteSettingBtnImage.selected=NO;
    
    [self.scroll setHidden:NO];
    if (!_scroll) {
        [self scroll:self.allCourseBtn.frame.origin.y];
        [self.leftView addSubview:self.scroll];
    }
    else{
        CGFloat a=self.allCourseBtn.frame.origin.y+self.Variety;
        CGFloat b=self.scroll.frame.origin.y;
        
        self.Variety=a-b;
        [self move];
    }
    
    [self changeViewFrom:self.selectedBtn.tag to:sender.tag];
    self.selectedBtn.selected=NO;
    sender.selected=YES;
    
    
    
    NSInteger tempTag = sender.tag;
    sender.tag = self.selectedBtn.tag;
    
    
    self.selectedBtn.tag = tempTag;
    
    self.selectedBtn = sender;
}


-(void)historyBtnClick:(UIButton *)sender{
    self.allCourseBtn.selected=NO;
    self.allCourseBtnImage.selected=NO;
    self.videoHistoryBtn.selected=YES;
    self.videoHistoryBtnImage.selected=YES;
    self.myNotesBtn.selected=NO;
    self.myNotesBtnImage.selected=NO;
    self.favouriteSettingBtn.selected=NO;
    self.favouriteSettingBtnImage.selected=NO;
    
    [self.scroll setHidden:NO];
    if (!_scroll) {
        [self scroll:self.videoHistoryBtn.frame.origin.y];
        [self.leftView addSubview:self.scroll];
    }
    else{
        CGFloat a=self.videoHistoryBtn.frame.origin.y+self.Variety;
        CGFloat b=self.scroll.frame.origin.y;
        
        self.Variety=a-b;
        [self move];
    }
    
    
    [self changeViewFrom:self.selectedBtn.tag to:sender.tag];
    self.selectedBtn.selected=NO;
    sender.selected=YES;
    
    
    
    NSInteger tempTag = sender.tag;
    sender.tag = self.selectedBtn.tag;
    
    
    self.selectedBtn.tag = tempTag;
    
    self.selectedBtn = sender;
    
}
-(void)noteBtnClick:(UIButton *)sender{
    self.allCourseBtn.selected=NO;
    self.allCourseBtnImage.selected=NO;
    self.videoHistoryBtn.selected=NO;
    self.videoHistoryBtnImage.selected=NO;
    self.myNotesBtn.selected=YES;
    self.myNotesBtnImage.selected=YES;
    self.favouriteSettingBtn.selected=NO;
    self.favouriteSettingBtnImage.selected=NO;
    
    [self.scroll setHidden:NO];
    if (!_scroll) {
        [self scroll:self.myNotesBtn.frame.origin.y];
        [self.leftView addSubview:self.scroll];
    }
    else{
        CGFloat a=self.myNotesBtn.frame.origin.y+self.Variety;
        CGFloat b=self.scroll.frame.origin.y;
        
        self.Variety=a-b;
        [self move];
    }
    
    
    [self changeViewFrom:self.selectedBtn.tag to:sender.tag];
    self.selectedBtn.selected=NO;
    sender.selected=YES;
    
    
    
    NSInteger tempTag = sender.tag;
    sender.tag = self.selectedBtn.tag;
    
    
    self.selectedBtn.tag = tempTag;
    
    self.selectedBtn = sender;
    
    
}


//-(void)favouriteBtnClick{
//    self.allCourseBtn.selected=NO;
//    self.allCourseBtnImage.selected=NO;
//    self.videoHistoryBtn.selected=NO;
//    self.videoHistoryBtnImage.selected=NO;
//    self.myNotesBtn.selected=NO;
//    self.myNotesBtnImage.selected=NO;
//    self.favouriteSettingBtn.selected=YES;
//    self.favouriteSettingBtnImage.selected=YES;
//    [self.scroll setHidden:NO];
//    if (!_scroll) {
//        [self scroll:self.favouriteSettingBtn.frame.origin.y];
//        [self.leftView addSubview:self.scroll];
//    }
//    else{
//        CGFloat a=self.favouriteSettingBtn.frame.origin.y+self.Variety;
//        CGFloat b=self.scroll.frame.origin.y;
//
//        self.Variety=a-b;
//        [self move];
//    }
//
//}
-(void)loginBtnClick{
    [self.view addSubview:self.hubView];
    [self.view addSubview:self.loginView];
    //    self.allCourseBtn.selected=NO;
    //    self.allCourseBtnImage.selected=NO;
    //    self.videoHistoryBtn.selected=NO;
    //    self.videoHistoryBtnImage.selected=NO;
    //    self.myNotesBtn.selected=NO;
    //    self.myNotesBtnImage.selected=NO;
    //    self.favouriteSettingBtn.selected=NO;
    //    self.favouriteSettingBtnImage.selected=NO;
    //    [self.scroll setHidden:YES];
}

-(void)hideLoginView{
    [self.loginView removeFromSuperview];
    self.loginView = nil;
    [self.hubView removeFromSuperview];
    self.hubView = nil;
    [self.itemView removeFromSuperview];
    self.itemView = nil;
    [self.webView removeFromSuperview];
    self.webView=nil;

}

//-(void)leftBtnClick:(UIButton *)sender{
//    
//    [self changeViewFrom:self.selectedBtn.tag to:sender.tag];
//    self.selectedBtn.selected=NO;
//    sender.selected=YES;
//    
//    
//    
//    NSInteger tempTag = sender.tag;
//    sender.tag = self.selectedBtn.tag;
//    
//    
//    self.selectedBtn.tag = tempTag;
//    
//    self.selectedBtn = sender;
//}

-(void)changeViewFrom:(SCShowViewType)fromTndex to:(SCShowViewType)toIndex{
    
    [self.mainView exchangeSubviewAtIndex:fromTndex withSubviewAtIndex:toIndex];
}

-(void)settingBtnClick{
    //    self.favouriteSettingBtn.selected=YES;
    //    self.favouriteSettingBtnImage.selected=YES;
    
    SCSettingViewController *setVC = [[SCSettingViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}

#pragma mark - getters


-(UIView *)scroll:(CGFloat)y{
    _scroll=[[UIView alloc]initWithFrame:CGRectMake(0, y, 9*HeightScale, 150*HeightScale)];
    [_scroll setBackgroundColor:UIColorFromRGB(0x6fccdb)];
    return _scroll;
}



-(UIButton *)loginBtn{
    if (!_loginBtn){
        _loginBtn = [[UIButton alloc]init];
        _loginBtn.backgroundColor = UIThemeColor;
        [_loginBtn setTitle:@"        请登录" forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:45*WidthScale];
        [_loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [_loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}




-(UIButton *)loginBtnImage
{
    if(!_loginBtnImage)
    {
        _loginBtnImage=[UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtnImage.backgroundColor=UIColorFromRGB(0x6fccdb);
        UIImage *UserImage=[UIImage imageNamed:@"SC_user"];
        [_loginBtnImage setImage:UserImage forState:UIControlStateNormal];
        [_loginBtnImage addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _loginBtnImage;
}




-(UIView *)leftView{
    if (!_leftView){
        _leftView = [[UIView alloc]init];
        _leftView.backgroundColor = [UIColor whiteColor];
        
        
        //[_leftView.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
        
        //[_leftView.layer setCornerRadius:10];
        
        [_leftView.layer setBorderWidth:1];//设置边界的宽度
        
        
        
        //设置按钮的边界颜色
        
        [_leftView.layer setBorderColor:UIColorFromRGB(0xeeeeee).CGColor];

        
    }
    return _leftView;
}

//-(UIView *)searchView{
//    if (!_searchView){
//        _searchView = [[UIView alloc]init];
//        _searchView.backgroundColor = [UIColor whiteColor];
//        _searchView.layer.masksToBounds = YES;
//        _searchView.layer.cornerRadius = 35;
//        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"SC_magnifier"]];
//        imageView.frame=CGRectMake(65*WidthScale, 20*HeightScale, 64*WidthScale, 64*HeightScale);
//        [_searchView addSubview:imageView];
//
//    }
//    return _searchView;
//}
-(UITextField *)searchTextField{
    if(!_searchTextField){
        _searchTextField=[[UITextField alloc]init];
        //_SearchTextField=[[UITextField alloc]init];
        [_searchTextField setBackgroundColor:[UIColor whiteColor]];
        _searchTextField.placeholder = @"请输入搜索内容";
        _searchTextField.font = [UIFont systemFontOfSize:45*WidthScale];
        _searchTextField.layer.masksToBounds = YES;
        _searchTextField.layer.cornerRadius = 35;
        _searchTextField.textAlignment = UITextAlignmentCenter ;
        _searchTextField.rightView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 125, 100)];
        _searchTextField.rightView.backgroundColor=UIColorFromRGB(0x6fccdb);
        _searchTextField.rightViewMode=UITextFieldViewModeAlways;
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"搜索白色"]];
        imageView.frame=CGRectMake(68*WidthScale, 45*HeightScale, 64*WidthScale, 64*HeightScale);
        [_searchTextField.rightView addSubview:imageView];
        _searchTextField.delegate=self;
        
    }
    return _searchTextField;
    
}

-(UIButton *)allCourseBtn{
    if (!_allCourseBtn){
        _allCourseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allCourseBtn.tag = SCShowViewType_AllCourse;
        [_allCourseBtn setTitle:@"      所有课程" forState:UIControlStateNormal];
        _allCourseBtn.titleLabel.font = [UIFont systemFontOfSize:45*WidthScale];
        [_allCourseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_allCourseBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateHighlighted];
        [_allCourseBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateSelected];
        [self scroll:self.allCourseBtn.frame.origin.y+45*HeightScale];
        [self.leftView addSubview:self.scroll];
        [_allCourseBtn addTarget:self action:@selector(allCourseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allCourseBtn;
}

-(UIButton *)allCourseBtnImage{
    if(!_allCourseBtnImage)
    {
        _allCourseBtnImage=[UIButton buttonWithType:UIButtonTypeCustom];
        _allCourseBtnImage.tag = SCShowViewType_AllCourse;
        [_allCourseBtnImage setImage:[UIImage imageNamed:@"SC_video"] forState:UIControlStateNormal];
        [_allCourseBtnImage setImage:[UIImage imageNamed:@"SC_video2"] forState:UIControlStateSelected];
        [_allCourseBtnImage addTarget:self action:@selector(allCourseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allCourseBtnImage;
    
}

-(UIButton *)videoHistoryBtn{
    if (!_videoHistoryBtn){
        _videoHistoryBtn = [[UIButton alloc]init];
        _videoHistoryBtn.tag = SCShowViewType_VideoHistory;
        [_videoHistoryBtn setTitle:@"      观看历史" forState:UIControlStateNormal];
        [_videoHistoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_videoHistoryBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateHighlighted];
        [_videoHistoryBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateSelected];
        _videoHistoryBtn.titleLabel.font = [UIFont systemFontOfSize:45*WidthScale];
        [_videoHistoryBtn addTarget:self action:@selector(historyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoHistoryBtn;
}
-(UIButton *)videoHistoryBtnImage{
    if(!_videoHistoryBtnImage)
    {
        _videoHistoryBtnImage.tag = SCShowViewType_VideoHistory;
        _videoHistoryBtnImage=[UIButton buttonWithType:UIButtonTypeCustom];
        [_videoHistoryBtnImage setImage:[UIImage imageNamed:@"SC_clock"] forState:UIControlStateNormal];
        [_videoHistoryBtnImage setImage:[UIImage imageNamed:@"SC_clock2"] forState:UIControlStateSelected];
        [_videoHistoryBtnImage addTarget:self action:@selector(historyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _videoHistoryBtnImage;
}

-(UIButton *)myNotesBtn{
    if (!_myNotesBtn){
        _myNotesBtn = [[UIButton alloc]init];
        _myNotesBtn.tag = SCShowViewType_MyNotes;
        [_myNotesBtn setTitle:@"      我的备注" forState:UIControlStateNormal];
        [_myNotesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_myNotesBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateHighlighted];
        [_myNotesBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateSelected];
        _myNotesBtn.titleLabel.font=[UIFont systemFontOfSize:45*WidthScale];
        [_myNotesBtn addTarget:self action:@selector(noteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myNotesBtn;
}
-(UIButton *)myNotesBtnImage{
    if(!_myNotesBtnImage)
    {
        _myNotesBtnImage=[UIButton buttonWithType:UIButtonTypeCustom];
        _myNotesBtnImage.tag = SCShowViewType_MyNotes;
        [_myNotesBtnImage setImage:[UIImage imageNamed:@"SC_note"] forState:UIControlStateNormal];
        [_myNotesBtnImage setImage:[UIImage imageNamed:@"SC_note2"] forState:UIControlStateSelected];
        [_myNotesBtnImage addTarget:self action:@selector(noteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myNotesBtnImage;
}
-(UIButton *)favouriteSettingBtn{
    if (!_favouriteSettingBtn){
        _favouriteSettingBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_favouriteSettingBtn setTitle:@"      " forState:UIControlStateNormal];
        [_favouriteSettingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_favouriteSettingBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateHighlighted];
        [_favouriteSettingBtn setTitleColor:UIColorFromRGB(0x6fccdb) forState:UIControlStateSelected];
        _favouriteSettingBtn.titleLabel.font=[UIFont systemFontOfSize:45*WidthScale];
        [_favouriteSettingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favouriteSettingBtn;
}

-(UIButton *)favouriteSettingBtnImage{
    if(!_favouriteSettingBtnImage)
    {
        
        _favouriteSettingBtnImage=[UIButton buttonWithType:UIButtonTypeCustom];
        [_favouriteSettingBtnImage setImage:[UIImage imageNamed:@"SC_settings"] forState:UIControlStateNormal];
        [_favouriteSettingBtnImage setImage:[UIImage imageNamed:@"SC_settings2"] forState:UIControlStateHighlighted];
        [_favouriteSettingBtnImage addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favouriteSettingBtnImage;
}


-(UIView *)hubView{
    if (!_hubView){
        _hubView = [[UIView alloc]initWithFrame:self.view.bounds];
        _hubView.backgroundColor = [UIColor blackColor];
        _hubView.alpha = 0.3f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideLoginView)];
        [_hubView addGestureRecognizer:tap];
    }
    return _hubView;
}
-(SCItemView *)itemView{
    if (!_itemView){
        _itemView = [[SCItemView alloc]init];
        _itemView.backgroundColor=[UIColor whiteColor];
        _itemView.frame = CGRectMake(0, 0, 320, 240);
        _itemView.center = self.view.center;
        //_loginView.delegate = self;
    }
    return _itemView;
}
-(SCLoginView *)loginView{
    if (!_loginView){
        _loginView = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([SCLoginView class]) owner:nil options:nil].lastObject;
        _loginView.frame = CGRectMake(0, 0, 889*WidthScale, 647*HeightScale);
        _loginView.center = self.view.center;
        _loginView.delegate = self;
    }
    return _loginView;
}

-(UIView *)mainView{
    if (!_mainView){
        _mainView = [[UIView alloc]init];
        _mainView.backgroundColor = [UIColor orangeColor];
    }
    return _mainView;
}

-(SCAllCourseView *)allCourseView{
    if (!_allCourseView){
        _allCourseView = [[SCAllCourseView alloc]init];
        _allCourseView.delegate = self;
    }
    return _allCourseView;
}

-(SCVideoHistoryView *)videoHistoryView{
    if (!_videoHistoryView){
        _videoHistoryView = [[SCVideoHistoryView alloc]init];
    }
    return _videoHistoryView;
}

-(SCMyNotesView *)myNotesView{
    if (!_myNotesView){
        _myNotesView = [[SCMyNotesView alloc]init];
    }
    return _myNotesView;
}

@end
