//
//  SCPlayerViewController.m
//  SuperCourse
//
//  Created by Develop on 16/1/24.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCPlayerViewController.h"
#import "SCRightView.h"
#import "SCVIdeoInfo.h"
#import "SZYVideoManager.h"
#import "SCPointView.h"
#import "SCVideoInfoModel.h"
#import "SCVideoLinkMode.h"
#import "SCVideoSubTitleMode.h"

@interface SCPlayerViewController ()<SCPointViewDelegate>{
    BOOL isAnimating; // 正在动画
}

@property (nonatomic, strong) SCRightView *rightView;
@property (nonatomic, strong) IBOutlet UIView *container;
@property (nonatomic, strong) IBOutlet UIView *bottomView;
@property (nonatomic, strong) IBOutlet UIButton *returnBtn;
@property (nonatomic, strong) IBOutlet UIButton *playBtn;
@property (nonatomic, strong) IBOutlet UIButton *pauseBtn;
@property (nonatomic, strong) IBOutlet UIButton *resumeBtn;
@property (nonatomic, strong) IBOutlet UIButton *speedBtn;
@property (nonatomic, strong) IBOutlet UIButton *rightViewBtn;
@property (nonatomic, strong) IBOutlet UIButton *lockBtn;
@property (nonatomic, strong) IBOutlet UILabel *nowCourse;
@property (nonatomic, strong) IBOutlet UIButton *nowPoint;
@property (nonatomic, strong) IBOutlet UILabel *timeLable;
@property (nonatomic, strong) UITextField *insertNote;
@property (nonatomic, strong) IBOutlet UIView *startBtnView;
@property (nonatomic, strong) IBOutlet UIButton *startBtn;
@property (nonatomic, strong) IBOutlet UIButton *addPointBtn;
@property (nonatomic, strong) IBOutlet UIButton *writeNoteBtn;
@property (nonatomic, strong) IBOutlet UIButton *writeCodeBtn;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@property (nonatomic, strong) SZYVideoManager *videoManager;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) IBOutlet UIView *lockView;
@property (nonatomic, strong) IBOutlet UIView *writeNoteView;
@property (nonatomic, strong) IBOutlet UILabel *isDownloadLabel;
@property (nonatomic, strong) SCPointView *pointView;

@property (nonatomic, assign) CGFloat currentTime;

@property (nonatomic, strong) UIPanGestureRecognizer *pan;
@property (nonatomic, strong) IBOutlet UIButton *nextPlayerPlayBtn;


@property (nonatomic, strong) SCVideoInfoModel *videoInfo;

@end

@implementation SCPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isAnimating = NO; //防止重复的动画
    [self loadDataStub]; //加载数据桩
    [self addAllControl]; //加载界面上的所有控件
    [self initVideoManager]; //初始化视频播放器
}

-(void)initVideoManager{

    NSURL *murl=[NSURL fileURLWithPath:self.videoInfo.videoUrl];
    [[SZYVideoManager defaultManager] setUpRemoteVideoPlayerWithContentURL:murl view:self.container];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoLoadDone:) name:VideoLoadDoneNotification object:nil];
    [self.container addSubview:self.startBtnView];
    [self.view addSubview:self.writeNoteView];
}

//加载数据桩
-(void)loadDataStub{
    if (!_videoInfo) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [paths objectAtIndex:0];
        NSString *url=[docDir stringByAppendingPathComponent:@"load2.mp4"];
        NSMutableArray *subTitleArr = [self getSubTitleData];
        NSMutableArray *linkArr = [self getLinkData];
        self.videoInfo = [[SCVideoInfoModel alloc]initWithVideoUrl:url AndTitle:@"这是一个测试数据的视频标题" AndFileSize:@"123M" AndSubTitles:subTitleArr AndLinks:linkArr];
    }
}

//创建子标题数据桩

