//
//  ViewController.m
//  VSCinema
//
//  Created by Mac mini on 2016/11/16.
//  Copyright © 2016年 Mac mini. All rights reserved.
//

#import "ViewController.h"
#import "TheaterListViewController.h"
#import "MovieViewController.h"
#import "TestViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
   // self.view.backgroundColor = [UIColor lightGrayColor];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.view.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
//Title label
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setFrame:CGRectMake(screenSize.width/2-145,50, 280, 40)];
    [titleLabel setFont:[UIFont fontWithName:@"BodoniSvtyTwoOSITCTT-Book" size:40]];
    titleLabel.text = @"威秀影城時刻表";
    titleLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:titleLabel];
    
//Subtitle label
    UILabel *subtitleLabel = [[UILabel alloc]init];
    [subtitleLabel setFrame:CGRectMake(titleLabel.frame.origin.x,90, 250, 40)];
    [subtitleLabel setFont:[UIFont fontWithName:@"BodoniSvtyTwoOSITCTT-Book" size:15]];
    subtitleLabel.text = @"iOS version , Developed by Otis.";
    subtitleLabel.textColor = [UIColor darkGrayColor];
    [self.view addSubview:subtitleLabel];
    
//TheaterInfo button

   
    UIButton *TheaterBtn =[[UIButton alloc]init];
    TheaterBtn.layer.cornerRadius = 5.0;
    TheaterBtn.layer.borderWidth = 2.0;
    TheaterBtn.layer.borderColor =[UIColor grayColor].CGColor;
    [TheaterBtn setFrame:CGRectMake(screenSize.width/2-100, screenSize.height-150, 200, 40)];
    [TheaterBtn setFont:[UIFont fontWithName:@"BodoniSvtyTwoOSITCTT-Book" size:17]];
    [TheaterBtn setTitle:NSLocalizedString(@"Theater Index", nil) forState:UIControlStateNormal];
    [TheaterBtn addTarget:self
     
                  action:@selector(TheaterBtnClick:)
     
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TheaterBtn];
    
   
  
//MovieInfo button

    
    UIButton *MovieBtn =[[UIButton alloc]init];
    MovieBtn.layer.cornerRadius = 5.0;
    MovieBtn.layer.borderWidth = 2.0;
    MovieBtn.layer.borderColor =[UIColor grayColor].CGColor;
    [MovieBtn setFrame:CGRectMake(screenSize.width/2-100, screenSize.height-100, 200, 40)];
    [MovieBtn setFont:[UIFont fontWithName:@"BodoniSvtyTwoOSITCTT-Book" size:17]];
    [MovieBtn setTitle:NSLocalizedString(@"Movie Index", nil) forState:UIControlStateNormal];
    [MovieBtn addTarget:self
     
                   action:@selector(MovieBtnClick:)
     
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:MovieBtn];
    

    
}
-(IBAction)TheaterBtnClick:(id)sender{
     TestViewController *TheaterView = [TestViewController alloc];
    [self presentViewController:TheaterView animated:true completion:nil];;
}
-(IBAction)MovieBtnClick:(id)sender{
    MovieViewController *MoiveView = [MovieViewController alloc];
    [self presentViewController:MoiveView animated:true completion:nil];;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
