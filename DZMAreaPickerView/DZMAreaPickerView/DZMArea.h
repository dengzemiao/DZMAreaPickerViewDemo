//
//  DZMArea.h
//  shopping
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 haspay. All rights reserved.
//

typedef enum{
    DZMAreaTypeProvince = 0,                // 省
    DZMAreaTypeCity,                        // 市
    DZMAreaTypeArea                         // 区
}DZMAreaType;

#define DZMAreaName @"AreaName"             // 城市名称数组Key （通过调用当前界面areaStringArrWithProvinceID方法获得的字典使用当前这个key获取）
#define DZMAreaIndex @"AreaIndex"           // 城市索引数组Key （通过调用当前界面areaStringArrWithProvinceID方法获得的字典使用当前这个key获取）

#import <Foundation/Foundation.h>
#import "DZMProvinceModel.h"
#import "DZMCityModel.h"
#import "DZMAreaModel.h"

@interface DZMArea : NSObject

// 注释： DZMProvinceModel 省           DZMCityModel 市           DZMAreaModel区

/**
 *  获得一个地址的模型数组 注意 ：获得是省数组 可以手动取出市数组 在取出区数组
 *
 *  @return 装好省市区的模型数组
 */
+ (NSMutableArray *)areaModelArray;

/**  (获取名称跟索引的单利初始化方法) -------》确保传递进来的ID 是字符串啊 一般服务器获得ID 是NSNumber 
 *  通过省市区ID获得省市区顺序的名称和索引字典数组(注意 必须是同一个省市区范围的才有值 例如：区必须是市的子集市必须市省的子集，或者只想要省市不要区 区可以传nil，只想要省不要市区 同样 nil或者@""表示不获取该字段)
 名称数组用处： 从服务获取的对应ID 按顺序传入此方法可以获得省市区当前传入ID 获取到对应的名称字符串数组 用于展示
 索引数组用处： 从服务获取的对应ID 按顺序传入此方法可以获得省市区当前传入ID 在那一列的索引位置 用于选中
 *
 *  @param provinceID 省ID
 *  @param cityID     市ID
 *  @param areaID     区ID
 *
 *  @return 省市区排练顺序的名称和索引字典数组（获取的Key在当前文件的顶部，有注释）
 */
+ (NSDictionary *)provinceID:(NSString *)provinceID cityID:(NSString *)cityID areaID:(NSString *)areaID;

/**
 *  通过区ID 获取省市区
 *
 *  @param areaID 区ID
 *
 *  @return DZMAreaModel 模型里面附带省市区信息
 */
+ (DZMAreaModel *)areaID:(NSString *)areaID;

/**
 *  获取通过 + (NSDictionary *)provinceID 方法传入ID初始化过得省市区名称数组
 *
 *  @return 省市区名称数组 (存在里面属性为字符串类型)
 */
+ (NSMutableArray *)areaNameArray;

/**
 *  获取通过 + (NSDictionary *)provinceID 方法传入ID初始化过得省市区索引数组
 *
 *  @return 省市区索引数组 (存在里面属性为字符串类型)
 */
+ (NSMutableArray *)areaIndexArray;

/**
 *  获取通过 + (NSDictionary *)provinceID 方法传入ID初始化过得省市区地址字符串
 *
 *  @param suffix 在通过ID拼接好的地址字符串后面更上一段详细地址(不用可传nil) 例如：拼接的是  上海市 + suffix, 传nil则获得通过ID拼接的地址字符串
 *
 *  @return 省市区拼接好的名称字符串(注意：重复的省市名称将缩短成一个 例如：上海市 上海市 浦东新区 = 上海市浦东新区,重庆市 重庆市 ... = 重庆市... )
 */
+ (NSString *)areaStringWithSuffix:(NSString *)suffix;

/**
 *  更新地址数据
 *
 *  @param jsonStr jsonStr
 *  @param update  是否需要更新 注意：初始化的时候需要传NO 以后从服务器获取新的地址字符串更新的时候可以传YES 避免了每次开启APP都要更换地址字符串
 */
+ (void)areaUpdateWithJsonString:(NSString *)jsonStr update:(BOOL)update;
@end
