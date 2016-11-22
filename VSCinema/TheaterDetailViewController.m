//
//  TheaterDetailViewController.m
//  VSCinema
//
//  Created by Mac mini on 2016/11/17.
//  Copyright © 2016年 Mac mini. All rights reserved.
//

#import "TheaterDetailViewController.h"

@interface TheaterDetailViewController ()

@end

@implementation TheaterDetailViewController



@synthesize TheaterInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:TheaterInfo options:NSJSONWritingPrettyPrinted error:nil];
  
    NSError* error;
    NSDictionary *json  = [NSJSONSerialization JSONObjectWithData:jsonData
                                           options:kNilOptions
                                             error:&error];
/* json
 
    text		影城名稱
    cinemaId		影城代碼(串接訂票系統)
    address		影城地址
    tel		影城電話
 
*/
   
// Google custom search engine api
// Api key : AIzaSyDNVpasvHDkSYF7EkQcHeRqlmquoPHcS_4
// CSE : 008541906518910799528
// https://developers.google.com/custom-search/

// Theater Image.
    

    NSString *str1 = @"https://www.googleapis.com/customsearch/v1?key=AIzaSyDNVpasvHDkSYF7EkQcHeRqlmquoPHcS_4&cx=008541906518910799528:gqhqkly3cuy&q=";
    NSString *str2 = [json objectForKey:@"text"];
    NSString *str3 =@"&searchType=image&fileType=jpg&imgSize=large&alt=json";
    NSString *str4 = [[str1 stringByAppendingString:str2] stringByAppendingString:str3];
    NSURL *url = [NSURL URLWithString:[str4 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
   NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:data
                                           options:kNilOptions
                                             error:nil];

    NSArray *firstArray = [jsons objectForKey:@"items"];
    NSDictionary *secondArray = [firstArray objectAtIndex:0];
    
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSURL *imageUrl = [NSURL URLWithString:[secondArray objectForKey:@"link"]];
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:imageUrl]];
    UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake((screenSize.width-150)/2, screenSize.height/5, 150.0f, 150.0f)];
    imageview.image=image;
    [self.view addSubview:imageview];
  
// NavigationBar.
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    navItem.title = [json objectForKey:@"text"];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back",nil) style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navItem.leftBarButtonItem = leftButton;
    navItem.leftBarButtonItem.tintColor =[UIColor blackColor];
    navBar.items = @[ navItem ];
    
    [self.view addSubview:navBar];

    
// Title.
    UILabel *title=[[UILabel alloc] init];
    [title setFrame:CGRectMake((screenSize.width-200)/2-40, screenSize.height/2+30, 320, 20)];
    title.lineBreakMode = UILineBreakModeWordWrap;
    title.numberOfLines = 0;
    [title setFont: [UIFont fontWithName:@"Arial" size:16.0f]];
    title.text=[json objectForKey:@"text"];
    title.textColor =[UIColor whiteColor];
    [self.view addSubview:title];
// Address
    UILabel *address=[[UILabel alloc] init];
    [address setFrame:CGRectMake((screenSize.width-200)/2-40, screenSize.height/2+60, 320, 20)];
    address.lineBreakMode = UILineBreakModeWordWrap;
    address.numberOfLines = 0;
    [address setFont: [UIFont fontWithName:@"Arial" size:13.0f]];
    address.text=[json objectForKey:@"address"];
    address.textColor =[UIColor whiteColor];
    [self.view addSubview:address];
// Address button
    
    UIButton *addressbutton =[[UIButton alloc]init];
    addressbutton.frame =address.frame;
    addressbutton.titleLabel.text =address.text;
    addressbutton.titleLabel.hidden =YES;
    [addressbutton addTarget:self
     
                      action:@selector(addressbuttonClick:)
     
         forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addressbutton];

// tel
    UILabel *tel=[[UILabel alloc] init];
    [tel setFrame:CGRectMake((screenSize.width-200)/2-40, screenSize.height/2+90, 320, 20)];
    tel.lineBreakMode = UILineBreakModeWordWrap;
    tel.numberOfLines = 0;
    [tel setFont: [UIFont fontWithName:@"Arial" size:13.0f]];
    tel.text=[json objectForKey:@"tel"];
    tel.textColor =[UIColor whiteColor];
    [self.view addSubview:tel];
    
// telbutton
    
    UIButton *telbutton =[[UIButton alloc]init];
    telbutton.frame =tel.frame;
    telbutton.titleLabel.text =tel.text;
    telbutton.titleLabel.hidden =YES;
    [telbutton addTarget:self
     
                      action:@selector(telbuttonClick:)
     
            forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:telbutton];

    
   

   
}
-(void)back{
    
    [self dismissViewControllerAnimated:false completion:nil];
}
-(void)addressbuttonClick:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    
    NSString *text =btn.titleLabel.text;
    NSString* addr = [NSString stringWithFormat:@"http://maps.google.com/maps?daddr=Current Location&saddr=%@",text];
    NSURL* url = [[NSURL alloc] initWithString:[addr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}
-(void)telbuttonClick:(id)sender{
    UIButton *btn = (UIButton *)sender;
    
    NSString *text =btn.titleLabel.text;
    
    NSLog(@"tel button click and number is %@",text);
    NSString * tel = [text stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSString *urlString = [NSString stringWithFormat: @"tel://%@", tel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
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
