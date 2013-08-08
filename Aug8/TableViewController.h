//
//  TableViewController.h
//  Aug8
//
//  Created by david morton on 8/8/13.
//  Copyright (c) 2013 David Morton Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController{
	NSString *cellReuseIdentifier;
}


//holds the airports
@property (strong, nonatomic) NSMutableArray *airports;


@end
