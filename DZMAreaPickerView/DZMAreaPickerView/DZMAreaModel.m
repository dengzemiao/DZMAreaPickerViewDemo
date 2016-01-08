//
//  DZMAreaModel.m
//  shopping
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 haspay. All rights reserved.
//

#import "DZMAreaModel.h"

@implementation DZMAreaModel
- (instancetype)initWithDict:(NSDictionary *)dict ProvinceB:(NSString *)ProvinceB ProvinceC:(NSNumber *)ProvinceC CityB:(NSString *)CityB CityC:(NSNumber *)CityC
{
    if (self = [super init]) {
        
        if (dict != nil) {
            self.ProvinceB = ProvinceB;
            self.ProvinceC = ProvinceC;
            self.CityB = CityB;
            self.CityC = CityC;
            [self setValuesForKeysWithDictionary:dict];
        }
        
    }
    return self;
}

+ (instancetype)areaModelWithDict:(NSDictionary *)dict ProvinceB:(NSString *)ProvinceB ProvinceC:(NSNumber *)ProvinceC CityB:(NSString *)CityB CityC:(NSNumber *)CityC
{
    return [[DZMAreaModel alloc] initWithDict:dict ProvinceB:ProvinceB ProvinceC:ProvinceC CityB:CityB CityC:CityC];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    DZMLog(@"文件名称 DZMAreaModel    value = %@  key = %@",value,key);
}
@end