-(NSMutableArray *)getSubTitleData{
    float a = 10.0 ,b=17.0 ,c=24.0, d=27.0;
    NSNumber *arr = @(a);
    NSNumber *brr = @(b);
    NSNumber *crr = @(c);
    NSNumber *drr = @(d);
    NSArray *dataArr = @[@"iOS的历史来源和发展历程",@"iOS的系统特性",@"局域网和互联网",@"编程环境的搭建"];
    NSArray *timeArr = @[arr,brr,crr,drr];

    NSMutableArray *subTitleArr = [[NSMutableArray alloc]init];
    SCVideoSubTitleMode *m0 = [[SCVideoSubTitleMode alloc] initWithTitle:dataArr[0] AndBeginTime:[timeArr[0] floatValue]];
    [subTitleArr insertObject:m0 atIndex:0];
    SCVideoSubTitleMode *m1 = [[SCVideoSubTitleMode alloc] initWithTitle:dataArr[1] AndBeginTime:[timeArr[1] floatValue]];
    [subTitleArr insertObject:m1 atIndex:1];
    SCVideoSubTitleMode *m2 = [[SCVideoSubTitleMode alloc] initWithTitle:dataArr[2] AndBeginTime:[timeArr[2] floatValue]];
    [subTitleArr insertObject:m2 atIndex:2];
    SCVideoSubTitleMode *m3 = [[SCVideoSubTitleMode alloc] initWithTitle:dataArr[3] AndBeginTime:[timeArr[3] floatValue]];
    [subTitleArr insertObject:m3 atIndex:3];
    
    return subTitleArr;
    
}

-(NSMutableArray *)getLinkData{

    float a = 35.0 , b = 42.0 , c = 47.0 , d = 58.0 ,e = 77.0, f = 88.0;
    NSNumber *arr = @(a);
    NSNumber *brr = @(b);
    NSNumber *crr = @(c);
    NSNumber *drr = @(d);
    NSNumber *err = @(e);
    NSNumber *frr = @(f);
    NSArray *timeArr = @[arr,brr,crr,drr,err,frr];
    NSArray *dataArr = @[@"软件编程",@"互联网和局域网",@"类的定义",@"xcode的使用",@"系统",@"视频"];
    NSArray *typeArr = @[@"视频",@"网页",@"网页",@"视频",@"视频",@"网页"];
    NSArray *videoIdArr = @[@"10",@"",@"",@"20",@"30",@""];
    NSArray *webUrlArr = @[@"",@"url1",@"url2",@"",@"",@"url3"];
    NSMutableArray *linkArr = [[NSMutableArray alloc]init];
    for (int i = 0 ; i<dataArr.count; i++) {
        SCVideoLinkMode *m = [[SCVideoLinkMode alloc]initWithTitle:dataArr[i] AndBeginTime:[timeArr[i] floatValue] AndTargetType:typeArr[i] AndLessonId:videoIdArr[i] AndWebUrl:webUrlArr[i]];
        [linkArr insertObject:m atIndex:i];
    }
    
    
    return linkArr;
}


-(void)addAllControl{
    [self.view setBackgroundColor:UIBackgroundColor];
    [self.view addSubview:self.nowCourse];
    [self.view addSubview:self.nowPoint];
    [self.view addSubview:self.isDownloadLabel];
    [self.view addSubview:self.container];
    [self.view addSubview:self.rightView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.returnBtn];
    [self.bottomView addSubview:self.pauseBtn];
    [self.bottomView addSubview:self.speedBtn];
    [self.bottomView addSubview:self.rightViewBtn];
    [self.bottomView addSubview:self.lockBtn];
    [self.bottomView addSubview:self.timeLable];
    



}

-(void)playerPlayFinished{

    [self.pauseBtn removeFromSuperview];
    [self.bottomView addSubview:self.nextPlayerPlayBtn];
    
}


-(void)showCurrentTime:(NSTimeInterval)elapsedTime  AndplayableDuration:(NSTimeInterval)playableDuration{
    
    CGFloat currentTime = MIN(elapsedTime, playableDuration);
    
    int hour = (int)(currentTime/3600);
    int minute = (int)(currentTime - hour*3600)/60;
    int second = currentTime - hour*3600 - minute*60;
    int allHour = (int)(playableDuration/3600);
    int allMinute = (int)(playableDuration - allHour*3600)/60;
    int allSecond = playableDuration - allHour*3600 - allMinute*60;
    NSString *time = [NSString stringWithFormat:@"%02d:%02d:%02d/%02d:%02d:%02d",hour,minute,second,allHour,allMinute,allSecond];
    self.timeLable.text = time;
    if (hour*2600+minute*60+second == allHour*3600+allMinute*60+allSecond) {
        [self playerPlayFinished];
    }
    
}

