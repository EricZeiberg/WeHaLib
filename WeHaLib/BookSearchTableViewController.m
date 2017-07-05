//
//  BookSearchTableViewController.m
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/4/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import "BookSearchTableViewController.h"
#import "BookSearchTableCell.h"
#import "WebHelper.h"
#import "BookSearchModel.h"

@interface BookSearchTableViewController ()

@end

@implementation BookSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _searchResults = [WebHelper searchBooks:_searchQuery];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookSearchTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookSearchCell" forIndexPath:indexPath];
    
    BookSearchModel *model = [_searchResults objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = model.title;
    cell.authorLabel.text = model.author;
    
    cell.bookImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.bookImage.clipsToBounds = YES;
    
    [cell.bookImage setImage:[UIImage imageNamed:@"magpie murders.png"]];
    
    
    
    return cell;
}




@end
