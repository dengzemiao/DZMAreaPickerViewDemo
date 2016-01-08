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
- (instancetype)initWithDict:(NSDictionary *)dict ProvinceB:(NSString *)ProvinceB ProvinceC:(NSNumber *)ProvinceC
{
    if (self = [super init]) {
        
        if (dict != nil) {
            
            self.ProvinceB = ProvinceB;
            self.ProvinceC = ProvinceC;
            self.b = dict[DZM_B];
            self.c = dict[DZM_C];
            
            NSArray *a = dict[DZM_A];
            if (a.count > 0) {
                NSMutableDictionary *allAreaModelDict = [NSMutableDictionary dictionary];
                NSMutableArray *areaModelArr = [NSMutableArray array];
                
                for (NSDictionary *dict in a) {
                    DZMAreaModel *areaModel = [DZMAreaModel areaModelWithDict:dict ProvinceB:ProvinceB ProvinceC:ProvinceC CityB:self.b CityC:self.c];
                    [areaModelArr addObject:areaModel];
                    [allAreaModelDict setObject:areaModel forKey:areaModel.c.stringValue];
                }
                self.areaModelArray = areaModelArr;
                self.allAreaModelDict = allAreaModelDict;
            }
        }
    }
    return self;
}

+ (instancetype)cityModelWithDict:(NSDictionary *)dict ProvinceB:(NSString *)ProvinceB ProvinceC:(NSNumber *)ProvinceC
{
    return [[DZMCityModel alloc] initWithDict:dict ProvinceB:ProvinceB ProvinceC:ProvinceC];
}
@end
