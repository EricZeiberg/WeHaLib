//
//  WebHelper.h
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/5/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebHelper : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic) NSURLConnection *searchBookConn;

+(NSMutableArray *)searchBooks:(NSString *)searchQuery;
-(void)processRequest:(NSURLRequest *)request;
@end
