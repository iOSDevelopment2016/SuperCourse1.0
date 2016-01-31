//
//  SCMyNotesView.m
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCMyNotesView.h"

@interface SCMyNotesView ()<UITextViewDelegate>
@property (nonatomic ,strong) UITextView *notesTextView;
@property (nonatomic ,strong) UIButton *createBtn;
@property (nonatomic, strong) UIView *scrollView;
@property (nonatomic,strong) UIButton *saveBtn;

- (IBAction)usertextClick:(id)sender;
//设置观察者模式
-(void)regNotifacation;
-(void)dealloc;

@end



@implementation SCMyNotesView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIBackgroundColor;
        [self addSubview:self.notesTextView];
        [self addSubview:self.scrollView];
        [self addSubview:self.createBtn];
          }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.notesTextView.frame = CGRectMake(0, 100, self.width, 1217*HeightScale);
    self.backgroundColor = UIBackgroundColor;
    self.scrollView.frame = CGRectMake(0, 0, self.width, 100*HeightScale);
    self.createBtn.frame = CGRectMake(850, 0, 0.127*self.width, 100*HeightScale);
}
-(UIButton *)createBtn{
    if(!_createBtn){
        _createBtn=[[UIButton alloc]initWithFrame:CGRectMake(300, 0, 0.127*self.width, 100*HeightScale)];
        
        [_createBtn setTitle:@"新建" forState:UIControlStateNormal];
        [_createBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_createBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _createBtn;
    
    
    
    
}
-(UIButton *)saveBtn{
    if(!_saveBtn){
        _saveBtn=[[UIButton alloc]initWithFrame:CGRectMake(300, 0, 0.127*self.width, 100*HeightScale)];
        
        [_saveBtn setTitle:@"新建" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    }
    return _saveBtn;
    
}
-(UITextView *)notesTextView{
    if (!_notesTextView) {
        _notesTextView=[[UITextView alloc]init];
        _notesTextView.delegate = self;
        _notesTextView.font = [UIFont systemFontOfSize:16];
        _notesTextView.contentInset = UIEdgeInsetsMake(-11, -6, 0, 0);
        _notesTextView.scrollEnabled = NO;
        [_notesTextView becomeFirstResponder];
        //返回键的类型
        _notesTextView.returnKeyType = UIReturnKeyDefault;
      
        //键盘类型
        _notesTextView.keyboardType = UIKeyboardTypeDefault;
     

    }
    return _notesTextView;

}

-(UIView *)scrollView{
    if(!_scrollView){
        _scrollView=[[UIView alloc]initWithFrame:CGRectMake(520*WidthScale, 780*HeightScale, 200*HeightScale, 9*HeightScale)];
        [_scrollView setBackgroundColor:[UIColor whiteColor]];
    }
    return _scrollView;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [_notesTextView resignFirstResponder];
}

#pragma 响应事件




- (IBAction)usertextClick:(id)sender {
}
//观察者模式
//设置观察者模式
-(void)regNotifacation{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
//销毁观察者模式
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - keyboard events -
///键盘显示事件
- (void) keyboardWillShow:(NSNotification *)notification {
    //获取键盘高度，在不同设备上，以及中英文下是不同的
    //CGFloat kbHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    // 取得键盘的动画时间，这样可以在视图上移的时候更连贯
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //将视图上移计算好的偏移
    if(kyd > 0) {
        CGFloat h=self.frame.size.height;
        CGFloat w=self.frame.size.width;
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(579*WidthScale, 241*HeightScale, w, h);
        }];
    }
}
//键盘消失事件
- (void) keyboardWillHide:(NSNotification *)notify {
    // 键盘动画时间
    CGFloat h=self.frame.size.height;
    CGFloat w=self.frame.size.width;
    double duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //视图下沉恢复原状
    [UIView animateWithDuration:duration animations:^{
        self.frame = CGRectMake(579*WidthScale, 441*HeightScale,w, h);
    }];
}

@end
