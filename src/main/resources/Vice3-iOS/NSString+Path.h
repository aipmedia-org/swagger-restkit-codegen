//
//  NSString+Path.h
//  FMCG
//
//  Created by Andrey Toropchin on 14.01.16.
//  Copyright © 2016 vice3.agency. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Path)
- (NSString*)rkPathPattern;
- (NSString*)pathWithParams:(NSDictionary*)params;
@end
