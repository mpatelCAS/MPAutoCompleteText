//
//  APIRequestOperation.m
//  MPAutoComplete
//
//  Created by Custom Apps on 7/27/16.
//  Copyright © 2016 Custom Apps. All rights reserved.
//

#import "APIRequestOperation.h"
#import "JSONManager.h"
#import "JSONManager.h"
#import "JSONItem.h"

@interface APIRequestOperation ()

@property BOOL isReqInProgress;
@property BOOL isReqInQueue;
@property (strong, nonatomic) NSMutableDictionary *q_req_paramters;
@property (nonatomic, copy) MyCustomBlock customBlock;

@end

@implementation APIRequestOperation

- (id) init
{
    self = [super init];
    if (self) {
        // All initializations,
        _requestParams = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (instancetype)initWithDownloadURL:(NSURL*)url withCompletionBlock:(FetchCompletionBlock)completion
{
    if (self = [super init]) {
      
        self.manager = [AFHTTPSessionManager manager];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
            
            [self performRequestOperation:url
                      withCompletionBlock:completion
                       setCompletionBlock:^{
            }];
        });
        
    }
    return self;
}

- (void)performRequestOperation :(NSURL *)url
             withCompletionBlock:(FetchCompletionBlock)completion
              setCompletionBlock:(void (^)(void))complete {
    
    if (_isReqInProgress) {
        
        _q_req_paramters = [_requestParams mutableCopy];
        
        if (_customBlock)
            _customBlock();
        
        _customBlock = complete;
        
        return;
    }
    
    _isReqInProgress = true;
    
    if (_req_type == requestTypeGET) {
        
        [self.manager GET:[url absoluteString] parameters:_requestParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            [self manageResponse:responseObject
             withCompletionBlock:completion
              setCompletionBlock:complete
                                :url];
       
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            // Error Message
        }];

    }
    
    if (_req_type == requestTypePOST) {
        
        [self.manager POST:[url absoluteString] parameters:_requestParams progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           
            [self manageResponse:responseObject
             withCompletionBlock:completion
              setCompletionBlock:complete
                                :url];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            // Error Message
        
        }];
        
    }
}

- (void)manageResponse :(id) responseObject
    withCompletionBlock:(FetchCompletionBlock)completion
     setCompletionBlock:(void (^)(void))complete
                       :(NSURL *)url {
   
    NSLog(@"testing");
    
    id dataItem = [responseObject objectForKey:@"items"];
    NSMutableArray *responseItems = [NSMutableArray new];
    if ([dataItem isKindOfClass:[NSArray class]]) {
        NSArray *items = dataItem;
        for (id item in items) {
            if ([item isKindOfClass:[NSDictionary class]] && [[item objectForKey:@"kind"] isEqualToString:@"customsearch#result"]) {
                JSONItem *jsonItem = [JSONItem new];
                [jsonItem setTitle:[item objectForKey:@"title"]];
                [responseItems addObject:jsonItem];
            }
        }
    }
    
    if (completion != nil) {
        completion(responseItems,@"title");
    }
    
    _isReqInProgress = false;
    
    complete();
    
    if (_isReqInQueue) {
        
        _isReqInQueue = false;
        _requestParams = [_q_req_paramters mutableCopy];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0),^{
            
            [self performRequestOperation:url withCompletionBlock:completion setCompletionBlock:_customBlock];
        });

        return;
    }
    
    _customBlock = nil;
    _q_req_paramters = nil;
}

@end
