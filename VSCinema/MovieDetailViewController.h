//
//  MovieDetailViewController.h
//  VSCinema
//
//  Created by Mac mini on 2016/11/21.
//  Copyright © 2016年 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource,NSURLConnectionDelegate>{
    
    NSArray *MovieInfo;
    UILabel *resultLabel;
    UIPickerView *picker;
    UIPickerView *pickertime;
    NSString *cinema_id;
    NSDictionary *json_data;
   
}

@property(nonatomic,retain) NSArray *MovieInfo;
@property(nonatomic,retain)NSString *cinema_id;

@end
