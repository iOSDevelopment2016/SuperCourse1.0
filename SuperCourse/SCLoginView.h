//
//  SCLoginView.h
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SCLoginViewDelegate <NSObject>

//-(void)regBtnDidClick:(UIButton *)sender;

@end

@interface SCLoginView : UIView
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *sendPsw;
@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *usertext;
- (IBAction)sendPswClick:(id)sender;
- (IBAction)loginClick:(id)sender;
- (IBAction)usertextClick:(id)sender;
//设置观察者模式
-(void)regNotifacation;
-(void)dealloc;

@property (nonatomic ,weak) id<SCLoginViewDelegate> delegate;
@end