-(void)turnToTime:(UIButton *)sender{
    
    [[SZYVideoManager defaultManager] moveToSecond:(NSTimeInterval)sender.superview.tag];
}


#pragma mark - 点击事件

-(void)backBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:VideoLoadDoneNotification object:nil];

}
-(void)videoLoadDone:(NSNotification *)noti{
    

    [[SZYVideoManager defaultManager] startWithHandler:^(NSTimeInterval elapsedTime, NSTimeInterval timeRemaining, NSTimeInterval playableDuration, BOOL finished) {
        [self showCurrentTime:elapsedTime AndplayableDuration:playableDuration];
        self.currentTime = elapsedTime;
        if (self.rightView.pointView) {
            [self.rightView.pointView changeSubTitleViewWithTime:elapsedTime];
        }
        [self.rightView.tagList changeBtnLookingWithTime:elapsedTime];
        
    }];
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(0 , self.startBtnView.height-60, self.startBtnView.width, 50)];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    _slider.minimumValue = 0;
    _slider.maximumValue = [noti.object floatValue];
    [self.startBtnView addSubview:_slider];
}

-(void)nextPlayerPlayBtnClick:(UIButton *)sender{

    
}

-(void)playBtnClick:(UIButton *)sender{
    if (!isAnimating) {
        [[SZYVideoManager defaultManager] resume];
        [self.playBtn removeFromSuperview];
        [self.bottomView addSubview:self.pauseBtn];
        self.startBtnView.hidden = YES;
        [self transformRecover];
    }
}


-(void)pauseBtnClick{

    [[SZYVideoManager defaultManager] pause];
//    [self.speedBtn setImage:[UIImage imageNamed:@"2X"] forState:UIControlStateNormal];
    [self.pauseBtn removeFromSuperview];
    [self.bottomView addSubview:self.playBtn];
    self.startBtnView.hidden = NO;
    [self transformAnimated];
}



-(void)sliderValueChanged:(UISlider *)sender{
    
    [[SZYVideoManager defaultManager] moveToSecond:sender.value];
    [[SZYVideoManager defaultManager] pause];
    [self.bottomView addSubview:self.playBtn];
    [self.pauseBtn removeFromSuperview];
}

-(CGFloat)currentRate{
    
    return [[SZYVideoManager defaultManager]currentRate];
    
}

-(void)resume{

    [[SZYVideoManager defaultManager] resume];
    [self.bottomView addSubview:self.pauseBtn];
    [self.playBtn removeFromSuperview];
    self.startBtnView.hidden = YES;
    [self transformRecover];

}

-(void)speedBtnClick:(CGFloat)rate{
    
    rate = [self currentRate];
    if (rate == 1.0) {
        [[SZYVideoManager defaultManager]setCurrentRate:2.0];
        [self.speedBtn setImage:[UIImage imageNamed:@"5X"] forState:UIControlStateNormal];
        [self resume];
    }else if (rate == 2.0){
        [[SZYVideoManager defaultManager]setCurrentRate:5.0];
        [self.speedBtn setImage:[UIImage imageNamed:@"10X"] forState:UIControlStateNormal];
        [self resume];
    }else if (rate == 5.0){
        [[SZYVideoManager defaultManager]setCurrentRate:10.0];
        [self.speedBtn setImage:[UIImage imageNamed:@"20X"] forState:UIControlStateNormal];
        [self resume];
    }else if (rate == 10.0){
        [[SZYVideoManager defaultManager]setCurrentRate:20.0];
        [self.speedBtn setImage:[UIImage imageNamed:@"1X"] forState:UIControlStateNormal];
        [self resume];
    }else {
        [[SZYVideoManager defaultManager]setCurrentRate:1.0];
        [self.speedBtn setImage:[UIImage imageNamed:@"2X"] forState:UIControlStateNormal];
        [self resume];
    }
    
}

