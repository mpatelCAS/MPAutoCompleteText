//
//  GetJSONOperation.h
//  AutoCompletion
//


@import AutoCompletion;
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface GetJSONOperation : NSOperation

- (instancetype)initWithDownloadURL:(NSURL*)url withCompletionBlock:(FetchCompletionBlock)completion;

@end
