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
#import <SDWebImage/UIImageView+WebCache.h>


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
    return [_searchResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BookSearchTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bookSearchCell" forIndexPath:indexPath];
    
    BookSearchModel *model = [_searchResults objectAtIndex:indexPath.row];
    
    cell.titleLabel.adjustsFontSizeToFitWidth = YES;
    cell.titleLabel.minimumFontSize = 10.0;
    
    cell.authorLabel.adjustsFontSizeToFitWidth = YES;
    cell.authorLabel.minimumFontSize = 10.0;
    
    cell.titleLabel.text = model.title;
    cell.authorLabel.text = model.author;
    
    cell.bookImage.contentMode = UIViewContentModeScaleAspectFit;
    cell.bookImage.clipsToBounds = YES;
    
    [cell.bookImage sd_setImageWithURL:[NSURL URLWithString:model.imageURL]
                      placeholderImage:[UIImage imageNamed:@"magpie murders.png"]]; //TODO Get legit placeholder image
    
    
    
    return cell;
}




@end