-(void)rightViewBtnClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.rightView.transform = sender.selected ? CGAffineTransformMakeTranslation(-659*WidthScale, 0) : CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [self.rightViewBtn setImage:[UIImage imageNamed:@"边栏"] forState:UIControlStateSelected];
    }];
}


-(void)lockBtnClick{
    
    self.lockView.hidden = NO;
    self.lockBtn.selected = YES;
   
}

-(void)unLockBtnClick{

    self.lockView.hidden = YES;
    self.lockBtn.selected = NO;
}


-(void)startBtnClick{

    if (!isAnimating) {
        self.startBtnView.hidden = YES;
        [self transformRecover];
        [[SZYVideoManager defaultManager] resume];
        [self.bottomView addSubview:self.pauseBtn];
        [self.playBtn removeFromSuperview];
    }
}

-(void)writeNoteBtnClick{

    self.startBtnView.hidden = YES;
    [self transformRecover];
}

-(void)writeCodeBtnClick{

    self.startBtnView.hidden = YES;
    [self transformRecover];
}

-(void)addPointBtnClick{

    self.startBtnView.hidden = YES;
    [self transformRecover];
    self.writeNoteView.hidden = NO;
    
}

-(void)addPoint{
    
    self.writeNoteView.hidden = YES;
    [[SZYVideoManager defaultManager] resume];
    [self.bottomView addSubview:self.pauseBtn];
    [self.playBtn removeFromSuperview];
}

- (void)tapBtn:(UIPanGestureRecognizer *) recognizer{

    if (!isAnimating) {
        BOOL _hidden;
        _hidden = self.startBtnView.hidden;
        
        if ([self.pauseBtn isDescendantOfView:self.bottomView]) {
            self.startBtnView.hidden = NO;
            [self transformAnimated];
            [[SZYVideoManager defaultManager] pause];
//            [self.speedBtn setImage:[UIImage imageNamed:@"2X"] forState:UIControlStateNormal];
            [self.bottomView addSubview:self.playBtn];
            [self.pauseBtn removeFromSuperview];
            
        }else{
            
            if (_hidden == YES) {
                [[SZYVideoManager defaultManager] resume];
                [self.bottomView addSubview:self.pauseBtn];
                [self.playBtn removeFromSuperview];
            }else{
                [[SZYVideoManager defaultManager] resume];
                [self.bottomView addSubview:self.pauseBtn];
                [self.playBtn removeFromSuperview];
                self.startBtnView.hidden = YES;
                [self transformRecover];
                
            }
        }

    }
    
    
}


-(void)transformAnimated{

    isAnimating = YES;
    
    [UIView animateWithDuration:0.2 animations:^{
       
        self.addPointBtn.alpha = 1;
 
        
        self.addPointBtn.frame = CGRectMake(932*WidthScale*2048/1614, 438*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563);

        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.writeCodeBtn.alpha = 1;
            self.writeNoteBtn.alpha = 1;

            self.writeNoteBtn.frame = CGRectMake(901*WidthScale*2048/1614, 568*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563);
            self.writeCodeBtn.frame = CGRectMake(901*WidthScale*2048/1614, 308*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563);
            self.writeCodeBtn.transform = CGAffineTransformMakeRotation(-0.5);
            self.writeNoteBtn.transform = CGAffineTransformMakeRotation(0.5);
        }completion:^(BOOL finished) {
            isAnimating = NO;
        } ];
    }];
}

-(void)transformRecover{

        
        self.addPointBtn.alpha = 0;
        self.writeCodeBtn.alpha = 0;
        self.writeNoteBtn.alpha = 0;
        self.addPointBtn.frame=CGRectMake(668*WidthScale*2048/1614, 438*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563);
        self.writeCodeBtn.frame=CGRectMake(932*WidthScale*2048/1614, 438*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563);
        self.writeNoteBtn.frame=CGRectMake(932*WidthScale*2048/1614, 438*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563);
    

        self.writeCodeBtn.transform = CGAffineTransformMakeRotation(0);
        self.writeNoteBtn.transform = CGAffineTransformMakeRotation(0);
    

    
}

