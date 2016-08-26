//
//  APIRequestOperation.h
//  MPAutoComplete
//
//  Created by Custom Apps on 7/27/16.
//  Copyright © 2016 Custom Apps. All rights reserved.
//

#import "GetJSONOperation.h"
#import "AFHTTPSessionManager.h"

typedef void(^MyCustomBlock)(void);

@interface APIRequestOperation : GetJSONOperation

typedef NS_ENUM(NSInteger, requestType) {
    requestTypeGET,
    requestTypePOST
};

@property (nonatomic,retain) AFHTTPSessionManager *manager;

@property (nonatomic,retain) NSString *reqKey;

@property requestType req_type;

@property (nonatomic,retain) NSString *reqValue;

@property (nonatomic,retain) NSMutableDictionary *requestParams;

@end
