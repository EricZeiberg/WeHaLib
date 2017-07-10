//
//  BookSearchTableViewController.h
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/4/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookSearchTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSString *searchQuery;
@property (nonatomic) NSMutableArray *searchResults;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
