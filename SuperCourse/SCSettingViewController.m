//
//  SCSettingViewController.m
//  SuperCourse
//
//  Created by Develop on 16/1/23.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCSettingViewController.h"

@interface SCSettingViewController ()


@property (nonatomic, strong)UIImage    *backImage;
@property (nonatomic, strong)UILabel    *settingLabel;




@end

@implementation SCSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIBackgroundColor;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.width-150)/2, (self.view.height-100)/2, 150, 100)];
    btn.backgroundColor = UIThemeColor;
    [btn setTitle:@"我是设置页" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:23];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

-(void)backBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
