//
//  BookSearchModel.m
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/5/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import "BookSearchModel.h"

@implementation BookSearchModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"BookSearchModel: %@, %@, %@, %@", _title, _author, _bookID, _imageURL];
}
@end
