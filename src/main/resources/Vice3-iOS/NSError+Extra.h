#import <Foundation/Foundation.h>
#import "Error.h"

typedef NS_ENUM(NSInteger, errorCode)
{
    kNoError = 0,
    kServerError = 100,
    kNotAuthorized = 401,
    kForbidden = 403,
    kNotFound = 404,
    kInternalServerError = 500
};

extern NSString* const kErrorDomainServer;

@interface NSError(Extra)

+ (NSError*)errorWithErrCode:(errorCode)code;
+ (NSError*)errorWithErrCode:(errorCode)code domain:(NSString*)domain;
+ (NSError*)errorWithErrorObject:(Error*)obj httpCode:(NSInteger)httpCode;

- (NSString*)errorMessage;
- (NSInteger)httpStatusCode;

@end