-(void)panToTime:(UIPanGestureRecognizer*) recognizer{

    CGPoint beginStatePoint;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        beginStatePoint = [recognizer locationInView:self.container];
    }
    CGFloat beginStateX = beginStatePoint.x;
    CGFloat endStateX;
    CGFloat endStateY;
    CGPoint endStatePoint = [recognizer locationInView:self.container];
    endStateX = endStatePoint.x;
    endStateY = endStatePoint.y;
    CGFloat moveDistance = endStateX - beginStateX;
    if (endStateY >= 0 && endStateY < self.container.height/3) {
        CGFloat turnToSecond = self.currentTime+360*moveDistance/self.container.width ;
        [[SZYVideoManager defaultManager] moveToSecond:turnToSecond];
//        self.currentTime = turnToSecond;
    }else if (endStateY >= self.container.height/3 && endStateY < self.container.height*2/3){
        CGFloat turnToSecond = self.currentTime+(60*moveDistance/self.container.width) ;
        [[SZYVideoManager defaultManager] moveToSecond:turnToSecond];
//        self.currentTime = turnToSecond;
    }else if (endStateY >= self.container.height*2/3 && endStateY < self.container.height){
        CGFloat turnToSecond = self.currentTime+10*moveDistance/self.container.width ;
        [[SZYVideoManager defaultManager] moveToSecond:turnToSecond];
//        self.currentTime = turnToSecond;
    }
}


#pragma mark - getters

-(SCRightView *)rightView{
    
    if (!_rightView) {
        _rightView = [[SCRightView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, 659*WidthScale, 1382*HeightScale)];
        _rightView.pointViewDelegate = self;
        _rightView.subTitleArr = self.videoInfo.videoSubTitles;
//        _rightView.linkArr = self.videoInfo.videoLinks;
        [_rightView.tagList setTags:self.videoInfo.videoLinks];
    }
    return _rightView;
}

-(UIView *)container{
    
    if (!_container) {
        _container = [[UIView alloc]init];
        [_container setBackgroundColor:UIThemeColor];
        _container.frame = CGRectMake(0, 100*HeightScale, 2048*WidthScale, 1280*HeightScale);
        [self.container addGestureRecognizer:self.tap];
        [self.container addGestureRecognizer:self.pan];
    }
    return _container;
}

-(UIView *)bottomView{
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.frame = CGRectMake(0, 1382*HeightScale, UIScreenWidth, 154*WidthScale);
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
    }
    return _bottomView;
}

