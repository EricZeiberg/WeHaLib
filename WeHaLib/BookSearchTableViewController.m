//
//  BookSearchTableViewController.m
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/4/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import "BookSearchTableViewController.h"
#import "BookSearchTableCell.h"
#import "BookSearchModel.h"
#import "TFHpple.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "AlertViewController.h"
#import "BookDetailViewController.h"

@interface BookSearchTableViewController ()

@end

@implementation BookSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AlertViewController *sfvc = [storyboard instantiateViewControllerWithIdentifier:@"AlertViewController"];
    sfvc.view.backgroundColor = [UIColor clearColor];
    sfvc.message.text = @"Searching Books...";
    [sfvc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentViewController:sfvc animated:YES completion:^{
        [self searchBooks];
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBooks {
    NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://lci-mt.iii.com/iii/encore/search?lang=eng&target=%@&searchImageSumbitComponent=Submit", _searchQuery]];
    NSURLRequest *request = [NSURLRequest requestWithURL:searchURL];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
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

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    if(!self.data)
    {
        self.data = [NSMutableData data];
    }
    [self.data appendData:data];
    

}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSMutableArray *bookArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSData *searchHTMLData =  [NSData dataWithData:self.data];
    
    //printf("%s", [[[NSString alloc] initWithData:searchHTMLData encoding:NSUTF8StringEncoding] UTF8String]);
    
    
    // 2
    TFHpple *searchParser = [TFHpple hppleWithHTMLData:searchHTMLData];
    
    NSString *XpathQueryString = @"//div[@class='gridBrowseContent2 searchResult']";
    NSArray *nodes = [searchParser searchWithXPathQuery:XpathQueryString];
    
    for (TFHppleElement *node in nodes) {
        
        TFHppleElement *element = [node firstChildWithClassName:@"gridBrowseCol2"];
        // 5
        BookSearchModel *book = [[BookSearchModel alloc] init];
        [bookArray addObject:book];
        
        NSString *imageURL = [[[[element firstChildWithClassName:@"itemBookCover"] firstChildWithTagName:@"a"] firstChildWithTagName:@"img"] objectForKey:@"src"];
        book.imageURL = [NSString stringWithFormat:@"http://lci-mt.iii.com/%@", imageURL];
        
        NSString *title = [[[[element firstChildWithClassName:@"dpBibTitle"] firstChildWithClassName:@"title"] firstChildWithTagName:@"a"] text];
        
        title = [title stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        
        title = [title stringByTrimmingCharactersInSet:
                 [NSCharacterSet whitespaceCharacterSet]];
        
        book.title = title;
        
        NSString *author = [[[[element firstChildWithClassName:@"dpBibTitle" ] firstChildWithClassName:@"dpBibAuthor"] firstChildWithTagName:@"a"]  text];
        
        author = [author stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
        
        author = [author stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceCharacterSet]];
        
        book.author = author;
        
        NSString *bookID = [[node objectForKey:@"id"] substringFromIndex:13];
        
        book.bookID = bookID;
        
        NSLog(@"%@", book);
        
        
    }
    
    
    _searchResults = bookArray;

    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

- (IBAction)unwind:(UIStoryboardSegue *)unwindSegue
{
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"detailViewController"]){
        //        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        //        BookSearchTableViewController *controller = (BookSearchTableViewController *)navController.topViewController;
        BookDetailViewController *controller = (BookDetailViewController *)segue.destinationViewController;
        BookSearchModel *model = [_searchResults objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        controller.titleString = model.title;
        controller.authorString = model.author;
        controller.bookID = model.bookID;
        controller.bookImageURL = model.imageURL;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"detailViewController" sender:tableView];
}






@end
