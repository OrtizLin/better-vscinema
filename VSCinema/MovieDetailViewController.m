//
//  MovieDetailViewController.m
//  VSCinema
//
//  Created by Mac mini on 2016/11/21.
//  Copyright © 2016年 Mac mini. All rights reserved.
//

#import "MovieDetailViewController.h"


@interface MovieDetailViewController ()

@end

@implementation MovieDetailViewController{
        NSMutableArray *DayArray;
        NSMutableArray *ShowtimeArray;
        NSMutableArray *timeArray;
    NSString *MovieID;
    NSString *MovieDate;
}



@synthesize MovieInfo,cinema_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//   
   
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:MovieInfo options:NSJSONWritingPrettyPrinted error:nil];
    
    NSError* error;
    NSDictionary *json  = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:kNilOptions
                                                            error:&error];
  
   
        NSObject *objectforKey = [json objectForKey:@"title"];
        NSString *zh_title = [objectforKey valueForKey:@"original"];
        NSString *en_title = [objectforKey valueForKey:@"en"];
    
    
    MovieID = [json objectForKey:@"movieId"];
    
   
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSURL *imageUrl = [NSURL URLWithString:[json objectForKey:@"poster"]];
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:imageUrl]];
    UIImageView *imageview =[[UIImageView alloc]initWithFrame:CGRectMake(10, 61, 230.0f, 310.0f)];
    imageview.image=image;
    [self.view addSubview:imageview];

   
    // NavigationBar.
    
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    UINavigationItem *navItem = [[UINavigationItem alloc] init];

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Back",nil) style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    navItem.leftBarButtonItem = leftButton;
    navItem.leftBarButtonItem.tintColor =[UIColor blackColor];
    navBar.items = @[ navItem ];
    
    [self.view addSubview:navBar];
    
 
    // Title.
        UILabel *title=[[UILabel alloc] init];
        [title setFrame:CGRectMake((screenSize.width-200)/2-80, screenSize.height/2+40, 320, 20)];
        title.lineBreakMode = UILineBreakModeWordWrap;
        title.numberOfLines = 0;
        [title setFont: [UIFont fontWithName:@"Arial" size:16.0f]];
        title.text=zh_title;
        title.textColor =[UIColor whiteColor];
        [self.view addSubview:title];
    
    // ratingLabel.
    UILabel *ratingLabel=[[UILabel alloc] init];
    [ratingLabel setFrame:CGRectMake(screenSize.width-150, screenSize.height/2+40, 320, 20)];
    ratingLabel.lineBreakMode = UILineBreakModeWordWrap;
    ratingLabel.numberOfLines = 0;
    [ratingLabel setFont: [UIFont fontWithName:@"Arial" size:16.0f]];
    ratingLabel.text=[json objectForKey:@"rating"];
    ratingLabel.textColor =[UIColor redColor];
    [self.view addSubview:ratingLabel];
    
    // SubTitle.
    UILabel *subtitle=[[UILabel alloc] init];
    [subtitle setFrame:CGRectMake((screenSize.width-200)/2-70, screenSize.height/2+60, 320, 20)];
    subtitle.lineBreakMode = UILineBreakModeWordWrap;
    subtitle.numberOfLines = 0;
    [subtitle setFont: [UIFont fontWithName:@"Arial" size:16.0f]];
    subtitle.text=en_title;
    subtitle.textColor =[UIColor whiteColor];
    [self.view addSubview:subtitle];
  
         DayArray = [NSMutableArray array];
    ShowtimeArray = [NSMutableArray array];
    timeArray =[NSMutableArray array];
    ShowtimeArray = [json objectForKey:@"showtimesDay"];
   for(NSDictionary *item in ShowtimeArray) {
        NSString *objectforKey = [item objectForKey:@"day"];
      
        [DayArray addObject:objectforKey];
        
    }
    
    
    

  
    


    picker = [[UIPickerView alloc] initWithFrame:CGRectMake((screenSize.width-200)/2-70, screenSize.height/2+90, 320, 60)];
    picker.dataSource = self;
    picker.delegate = self;
    picker.backgroundColor = [UIColor whiteColor];
    picker.showsSelectionIndicator = YES;
    picker.tag = 1;
    [self.view addSubview:picker];
    
    
}

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component

{
    if(pickerView.tag ==1){
    return  DayArray.count;
    }
    else{
        return timeArray.count;
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
 
    if(pickerView.tag ==1){
        return  DayArray[row];
    }
    else{
        return timeArray[row];
    }
    
  
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if(pickerView.tag==1){
    MovieDate = [ShowtimeArray[row] objectForKey:@"day"];
    timeArray = [ShowtimeArray[row] objectForKey:@"sessions"];

        
        pickertime =[[UIPickerView alloc]initWithFrame:CGRectMake((screenSize.width-200)/2-70, screenSize.height/2+180, 320, 60)];
        pickertime.dataSource = self;
        pickertime.delegate = self;
        pickertime.backgroundColor = [UIColor whiteColor];
        pickertime.showsSelectionIndicator = YES;
        pickertime.hidden = NO;
        pickertime.tag = 2;
        [self.view addSubview:pickertime];
        

    }
    else{
       
        UIButton *Orderbutton =[[UIButton alloc]init];
        [Orderbutton setFrame:CGRectMake((screenSize.width)/2-40, screenSize.height/2+240, 60, 60)];
        [Orderbutton setTitle:NSLocalizedString(@"Order", nil) forState:UIControlStateNormal];
        [Orderbutton addTarget:self
         
                          action:@selector(OrderbuttonClick:)
         
                forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:Orderbutton];
        

    }
}
-(void)OrderbuttonClick:(id)sender{
    //        URL: https://vieshow-showtime.herokuapp.com/ticket
    //        cinemaId
    //        movieId
    //        ticketDate
   
    NSURL *url =[NSURL URLWithString:@"https://vieshow-showtime.herokuapp.com/ticket"];
    NSDictionary *jsonDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                              cinema_id, @"cinemaId",
                              MovieID, @"movieId",
                              MovieDate, @"ticketDate",
                              nil];
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:&error];
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [request setHTTPMethod:@"POST"];
    [request setValue: @"application/json" forHTTPHeaderField: @"Accept"];
    [request setValue: @"application/json; charset=utf-8" forHTTPHeaderField: @"content-type"];
    [request setHTTPBody: jsonData];

   
   

    
    [NSURLConnection sendAsynchronousRequest: request
                                       queue: queue
                           completionHandler: ^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (error || !data) {
                                   // Handle the error
                               } else {
                                   // Handle the success
                                   
                                   NSDictionary *json  = [NSJSONSerialization JSONObjectWithData:data
                                                                                         options:kNilOptions
                                                                                           error:&error];
                                   
                                  NSLog(@"Response %@",json);
                               }
                           }
     ];
   

}

-(void)back{
    
    [self dismissViewControllerAnimated:false completion:nil];
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

