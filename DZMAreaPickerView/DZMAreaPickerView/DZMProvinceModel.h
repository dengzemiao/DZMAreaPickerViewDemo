//
//  DZMProvinceModel.h
//  shopping
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 haspay. All rights reserved.
//

#import "DZMObject.h"
@class DZMCityModel;
@interface DZMProvinceModel : DZMObject


/**
 *  当前省所有的区 字典 @{key(ID做key) : value(areaModel),...}
 */
@property (nonatomic,strong) NSMutableDictionary *allAreaModelDict;

/**
 *  市数组
 */
@property (nonatomic,strong) NSMutableArray *cityModelArray;

/**
 *  省份名称
 */
@property (nonatomic,copy) NSString *b;

/**
 *  省ID
 */
@property (nonatomic,copy) NSNumber *c;


+ (instancetype)provinceModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
