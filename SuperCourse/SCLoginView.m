//
//  SCLoginView.m
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCLoginView.h"
#import "HttpTool.h"
#import "SCRootViewController.h"

@interface SCLoginView ()<UITextFieldDelegate>



@end

@implementation SCLoginView


-(void)awakeFromNib{
    self.phone.delegate = self;
    [self.phone addTarget:self action:@selector(textValueDidChange:) forControlEvents:UIControlEventAllEvents];
    [self regNotifacation];
}

-(void)textValueDidChange:(UITextField *)textField{
    if (textField.text.length == 11) {
        NSLog(@"");
      //  [self.sendPsw titleColorForState:<#(UIControlState)#>];
    }
}


- (IBAction)sendPswClick:(id)sender {
    if (self.phone.text.length==11) {
        NSLog(@"电话号码位数正确");
    }else{
        [self shakeAnimationForView:self];
    }
}

- (IBAction)loginClick:(id)sender {
    NSString * phone = self.phone.text;
    NSString * password = self.password.text;
    NSDictionary *para = @{@"method":@"Login",
                           @"param":@{@"Data":@{@"phone":phone,@"password":password}}};
    [HttpTool postWithparams:para success:^(id responseObject) {
        
        NSData *data = [[NSData alloc] initWithData:responseObject];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        NSString *nowState=[dic objectForKey:@"msg"];
        //NSLog(@"%@",nowState);
        NSString *State=@"";
        if ([nowState isEqualToString:State]) {
            [self removeFromSuperview];
        }else{
            [self shakeAnimationForView:self];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

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
//页面抖动
- (void)shakeAnimationForView:(UIView *) view
{
    // 获取到当前的View
    CALayer *viewLayer = view.layer;
    // 获取当前View的位置
    CGPoint position = viewLayer.position;
    // 移动的两个终点位置
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    // 设置动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 设置运动形式
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    // 设置开始位置
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    // 设置结束位置
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    // 设置自动反转
    [animation setAutoreverses:YES];
    // 设置时间
    [animation setDuration:.06];
    // 设置次数
    [animation setRepeatCount:3];
    // 添加上动画
    [viewLayer addAnimation:animation forKey:nil];
}
@end
