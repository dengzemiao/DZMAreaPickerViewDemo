//
//  DZMAreaModel.m
//  shopping
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 haspay. All rights reserved.
//

#import "DZMAreaModel.h"

@implementation DZMAreaModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        if (dict != nil) {
            
            [self setValuesForKeysWithDictionary:dict];
        }
        
    }
    return self;
}

+ (instancetype)areaModelWithDict:(NSDictionary *)dict
{
    return [[DZMAreaModel alloc] initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    DZMLog(@"文件名称 DZMAreaModel    value = %@  key = %@",value,key);
}
@end