-(UIButton *)returnBtn{
    
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _returnBtn.frame = CGRectMake(22*WidthScale, 38*HeightScale, 44*WidthScale, 44*HeightScale);
        [_returnBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
        [_returnBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnBtn;
}

-(UIButton *)playBtn{
    
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playBtn.frame = CGRectMake(50*WidthScale, 45*HeightScale, 64*WidthScale, 64*HeightScale);
        [_playBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
-(UIButton *)nextPlayerPlayBtn{
    
    if (!_nextPlayerPlayBtn) {
        _nextPlayerPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextPlayerPlayBtn.frame = CGRectMake(50*WidthScale, 45*HeightScale, 64*WidthScale, 64*HeightScale);
        [_nextPlayerPlayBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        [_nextPlayerPlayBtn addTarget:self action:@selector(nextPlayerPlayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextPlayerPlayBtn;
}


-(UIButton *)pauseBtn{

    if (!_pauseBtn) {
        _pauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _pauseBtn.frame = CGRectMake(50*WidthScale, 45*HeightScale, 64*WidthScale, 64*HeightScale);
        [_pauseBtn setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];
        [_pauseBtn addTarget:self action:@selector(pauseBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pauseBtn;
}

-(UIButton *)speedBtn{
    
    if (!_speedBtn) {
        _speedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _speedBtn.frame = CGRectMake(1581*WidthScale, 45*HeightScale, 99*WidthScale, 64*HeightScale);
        [_speedBtn setImage:[UIImage imageNamed:@"2X"] forState:UIControlStateNormal];
        [_speedBtn addTarget:self action:@selector(speedBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _speedBtn;
}

-(UIButton *)rightViewBtn{
    
    if (!_rightViewBtn) {
        _rightViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightViewBtn.frame = CGRectMake(1760*WidthScale, 45*HeightScale, 64*WidthScale, 64*HeightScale);
        [_rightViewBtn setImage:[UIImage imageNamed:@"收起侧边栏"] forState:UIControlStateNormal];
        [_rightViewBtn addTarget:self action:@selector(rightViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightViewBtn;
}

-(UIButton *)lockBtn{
    
    if (!_lockBtn) {
        _lockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lockBtn.frame = CGRectMake(1904*WidthScale, 45*HeightScale, 64*WidthScale, 64*HeightScale);
        [_lockBtn setImage:[UIImage imageNamed:@"no hold"] forState:UIControlStateNormal];
        [_lockBtn setImage:[UIImage imageNamed:@"hold"] forState:UIControlStateSelected];
        [_lockBtn addTarget:self action:@selector(lockBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _lockBtn.selected = NO;
    }
    return _lockBtn;
}

-(UILabel *)nowCourse{
    
    if (!_nowCourse) {
        _nowCourse = [[UILabel alloc]initWithFrame:CGRectMake(160*WidthScale, 10, 440*WidthScale, 90*HeightScale)];
        [_nowCourse setText:self.videoInfo.videoTitle];
        _nowCourse.font = [UIFont systemFontOfSize:35*HeightScale];
        [_nowCourse setTextColor:[UIColor grayColor]];
        _nowCourse.alpha = 0.7;
    }
    return _nowCourse;
}

-(UIButton *)nowPoint{
    
    if (!_nowPoint) {
        _nowPoint = [UIButton buttonWithType:UIButtonTypeCustom];
        _nowPoint.frame = CGRectMake(630*WidthScale, 10, 440*WidthScale, 90*HeightScale);
        [_nowPoint setTitle:@"当前：2.编程环境的搭建" forState:UIControlStateNormal];
        _nowPoint.titleLabel.font = [UIFont systemFontOfSize:35*WidthScale];
        [_nowPoint setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_nowPoint setTitleColor:UIThemeColor forState:UIControlStateHighlighted];
        _nowPoint.alpha = 0.7;
        _nowPoint.enabled = NO;
    }
    return _nowPoint;
}

-(UILabel *)timeLable{
    
    if (!_timeLable) {
        _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(170*WidthScale, 0, 440*WidthScale, 154*HeightScale)];
        _timeLable.font = [UIFont systemFontOfSize:35*HeightScale];
        [_timeLable setTextColor:[UIColor grayColor]];
        _timeLable.alpha = 0.9;
    }
    return _timeLable;
}

-(UITextField *)insertNote{
    
    if (!_insertNote) {
        _insertNote = [[UITextField alloc]init];
        _insertNote.placeholder = @"密码";
        _insertNote.clearButtonMode = UITextFieldViewModeWhileEditing;
        _insertNote.keyboardType = UIKeyboardTypeDefault;
        _insertNote.secureTextEntry = YES;
        _insertNote.returnKeyType = UIReturnKeyDone;
        _insertNote.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        _insertNote.leftViewMode = UITextFieldViewModeAlways;
        UIImageView *imgUser = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconfont-password"]];
        imgUser.frame = CGRectMake(10, 10, 20, 20);
        [_insertNote.leftView addSubview:imgUser];
    }
    return _insertNote;
}

-(UIView *)startBtnView{

    if (!_startBtnView) {
        _startBtnView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2048*WidthScale, 1280*HeightScale)];
        _startBtnView.backgroundColor = [UIColor clearColor];
        [_startBtnView addSubview:self.startBtn];
        [_startBtnView addSubview:self.writeCodeBtn];
        [_startBtnView addSubview:self.writeNoteBtn];
        [_startBtnView addSubview:self.addPointBtn];
        _startBtnView.hidden = YES;
       
    }
    return _startBtnView;
}

-(UIButton *)startBtn{

    if (!_startBtn) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setBackgroundImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
        [_startBtn setFrame:CGRectMake(668*WidthScale*2048/1614, 361*HeightScale/1212*1563, 234*WidthScale*2048/1614, 234*HeightScale/1212*1563)];
        [_startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return _startBtn;
}

-(UIButton *)writeCodeBtn{
    
    if (!_writeCodeBtn) {
        _writeCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_writeCodeBtn setBackgroundImage:[UIImage imageNamed:@"敲代码"] forState:UIControlStateNormal];
        [_writeCodeBtn setFrame:CGRectMake(932*WidthScale*2048/1614, 438*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563)];
        [_writeCodeBtn addTarget:self action:@selector(writeCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _writeCodeBtn.alpha = 0;
    }
    return _writeCodeBtn;
}



-(UIButton *)writeNoteBtn{
    
    if (!_writeNoteBtn) {
        _writeNoteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_writeNoteBtn setBackgroundImage:[UIImage imageNamed:@"记笔记"] forState:UIControlStateNormal];
//        [_writeNoteBtn setFrame:CGRectMake(906*WidthScale*2048/1614, 265*HeightScale/1212*1563, 213*WidthScale*2048/1614, 157*HeightScale/1212*1563)];
        [_writeNoteBtn setFrame:CGRectMake(932*WidthScale*2048/1614, 438*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563)];
        [_writeNoteBtn addTarget:self action:@selector(writeNoteBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _writeNoteBtn.alpha = 0;
    }
    return _writeNoteBtn;
}

-(UIButton *)addPointBtn{
    
    if (!_addPointBtn) {
        _addPointBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addPointBtn setBackgroundImage:[UIImage imageNamed:@"写备注"] forState:UIControlStateNormal];
        [_addPointBtn setFrame:CGRectMake(668*WidthScale*2048/1614, 438*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563)];
        [_addPointBtn addTarget:self action:@selector(addPointBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _addPointBtn.alpha = 0;
    }
    return _addPointBtn;
}

- (UITapGestureRecognizer *)tap{
    
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBtn:)];
        
    }
    return _tap;
}



-(UIView *)lockView{

    if (!_lockView) {
        _lockView = [[UIView alloc]initWithFrame:self.view.frame];
        [_lockView setBackgroundColor:[UIColor clearColor]];
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(1904*WidthScale, 1427*HeightScale, 64*WidthScale, 64*HeightScale)];
        [btn setBackgroundColor:[UIColor clearColor]];
        [btn addTarget:self action:@selector(unLockBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.lockView addSubview:btn];
        [self.view addSubview:_lockView];
        _lockView.hidden = YES;
    }
    return _lockView;
}


-(UIView *)writeNoteView{

    if (!_writeNoteView) {
        _writeNoteView = [[UIView alloc]initWithFrame:self.view.frame];
        _writeNoteView.backgroundColor = [UIColor clearColor];
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake((self.view.width-1700*WidthScale)/2,361*HeightScale/1212*1563 , 1700*WidthScale, 200*HeightScale)];
        textField.placeholder = @"请添加节点，不超过20字";
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.secureTextEntry = NO;
        textField.returnKeyType = UIReturnKeyDone;
        textField.backgroundColor = UIBackgroundColor;
        textField.textColor = UIThemeColor;
        textField.font = [UIFont systemFontOfSize:70*HeightScale];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"添加备注"] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 100*WidthScale, 100*HeightScale);
        [btn addTarget:self action:@selector(addPoint) forControlEvents:UIControlEventTouchUpInside];
        textField.rightView = [[UIView alloc]initWithFrame:CGRectMake(1580*WidthScale, 50*HeightScale, 100*WidthScale, 100*HeightScale)];
        textField.rightViewMode = UITextFieldViewModeAlways;
        [textField.rightView addSubview:btn];
        [_writeNoteView addSubview:textField];
        _writeNoteView.hidden = YES;
        
    }
    return _writeNoteView;
}

-(UILabel *)isDownloadLabel{

    if (!_isDownloadLabel) {
        _isDownloadLabel = [[UILabel alloc]initWithFrame:CGRectMake(1743*WidthScale, 10, 305*WidthScale, 90*HeightScale)];
        _isDownloadLabel.text = self.videoInfo.videoFileSize;
        _isDownloadLabel.font = [UIFont systemFontOfSize:35*HeightScale];
        [_isDownloadLabel setTextColor:[UIColor grayColor]];
        _isDownloadLabel.alpha = 0.7;
    }
    return _isDownloadLabel;
}

-(UIPanGestureRecognizer *)pan{

    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panToTime:)];
    }
    return _pan;
}


@end
