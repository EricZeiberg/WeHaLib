//
//  BookSearchTableViewController.h
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/4/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomIOSAlertView.h"

@interface BookSearchTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (nonatomic) NSString *searchQuery;
@property (nonatomic) NSMutableArray *searchResults;
@property (nonatomic,readwrite,strong) NSMutableData *data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) CustomIOSAlertView *alertView;

-(void)searchBooks;
@end
