//
//  SCWebViewController.m
//  SuperCourse
//
//  Created by 孙锐 on 16/1/31.
//  Copyright © 2016年 Develop. All rights reserved.
//

#import "SCWebViewController.h"

@interface SCWebViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) IBOutlet UIView *hubView;
@property (nonatomic, strong) IBOutlet UIView *mainView;
@property (nonatomic, strong) IBOutlet UIView *topView;
@property (nonatomic, strong) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) IBOutlet UIWebView *webView;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation SCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.hubView];
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.backBtn];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.webView addGestureRecognizer:self.pan];

}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}



#pragma mark - click


-(void)OnclikeWeb:(UITapGestureRecognizer *)tap

{
    
    NSLog(@"------");
    
}

-(void)backBtnClick{

    [self.navigationController popViewControllerAnimated:YES];

}

-(void)changeView:(CGFloat)topViewY{

    topViewY = self.topView.y;
    if (topViewY == 0) {
        [UIView animateWithDuration:0.4 animations:^{
            self.topView.transform = CGAffineTransformMakeTranslation(0, -100*HeightScale);
            self.mainView.frame = self.view.frame;
            self.webView.frame = self.view.frame;
        }completion:^(BOOL finished) {
            self.hubView.hidden = YES;
        }];
    }
}

-(void)hiddenTopView:(UIPanGestureRecognizer*) recognizer{

    CGPoint beginStatePoint;
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        beginStatePoint = [recognizer locationInView:self.webView];
    }
    CGFloat beginStateY = beginStatePoint.y;
    CGFloat endStateX;
    CGFloat endStateY;
    CGPoint endStatePoint = [recognizer locationInView:self.webView];
    endStateX = endStatePoint.x;
    endStateY = endStatePoint.y;
    CGFloat moveDistance = endStateY - beginStateY;
    if (moveDistance > 0) {
        [UIView animateWithDuration:0.4 animations:^{
            self.topView.transform = CGAffineTransformIdentity;
            self.mainView.frame = CGRectMake(0, 100*HeightScale, UIScreenWidth, UIScreenHeight-100*HeightScale);
            self.webView.frame = self.mainView.frame;
        }];
    }else if(moveDistance < 0){
        [UIView animateWithDuration:0.4 animations:^{
            self.topView.transform = CGAffineTransformMakeTranslation(0, -100*HeightScale);
            self.mainView.frame = self.view.frame;
            self.webView.frame = self.mainView.frame;
        }];
    }

}

#pragma mark - getters

-(UIView *)mainView{

    if (!_mainView) {
        _mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 100*HeightScale, UIScreenWidth, UIScreenHeight-100*HeightScale)];
        [_mainView setBackgroundColor:[UIColor whiteColor]];
        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
        self.webView = [[UIWebView alloc]init];
        self.webView.frame = _mainView.frame;
        [_webView loadRequest:request];
        [_mainView addSubview:self.webView];
    }
    return _mainView;
}
-(UIView *)topView{

    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, 100*HeightScale)];
        [_topView setBackgroundColor:[UIColor whiteColor]];
    }
    return _topView;
}
-(UIButton *)backBtn{

    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_backBtn setFrame:CGRectMake(22*WidthScale, 38*HeightScale, 44*WidthScale, 44*HeightScale)];
        [_backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(UIView *)hubView{

    if (!_hubView) {
        _hubView = [[UIView alloc]initWithFrame:self.view.frame];
        [_hubView setBackgroundColor:[UIColor clearColor]];
    }
    return _hubView;
}
-(UIPanGestureRecognizer *)pan{

    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenTopView:)];
//        [_pan translationInView:self.webView];
    }
    return _pan;
}
-(UIWebView *)webView{

    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        _webView.scrollView.bounces = NO;
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnclikeWeb:)];
        singleTap.delegate = self;
        singleTap.cancelsTouchesInView = NO;
        [_webView addGestureRecognizer:singleTap];
    }
    return _webView;
}

@end
