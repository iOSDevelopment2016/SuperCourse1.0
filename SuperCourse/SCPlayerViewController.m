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
@interface SCPlayerViewController (){
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



@end

@implementation SCPlayerViewController

- (void)viewDidLoad {
    isAnimating = NO;
    
    [super viewDidLoad];
    

    
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

   
    
    
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDir = [paths objectAtIndex:0];
//    NSString *url=[docDir stringByAppendingPathComponent:@"load1.mp4"];
//    NSURL *murl=[NSURL fileURLWithPath:url];

    
    [[SZYVideoManager defaultManager] setUpRemoteVideoPlayerWithContentURL:[NSURL URLWithString:@"http://101.200.73.189/video/001.mp4"] view:self.container];
//    [[SZYVideoManager defaultManager] setUpRemoteVideoPlayerWithContentURL:[NSURL URLWithString:@"http://baobab.cdn.wandoujia.com/14468618701471.mp4"] view:self.container];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoLoadDone:) name:VideoLoadDoneNotification object:nil];
    [self.container addSubview:self.startBtnView];
     [self.view addSubview:self.writeNoteView];
    
}

//播放回调过程
//-(void)playingCallbackWithElapsedTime:(NSTimeInterval)elapsedTime AndTimeRemaining:(NSTimeInterval)timeRemaining, NSTimeInterval playableDuration, BOOL finished
//显示当前播放时间
-(void)showCurrentTime:(NSTimeInterval)elapsedTime  AndplayableDuration:(NSTimeInterval)playableDuration{
    
    int hour = (int)(elapsedTime/3600);
    int minute = (int)(elapsedTime - hour*3600)/60;
    int second = elapsedTime - hour*3600 - minute*60;
    int allHour = (int)(playableDuration/3600);
    int allMinute = (int)(playableDuration - allHour*3600)/60;
    int allSecond = playableDuration - allHour*3600 - allMinute*60;
    NSString *time = [NSString stringWithFormat:@"%02d:%02d:%02d/%02d:%02d:%02d",hour,minute,second,allHour,allMinute,allSecond];
    self.timeLable.text = time;
    
}

#pragma mark - 点击事件

-(void)backBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dealloc{
    //注销通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:VideoLoadDoneNotification object:nil];

}
-(void)videoLoadDone:(NSNotification *)noti{
    
//    [self.view addSubview:self.startBtn];
//    [self.view addSubview:self.pauseBtn];
//    [self.view addSubview:self.resumeBtn];
    
//    //注销通知
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:VideoLoadDoneNotification object:nil];

    [[SZYVideoManager defaultManager] startWithHandler:^(NSTimeInterval elapsedTime, NSTimeInterval timeRemaining, NSTimeInterval playableDuration, BOOL finished) {
        [self showCurrentTime:elapsedTime AndplayableDuration:playableDuration];
        
        if ([self.timeDelegate pointTime] == &elapsedTime) {
            [self.delegate changeViewLooking];
        }
        [self.delegate changeViewLooking];
        
    }];
    
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(0 , self.startBtnView.height-60, self.startBtnView.width, 50)];
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    _slider.minimumValue = 0;
    _slider.maximumValue = [noti.object floatValue];
    [self.startBtnView addSubview:_slider];
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
//    [[SZYVideoManager defaultManager] startWithHandler:^(NSTimeInterval elapsedTime, NSTimeInterval timeRemaining, NSTimeInterval playableDuration, BOOL finished) {
//        self.slider.value = elapsedTime;
//        NSLog(@"%f  %f  %f",elapsedTime,timeRemaining,playableDuration);
//        if (finished) {
//            [[SZYVideoManager defaultManager] stop];
//            NSLog(@"播放结束");
//        }
//       
//    }];
    


-(void)pauseBtnClick{

    [[SZYVideoManager defaultManager] pause];
    [self.pauseBtn removeFromSuperview];
    [self.bottomView addSubview:self.playBtn];
    self.startBtnView.hidden = NO;
    [self transformAnimated];
}

//-(void)resumeBtnClick{
//
//    [[SZYVideoManager defaultManager] resume];
//    [self.resumeBtn removeFromSuperview];
//    [self.bottomView addSubview:self.pauseBtn];
//}

-(void)sliderValueChanged:(UISlider *)sender{
    
    [[SZYVideoManager defaultManager] moveToSecond:sender.value];
}

-(void)speedBtnClick{
    
 
}

-(void)rightViewBtnClick:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.rightView.transform = sender.selected ? CGAffineTransformMakeTranslation(-659*WidthScale, 0) : CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        [self.rightViewBtn setImage:[UIImage imageNamed:@"边栏"] forState:UIControlStateSelected];
    }];
}

-(void)turnToPoint{
    
}

