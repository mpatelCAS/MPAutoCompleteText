//
//  APIDataSource.m
//  AutoCompletion
//


#import "APIDataSource.h"
#import "GetJSONOperation.h"
#import "Constants.h"
#import "NSString+URLEncoding.h"
#import "APIRequestOperation.h"

@interface RequestObject ()
@property (nonatomic, strong) NSString* incompleteString;
@property (nonatomic, strong) FetchCompletionBlock completionBlock;
@end

@implementation RequestObject
@end

@interface APIDataSource ()

@property(strong,nonatomic) NSOperationQueue *fetchQueue;
@property RequestObject *requestDataObject;
@property APIRequestOperation *apiRequest;
@end

@implementation APIDataSource

- (void)fetchSuggestionsForIncompleteString:(NSString*)incompleteString
                        withCompletionBlock:(FetchCompletionBlock)completion
{
    if (_fetchQueue.operationCount > 0) {
        [_fetchQueue cancelAllOperations];
    }
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(timeoutRequestWithRequestedObject:) object:self.requestDataObject];
    self.requestDataObject = [RequestObject new];
    [self.requestDataObject setIncompleteString:[incompleteString urlEncodeUsingEncoding:NSUTF8StringEncoding]];
    [self.requestDataObject setCompletionBlock:completion];
    //Postpone the search request
    [self performSelector:@selector(timeoutRequestWithRequestedObject:) withObject:self.requestDataObject afterDelay:0.3];
}

- (void)timeoutRequestWithRequestedObject:(RequestObject *)requestDataObject {
    
    if (_api_type == APICallTypeGET) {
        [self timeoutRequestWithGetRequestedObject:requestDataObject];
    }
    
    if (_api_type == APICallTypePOST) {
        [self timeoutRequestWithPostRequestedObject:requestDataObject];
    }
}

- (void)timeoutRequestWithGetRequestedObject:(RequestObject *)requestDataObject {
    
    // TODO : this url is optional
    //  NSString *urlString = [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?key=%@&q=%@&cx=%@",apiKey,requestDataObject.incompleteString, engineID];
    
    NSMutableString *strURL = [[NSMutableString alloc] init];
    [strURL appendString:_requestURL];
    [strURL appendString:requestDataObject.incompleteString];
    
    NSURL *downloadURL = [NSURL URLWithString:strURL];
    APIRequestOperation *operation = [[APIRequestOperation alloc] initWithDownloadURL:downloadURL
                                                                  withCompletionBlock:requestDataObject.completionBlock];
    operation.req_type = requestTypeGET;
    operation.manager = _manager;
    operation.reqKey = _reqKey;
    operation.reqValue = _rvalue;
    [_fetchQueue addOperation:operation];
}

- (void)timeoutRequestWithPostRequestedObject:(RequestObject *)requestDataObject {
    
    // TODO : this url is optional
    //  NSString *urlString = [NSString stringWithFormat:@"https://www.googleapis.com/customsearch/v1?key=%@&q=%@&cx=%@",apiKey,requestDataObject.incompleteString, engineID];
    
    NSMutableString *strURL = [[NSMutableString alloc] init];
    [strURL appendString:_requestURL];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:requestDataObject.incompleteString forKey:_reqKey];
    
    NSURL *downloadURL = [NSURL URLWithString:strURL];
    APIRequestOperation *operation = [[APIRequestOperation alloc] initWithDownloadURL:downloadURL
                                                                  withCompletionBlock:requestDataObject.completionBlock];
    operation.req_type = requestTypePOST;
    operation.requestParams = params;
    operation.manager = _manager;
    operation.reqKey = _reqKey;
    operation.reqValue = _rvalue;
    operation.reqValue = requestDataObject.incompleteString;
    [_fetchQueue addOperation:operation];
}


@end


