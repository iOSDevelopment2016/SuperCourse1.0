//
//  SCDownloadConditionViewController.m
//  SuperCourse
//
//  Created by 刘芮东 on 16/2/4.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCDownloadConditionViewController.h"

@interface SCDownloadConditionViewController ()
@property (nonatomic, strong)UIButton   *backBtn;
@property (nonatomic, strong)UIButton   *backImageBtn;
@end

@implementation SCDownloadConditionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.backImageBtn];
    [self.view addSubview:self.backBtn];

}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.backImageBtn.frame=CGRectMake(40, 22, 20, 35);
    self.backBtn.frame=CGRectMake(40, 20, 250, 40);

}
#pragma mark - click
-(void)backBtnClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - getters
-(UIButton *)backBtn{
    if(!_backBtn){
        _backBtn=[[UIButton alloc]init];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_backBtn setTitle:@"下载管理" forState:UIControlStateNormal];
        [_backBtn setFont:[UIFont systemFontOfSize:45*WidthScale]];
        [_backBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        //_backBtn.backgroundColor=[UIColor redColor];
    }
    return _backBtn;
}
-(UIButton *)backImageBtn{
    if(!_backImageBtn){
        _backImageBtn=[[UIButton alloc]init];
        [_backImageBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_backImageBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backImageBtn;
}



@end
