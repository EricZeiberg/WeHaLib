//
//  BookSearchViewController.m
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/5/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import "BookSearchViewController.h"
#import "BookSearchTableViewController.h"

@interface BookSearchViewController ()

@end

@implementation BookSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"searchTableViewController"]){
//        UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
//        BookSearchTableViewController *controller = (BookSearchTableViewController *)navController.topViewController;
        BookSearchTableViewController *controller = (BookSearchTableViewController *)segue.destinationViewController;
        controller.searchQuery = _searchTextField.text;
    }
}

- (IBAction)searchButtonAction:(id)sender {
}

- (IBAction)unwind:(UIStoryboardSegue *)unwindSegue
{
}

@end
