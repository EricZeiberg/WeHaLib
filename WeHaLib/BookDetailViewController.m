//
//  BookDetailViewController.m
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/12/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import "BookDetailViewController.h"
#import "AlertViewController.h"
#import "TFHpple.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AlertViewController *sfvc = [storyboard instantiateViewControllerWithIdentifier:@"AlertViewController"];
    sfvc.view.backgroundColor = [UIColor clearColor];
    sfvc.message.text = @"Access book details...";
    [sfvc setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    [self presentViewController:sfvc animated:YES completion:^{
        [self grabData];
    
    }];
    
    
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    if(!self.data)
    {
        self.data = [NSMutableData data];
    }
    [self.data appendData:data];
    
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSData *searchHTMLData =  [NSData dataWithData:self.data];
    
   // printf("%s", [[[NSString alloc] initWithData:searchHTMLData encoding:NSUTF8StringEncoding] UTF8String]);
    
    
    // 2
    TFHpple *searchParser = [TFHpple hppleWithHTMLData:searchHTMLData];
    
    NSString *XpathQueryString = @"//table[@id='bibInfoDetails']/tbody/tr";
    NSArray *nodes = [searchParser searchWithXPathQuery:XpathQueryString];
    
    NSString *summary = @"NULL";
        for (TFHppleElement *node in nodes) {
            if ([[node firstChildWithClassName:@"bibInfoLabel"].text containsString:@"Summary"]) {
                summary = [[node firstChildWithClassName:@"bibInfoData"] firstChildWithClassName:@"recordDetailValue"].text;
            }
        }
    
    
    summary = [summary stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    summary = [summary stringByTrimmingCharactersInSet:
              [NSCharacterSet whitespaceCharacterSet]];

    self.summaryLabel.text = summary;
    
    [self.bookImageView sd_setImageWithURL:[NSURL URLWithString:_bookImageURL]
                      placeholderImage:[UIImage imageNamed:@"magpie murders.png"]]; //TODO Get legit placeholder image

    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.text = _titleString;
    self.authorLabel.adjustsFontSizeToFitWidth = YES;
    self.authorLabel.text = _authorString;
    
   [self dismissViewControllerAnimated:YES completion:NULL];

}

-(void)grabData {
    NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://lci-mt.iii.com/iii/encore/record/C__R%@", _bookID]];
    NSURLRequest *request = [NSURLRequest requestWithURL:searchURL];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (IBAction)placeHold:(id)sender {
}

@end
