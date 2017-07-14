//
//  BookDetailViewController.h
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/12/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UITextView *summaryLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bookImageView;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@property (nonatomic) NSString *titleString;
@property (nonatomic) NSString *authorString;
@property (nonatomic) NSString *bookID;
@property (nonatomic,readwrite,strong) NSMutableData *data;
@property (nonatomic) NSString *bookImageURL;


- (IBAction)placeHold:(id)sender;

-(void)grabData;
@end
