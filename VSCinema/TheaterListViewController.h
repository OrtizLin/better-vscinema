//
//  TheaterListViewController.h
//  VSCinema
//
//  Created by Mac mini on 2016/11/17.
//  Copyright © 2016年 Mac mini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface TheaterListViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *json;
}



@end
