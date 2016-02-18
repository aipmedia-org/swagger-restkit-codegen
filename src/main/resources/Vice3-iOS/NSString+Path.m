//
//  NSString+Path.m
//  FMCG
//
//  Created by Andrey Toropchin on 14.01.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

#import "NSString+Path.h"

@implementation NSString (Path)

- (NSString*)rkPathPattern
{
    NSString* pathPattern = [self stringByReplacingOccurrencesOfString:@"{" withString:@":"];
    pathPattern = [pathPattern stringByReplacingOccurrencesOfString:@"}" withString:@""];
    return pathPattern;
}

- (NSString*)pathWithParams:(NSDictionary*)params
{
    NSString* path = self;
    for (NSString* key in params)
        path = [path stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"{%@}", key] withString:[NSString stringWithFormat:@"%@", params[key]]];
    return path;
}

@end
