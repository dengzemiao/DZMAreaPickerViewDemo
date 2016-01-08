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
            
            self.b = dict[DZM_B];
            self.c = dict[DZM_C];
            
            NSArray *a = dict[DZM_A];
            if (a.count > 0) {
                NSMutableDictionary *allAreaModelDict = [NSMutableDictionary dictionary];
                NSMutableArray *cityModelArr = [NSMutableArray array];
                
                for (NSDictionary *dict in a) {
                    DZMCityModel *cityModel = [DZMCityModel cityModelWithDict:dict ProvinceB:self.b ProvinceC:self.c];
                    [cityModelArr addObject:cityModel];
                    [allAreaModelDict addEntriesFromDictionary:cityModel.allAreaModelDict];
                }
                self.cityModelArray = cityModelArr;
                self.allAreaModelDict = allAreaModelDict;
            }
        }
    }
    return self;
}

+ (instancetype)provinceModelWithDict:(NSDictionary *)dict
{
    return [[DZMProvinceModel alloc] initWithDict:dict];
}
@end
