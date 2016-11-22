//
//  TheaterDetailViewController.h
//  VSCinema
//
//  Created by Mac mini on 2016/11/17.
//  Copyright © 2016年 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheaterDetailViewController : UIViewController<NSURLConnectionDelegate>{
   
    NSArray *TheaterInfo;
    NSDictionary *jsons;
}

@property(nonatomic,retain) NSArray *TheaterInfo;

@end
