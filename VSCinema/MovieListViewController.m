//
//  MovieListViewController.m
//  VSCinema
//
//  Created by Mac mini on 2016/11/21.
//  Copyright © 2016年 Mac mini. All rights reserved.
//



#import "MovieListViewController.h"
#import "MovieDetailViewController.h"
@interface MovieListViewController ()

@end

@implementation MovieListViewController


{
    int count;
    NSMutableArray *dyItems;
    NSMutableArray * title;
    UITableView *dyTableView;
  
}

@synthesize cinemaID;



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self populateArray];
    
    
}


-(void)loadView{
    
    CGFloat screenHeight =[UIScreen mainScreen].bounds.size.height;
    CGFloat screenWeight =[UIScreen mainScreen].bounds.size.width;
    UIView *container = [[UIView alloc]initWithFrame:CGRectMake(0, 50, screenWeight, screenHeight)];
    self.view = container;
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    navItem.title = NSLocalizedString(@"Select movie",nil);
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back",nil) style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navItem.leftBarButtonItem = leftButton;
    navItem.leftBarButtonItem.tintColor =[UIColor blackColor];
    
    
    
    navBar.items = @[ navItem ];
    
    [self.view addSubview:navBar];
    
    
    dyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, screenWeight, screenHeight-50)];
    
    
    UITableViewCell *tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ThDataCell"];
    
    
    [dyTableView registerClass:tableViewCell.class forCellReuseIdentifier:tableViewCell.reuseIdentifier];
    
    
    dyTableView.dataSource = self;
    
    
    dyTableView.delegate = self;
    
    
    [self.view addSubview:dyTableView];
    
    
}

-(void)populateArray
{
  
    NSRange trange = [cinemaID rangeOfString:@"|"];
    NSString *str =@"https://vieshow-showtime.herokuapp.com/theater/";
    NSString *str2 = [cinemaID substringFromIndex:trange.location+1];
    NSString *str3 = [str stringByAppendingString:str2] ;
    NSURL *url = [NSURL URLWithString:str3];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError* error;
    dyItems = [NSJSONSerialization JSONObjectWithData:data
                                           options:kNilOptions
                                             error:&error];

   
    
    [dyTableView reloadData];
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    dyItems = [NSMutableArray array];
    title = [NSMutableArray array];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}



-(void)back{
    
    [self dismissViewControllerAnimated:true completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
 
    
        MovieDetailViewController *detailview = [MovieDetailViewController alloc];
        detailview.MovieInfo = dyItems[indexPath.row];
        detailview.cinema_id = cinemaID;
        [self presentViewController:detailview animated:false completion:nil];;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dyItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThDataCell" forIndexPath: indexPath];
   
   
        for(NSDictionary *item in dyItems) {
            NSObject *objectforKey = [item objectForKey:@"title"];
            NSString *valueforKey = [objectforKey valueForKey:@"original"];
            [title addObject:valueforKey];

        }
    cell.textLabel.text = title[indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth = TRUE;
    
    return cell;
    
}
- (void)configurePhotoForCell:(UITableViewCell *)cell
{
    cell.imageView.image = [UIImage imageNamed:@"conference"];
    
    
    
    
}


@end
