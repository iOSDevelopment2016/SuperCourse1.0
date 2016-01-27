//
//  SCLoginView.m
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCLoginView.h"

@interface SCLoginView ()

- (IBAction)loginBtnClick:(id)sender;
- (IBAction)regBtnClick:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *regBtn;

@end

@implementation SCLoginView

-(void)awakeFromNib{
    
    _loginBtn.backgroundColor = UIThemeColor;
    [_regBtn setTitleColor:UIThemeColor forState:UIControlStateNormal];
}

- (IBAction)loginBtnClick:(id)sender {
    
  
    
}

- (IBAction)regBtnClick:(id)sender {
    
    //[self.delegate regBtnDidClick:sender];
}
@end
