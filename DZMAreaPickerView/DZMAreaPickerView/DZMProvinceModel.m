//
//  DZMProvinceModel.m
//  shopping
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 haspay. All rights reserved.
//

#import "DZMProvinceModel.h"
#import "DZMCityModel.h"
@implementation DZMProvinceModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        if (dict != nil) {
            
            [self setValuesForKeysWithDictionary:dict];
        }
        
    }
    return self;
}

+ (instancetype)provinceModelWithDict:(NSDictionary *)dict
{
    return [[DZMProvinceModel alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:DZM_A]) { // 数组
        
        NSMutableArray *cityModelArr = [NSMutableArray array];
        
        for (NSDictionary *dict in value) {
            
            DZMCityModel *cityModel = [DZMCityModel cityModelWithDict:dict];
            [cityModelArr addObject:cityModel];
        }
        
        self.cityModelArray = cityModelArr;
        
    }else{
        
        DZMLog(@"文件名称 = DZMProvinceModel   value = %@  key = %@",value,key);
    }
}

@end
