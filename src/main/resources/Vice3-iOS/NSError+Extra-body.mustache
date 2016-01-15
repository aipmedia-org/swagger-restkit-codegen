#import "NSError+Extra.h"

NSString* const kErrorDomainServer = @"kErrorDomainServer";

@implementation NSError(Extra)

+ (NSError*)errorWithErrCode:(errorCode)code
{
    return [NSError errorWithDomain:kErrorDomainServer code:code userInfo:nil];
}

+ (NSError*)errorWithErrCode:(errorCode)code domain:(NSString*)domain
{
    return [NSError errorWithDomain:domain code:code userInfo:nil];
}

+ (NSError*)errorWithErrorObject:(Error*)obj httpCode:(NSInteger)httpCode
{
    if (obj == nil)
        return [self errorWithErrCode:kServerError];
    else
        return [NSError errorWithDomain:kErrorDomainServer code:kServerError userInfo:@{@"errorObject": obj, @"httpCode": @(httpCode)}];
}

- (Error*)errorObject
{
    return self.userInfo[@"errorObject"];
}

- (NSString*)errorMessage
{
    NSString* errorStr = nil;

    if ([[self domain] isEqualToString:kErrorDomainServer])
    {
        if (self.code == kInternalServerError)
            errorStr = NSLocalizedString(@"Internal Error", @"");
        else
            errorStr = NSLocalizedString([self errorObject].message, @"");
    }
    else
    {
        if (self.httpStatusCode == kInternalServerError)
            errorStr = NSLocalizedString(@"Internal Error", @"");
        else
            errorStr = [self localizedDescription];
    }

    return errorStr;
}

- (NSInteger)httpStatusCode
{
    NSHTTPURLResponse* response = self.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
    if (response != nil)
        return response.statusCode;
    else if (self.userInfo[@"httpCode"] != nil)
        return [self.userInfo[@"httpCode"] integerValue];
    else
    {
        NSString* str = [[[self localizedDescription] componentsSeparatedByCharactersInSet:[[NSCharacterSet decimalDigitCharacterSet] invertedSet]] componentsJoinedByString:@""];
        return [str integerValue];
    }
}

@end
