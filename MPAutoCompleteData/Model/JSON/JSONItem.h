//
//  JSONItem.h
//  AutoCompletion
//


#import <Foundation/Foundation.h>

@interface JSONItem : NSObject

@property (nonatomic, retain) NSString * title;

@property (nonatomic, retain) NSString * value;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end