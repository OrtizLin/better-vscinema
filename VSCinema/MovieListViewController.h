//
//  MovieListViewController.h
//  VSCinema
//
//  Created by Mac mini on 2016/11/21.
//  Copyright © 2016年 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface MovieListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *json;
     NSString *cinemaID;
}

@property(nonatomic,retain)  NSString *cinemaID;
@end
