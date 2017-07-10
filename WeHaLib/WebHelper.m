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
    
    
    //printf("%s", [[[NSString alloc] initWithData:searchHTMLData encoding:NSUTF8StringEncoding] UTF8String]);

    
    // 2
    TFHpple *searchParser = [TFHpple hppleWithHTMLData:searchHTMLData];
    
    NSString *XpathQueryString = @"//div[@class='gridBrowseContent2 searchResult']/div[@class='gridBrowseCol2']";
    NSArray *nodes = [searchParser searchWithXPathQuery:XpathQueryString];
    
    for (TFHppleElement *element in nodes) {
        // 5
        BookSearchModel *book = [[BookSearchModel alloc] init];
        [bookArray addObject:book];
        
        book.bookID = [[element objectForKey:@"id"] componentsSeparatedByString:@"-"][1];
        
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
        
        NSLog(@"%@", book);
        
        
        //TODO Parse book ID
    }
    
    
    return bookArray;
}

@end
