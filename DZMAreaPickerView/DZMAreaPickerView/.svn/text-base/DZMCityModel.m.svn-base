//
//  DZMCityModel.m
//  shopping
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 haspay. All rights reserved.
//

#import "DZMCityModel.h"
#import "DZMAreaModel.h"
@implementation DZMCityModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        if (dict != nil) {
            
            [self setValuesForKeysWithDictionary:dict];
        }
        
    }
    return self;
}

+ (instancetype)cityModelWithDict:(NSDictionary *)dict
{
    return [[DZMCityModel alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:DZM_A]) {
        
        NSMutableArray *areaModelArr = [NSMutableArray array];
        
        for (NSDictionary *dict in value) {
            
            DZMAreaModel *areaModel = [DZMAreaModel areaModelWithDict:dict];
            [areaModelArr addObject:areaModel];
        }
        
        self.areaModelArray = areaModelArr;
        
    }else{
        
        DZMLog(@"文件名称 = DZMCityModel   value = %@  key = %@",value,key);
    }
}
@end
