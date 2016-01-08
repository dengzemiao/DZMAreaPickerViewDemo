//
//  DZMAreaModel.h
//  shopping
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 haspay. All rights reserved.
//

#import "DZMObject.h"

@interface DZMAreaModel : DZMObject

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
@property (nonatomic,copy) NSString *CityB;

/**
 *  市ID
 */
@property (nonatomic,copy) NSNumber *CityC;

/**
 *  区名称
 */
@property (nonatomic,copy) NSString *b;

/**
 *  区ID
 */
@property (nonatomic,copy) NSNumber *c;

+ (instancetype)areaModelWithDict:(NSDictionary *)dict ProvinceB:(NSString *)ProvinceB ProvinceC:(NSNumber *)ProvinceC CityB:(NSString *)CityB CityC:(NSNumber *)CityC;
- (instancetype)initWithDict:(NSDictionary *)dict ProvinceB:(NSString *)ProvinceB ProvinceC:(NSNumber *)ProvinceC CityB:(NSString *)CityB CityC:(NSNumber *)CityC;

@end
