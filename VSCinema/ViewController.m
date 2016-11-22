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
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   

//theater label
    UILabel *TheaterLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 200, 40)];
    TheaterLabel.text =NSLocalizedString(@"Theater Info", nil);
    TheaterLabel.textColor = [UIColor blueColor];
    [self.view addSubview:TheaterLabel];
    
    UIButton *TheaterBtn =[[UIButton alloc]init];
    TheaterBtn.frame =TheaterLabel.frame;
    [TheaterBtn addTarget:self
     
                  action:@selector(TheaterBtnClick:)
     
    forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TheaterBtn];

//movie label
    UILabel *MovieLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 150, 200, 40)];
    MovieLabel.text =NSLocalizedString(@"Movie Info", nil);
    MovieLabel.textColor = [UIColor blueColor];
    [self.view addSubview:MovieLabel];
    
    UIButton *MovieBtn =[[UIButton alloc]init];
    MovieBtn.frame =MovieLabel.frame;
    [MovieBtn addTarget:self
     
                   action:@selector(MovieBtnClick:)
     
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:MovieBtn];
    

    
}
-(IBAction)TheaterBtnClick:(id)sender{
     TheaterListViewController *TheaterView = [TheaterListViewController alloc];
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
