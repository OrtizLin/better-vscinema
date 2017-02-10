//
//  TestViewController.m
//  VSCinema
//
//  Created by Mac mini on 2017/2/9.
//  Copyright © 2017年 Mac mini. All rights reserved.
//

#import "TestViewController.h"
#import <Lottie/Lottie.h>
@interface TestViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) LAAnimationView *lottieLogo;
@property (nonatomic, strong) UIButton *lottieButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *tableViewItems;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _buildDataSource];
    self.lottieLogo = [LAAnimationView animationNamed:@"LottieLogo1"];
    self.lottieLogo.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.lottieLogo];
    
    self.lottieButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.lottieButton addTarget:self action:@selector(_playLottieAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.lottieButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.lottieLogo play];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.lottieLogo pause];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGRect lottieRect = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 0.3);
    self.lottieLogo.frame = lottieRect;
    self.lottieButton.frame = lottieRect;
    
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(lottieRect), CGRectGetWidth(lottieRect), self.view.bounds.size.height - CGRectGetMaxY(lottieRect));
}
#pragma mark -- Internal Methods

- (void)_buildDataSource {
    self.tableViewItems = @[@{@"name" : @"Animation Explorer",
                              @"vc" : @"AnimationExplorerViewController"},
                            @{@"name" : @"Animated Keyboard",
                              @"vc" : @"TypingDemoViewController"},
                            @{@"name" : @"Animated Transitions Demo",
                              @"vc" : @"AnimationTransitionViewController"}];
}

- (void)_playLottieAnimation {
    self.lottieLogo.animationProgress = 0;
    [self.lottieLogo play];
}

#pragma mark -- UITableViewDataSource and Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableViewItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.tableViewItems[indexPath.row][@"name"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *vcClassName = self.tableViewItems[indexPath.row][@"vc"];
    Class vcClass = NSClassFromString(vcClassName);
    if (vcClass) {
        UIViewController *vc = [[vcClass alloc] init];
        [self presentViewController:vc animated:YES completion:NULL];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