-(void)lockBtnClick{
    
    self.lockView.hidden = NO;
    self.lockBtn.selected = YES;
   
}

-(void)unLockBtnClick{

    self.lockView.hidden = YES;
    self.lockBtn.selected = NO;
}

-(void)showWriteLabel{

    
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
//        self.writeCodeBtn.alpha = 1;
//        self.writeNoteBtn.alpha = 1;
    
        
        self.addPointBtn.frame = CGRectMake(932*WidthScale*2048/1614, 438*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563);
//        self.writeCodeBtn.transform = CGAffineTransformRotate(self.writeCodeBtn.transform, 0.5);
//        self.writeNoteBtn.transform = CGAffineTransformRotate(self.writeNoteBtn.transform, -0.5);
//        self.addPointBtn.transform = CGAffineTransformRotate(self.addPointBtn.transform, 0);
        
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.writeCodeBtn.alpha = 1;
            self.writeNoteBtn.alpha = 1;
//            self.writeCodeBtn.transform = CGAffineTransformMakeTranslation(-31*WidthScale*2048/1614, 130*HeightScale/1212*1563);
//            self.writeNoteBtn.transform = CGAffineTransformMakeTranslation(-31*WidthScale*2048/1614, -130*HeightScale/1212*1563);
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
    
//    if (self.writeNoteBtn) {
//        <#statements#>
//    }
        self.writeCodeBtn.transform = CGAffineTransformMakeRotation(0);
        self.writeNoteBtn.transform = CGAffineTransformMakeRotation(0);
    

    
}

#pragma mark - getters

-(SCRightView *)rightView{
    
    if (!_rightView) {
        _rightView = [[SCRightView alloc]initWithFrame:CGRectMake(UIScreenWidth, 0, 659*WidthScale, 1382*HeightScale)];
    }
    return _rightView;
}

-(UIView *)container{
    
    if (!_container) {
        _container = [[UIView alloc]init];
        [_container setBackgroundColor:UIThemeColor];
        _container.frame = CGRectMake(0, 100*HeightScale, 2048*WidthScale, 1280*HeightScale);
        [self.container addGestureRecognizer:self.tap];
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
        _returnBtn.frame = CGRectMake(22*WidthScale, 18*HeightScale, 64*WidthScale, 64*HeightScale);
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
        [_speedBtn addTarget:self action:@selector(speedBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
        _nowCourse = [[UILabel alloc]initWithFrame:CGRectMake(160*WidthScale, 0, 440*WidthScale, 100*HeightScale)];
        [_nowCourse setText:@"第1课 iOS应用开发准备"];
        _nowCourse.font = [UIFont systemFontOfSize:35*HeightScale];
        [_nowCourse setTextColor:[UIColor grayColor]];
        _nowCourse.alpha = 0.7;
    }
    return _nowCourse;
}

-(UIButton *)nowPoint{
    
    if (!_nowPoint) {
        _nowPoint = [UIButton buttonWithType:UIButtonTypeCustom];
        _nowPoint.frame = CGRectMake(630*WidthScale, 0, 440*WidthScale, 100*HeightScale);
        [_nowPoint setTitle:@"当前：2.编程环境的搭建" forState:UIControlStateNormal];
        _nowPoint.titleLabel.font = [UIFont systemFontOfSize:35*WidthScale];
        [_nowPoint setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_nowPoint setTitleColor:UIThemeColor forState:UIControlStateHighlighted];
        _nowPoint.alpha = 0.7;
        [_nowPoint addTarget:self action:@selector(turnToPoint) forControlEvents:UIControlEventTouchUpInside];
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
//self.writeNoteBtn.frame = CGRectMake(932*WidthScale*2048/1614, 438*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563);
//self.writeCodeBtn.frame = CGRectMake(932*WidthScale*2048/1614, 438*HeightScale/1212*1563, 234*WidthScale*2048/1614, 75*HeightScale/1212*1563);
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

//-(UIButton *)resumeBtn{
//    if (!_resumeBtn){
//        _resumeBtn = [[UIButton alloc]initWithFrame:self.playBtn.frame];
//        [_resumeBtn setImage:[UIImage imageNamed:@"播放"]  forState:UIControlStateNormal];
//        [_resumeBtn addTarget:self action:@selector(resumeBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _resumeBtn;
//}

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
        _isDownloadLabel = [[UILabel alloc]initWithFrame:CGRectMake(1743*WidthScale, 0, 305*WidthScale, 100*HeightScale)];
        _isDownloadLabel.text = @"123M   已下载";
        _isDownloadLabel.font = [UIFont systemFontOfSize:35*HeightScale];
        [_isDownloadLabel setTextColor:[UIColor grayColor]];
        _isDownloadLabel.alpha = 0.7;
    }
    return _isDownloadLabel;
}





@end
