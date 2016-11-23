//
//  TheaterListViewController.m
//  VSCinema
//
//  Created by Mac mini on 2016/11/17.
//  Copyright © 2016年 Mac mini. All rights reserved.
//


#import "TheaterListViewController.h"
#import "TheaterDetailViewController.h"
@interface TheaterListViewController ()

@end

@implementation TheaterListViewController


{
    int count;
    NSMutableArray *dyItems;
    NSMutableArray * title;
    UITableView *dyTableView;
}





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
    [navBar setBarTintColor:[UIColor lightGrayColor]];
    [navBar setTranslucent:NO];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
 
    
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back",nil) style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navItem.leftBarButtonItem = leftButton;
    navItem.leftBarButtonItem.tintColor =[UIColor whiteColor];
    
    
    navBar.items = @[ navItem ];
    
    [self.view addSubview:navBar];
    
    
    dyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, screenWeight, screenHeight-50)];
    
  
    UITableViewCell *tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ThDataCell"];
    
    
    [dyTableView registerClass:tableViewCell.class forCellReuseIdentifier:tableViewCell.reuseIdentifier];
    
    
    dyTableView.dataSource = self;
    
    
    dyTableView.delegate = self;
    

//Set Background Image.
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpeg"]];
    [tempImageView setFrame:dyTableView.frame];
    dyTableView.backgroundView = tempImageView;
   
    [self.view addSubview:dyTableView];
    
  
}

-(void)populateArray
{
    [dyItems removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:@"https://vieshow-showtime.herokuapp.com/theater"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    NSError* error;
    json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
  


    NSEnumerator * enumeratorKey = [json keyEnumerator];
    
    for (NSObject *object in enumeratorKey) {
        
        NSObject *objectforKey = [json objectForKey:object];
        
        [dyItems addObject:objectforKey];
    }
    
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
    
 
    TheaterDetailViewController *detailview = [TheaterDetailViewController alloc];
    detailview.TheaterInfo = dyItems[indexPath.row];
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
    
    NSEnumerator * enumeratorKey = [json keyEnumerator];
    
    for (NSObject *object in enumeratorKey) {
        
        NSObject *objectforKey = [json objectForKey:object];
        NSString *valueforKey = [objectforKey valueForKey:@"text"];
        [title addObject:valueforKey];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = title[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.adjustsFontSizeToFitWidth = TRUE;

    
    return cell;

}



@end