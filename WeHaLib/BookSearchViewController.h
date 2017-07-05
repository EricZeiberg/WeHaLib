//
//  BookSearchViewController.h
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/5/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
- (IBAction)searchButtonAction:(id)sender;



@end
