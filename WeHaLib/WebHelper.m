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
    
    NSLog(@"%@", [[NSString alloc] initWithData:searchHTMLData encoding:NSUTF8StringEncoding]);
    
    // 2
    TFHpple *searchParser = [TFHpple hppleWithHTMLData:searchHTMLData];
    
    NSString *XpathQueryString = @"//div[@class='searchResult']/div[@class='gridBrowseCol2']";
    NSArray *nodes = [searchParser searchWithXPathQuery:XpathQueryString];
    
    for (TFHppleElement *element in nodes) {
        // 5
        BookSearchModel *book = [[BookSearchModel alloc] init];
        [bookArray addObject:book];
        
        book.bookID = [[element objectForKey:@"id"] componentsSeparatedByString:@"-"][1];
        
        NSString *imageURL = [[[[element firstChildWithClassName:@"itemBookCover"] firstChildWithTagName:@"a"] firstChildWithTagName:@"img"] objectForKey:@"src"];
        book.imageURL = [NSString stringWithFormat:@"http://lci-mt.iii.com/%@", imageURL];
        
        NSString *title = [[[[element firstChildWithClassName:@"dpBibTitle"] firstChildWithTagName:@"span"] firstChildWithTagName:@"a"] content];
        
        book.title = title;
        
        NSString *author = [[[element firstChildWithClassName:@"dpBibAuthor"] firstChildWithTagName:@"a"]  content];
        
        book.author = author;
        
        NSLog(@"%@", book);
        
    }
    
    
    return bookArray;
}

@end
