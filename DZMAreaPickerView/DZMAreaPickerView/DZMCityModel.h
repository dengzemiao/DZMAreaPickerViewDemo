//
//  DZMCityModel.h
//  shopping
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 haspay. All rights reserved.
//

#import "DZMObject.h"
@class DZMAreaModel;
@interface DZMCityModel : DZMObject
/**
 *  字典 @{key(ID做key) : value(areaModel),...}
 */
@property (nonatomic,strong) NSMutableDictionary *allAreaModelDict;

/**
 *  区数组
 */
@property (nonatomic,strong) NSMutableArray *areaModelArray;

/**
 *  省名称
 */
@property (nonatomic,copy) NSString *ProvinceB;

/**
 *  省ID
 */
@property (nonatomic,copy) NSNumber *ProvinceC;

/**
 *  市名称
 */
@property (nonatomic,copy) NSString *b;

/**
 *  市ID
 */
@property (nonatomic,copy) NSNumber *c;

+ (instancetype)cityModelWithDict:(NSDictionary *)dict ProvinceB:(NSString *)ProvinceB ProvinceC:(NSNumber *)ProvinceC;
- (instancetype)initWithDict:(NSDictionary *)dict ProvinceB:(NSString *)ProvinceB ProvinceC:(NSNumber *)ProvinceC;
@end
