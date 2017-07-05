//
//  WebHelper.m
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/5/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import "WebHelper.h"
#import "TFHpple.h"
#import "BookSearchModel.h"

@implementation WebHelper

+(NSMutableArray *)searchBooks:(NSString *)searchQuery {
    
    NSMutableArray *bookArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSURL *searchURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://lci-mt.iii.com/iii/encore/search?lang=eng&target=%@&searchImageSumbitComponent=Submit", searchQuery]];
    NSData *searchHTMLData = [NSData dataWithContentsOfURL:searchURL];
    
    // 2
    TFHpple *searchParser = [TFHpple hppleWithHTMLData:searchHTMLData];
    
    NSString *XpathQueryString = @"//div[@class='searchResult']/div[@class='gridBrowseCol2']";
    NSArray *nodes = [searchParser searchWithXPathQuery:XpathQueryString];
    
    for (TFHppleElement *element in nodes) {
        // 5
        BookSearchModel *book = [[BookSearchModel alloc] init];
        [bookArray addObject:book];
        
        
    }
    
    
    return bookArray;
}

@end
