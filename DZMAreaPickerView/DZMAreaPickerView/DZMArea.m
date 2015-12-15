//
//  DZMArea.m
//  shopping
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 haspay. All rights reserved.
//

#import "DZMArea.h"
@interface DZMArea()

@property (nonatomic,strong) NSMutableArray *areaModelArray;                // 地址模型数组
@property (nonatomic,copy) NSString *filePath;                              // 本地地址json文件路径
@property (nonatomic,strong) NSDictionary *areaDict;                        // 存放地址名称数组跟索引数组的字典
@property (nonatomic,strong) NSMutableArray *areaNameArr;                   // 地址名称数组
@property (nonatomic,strong) NSMutableArray *areaIndexArr;                  // 地址索引数组
@property (nonatomic,copy) NSString *areaStr;                               // 地址拼接好的字符串
@end
@implementation DZMArea

- (NSMutableArray *)areaIndexArr
{
    if (!_areaIndexArr) {
        
        _areaIndexArr = [NSMutableArray array];
    }
    return _areaIndexArr;
}

- (NSMutableArray *)areaNameArr
{
    if (!_areaNameArr) {
        
        _areaNameArr = [NSMutableArray array];
    }
    return _areaNameArr;
}


- (NSDictionary *)areaDict
{
    if (!_areaDict) {
        
        _areaDict = [NSDictionary dictionary];
    }
    return _areaDict;
}

- (NSMutableArray *)areaModelArray
{
    if (!_areaModelArray) {
        
        _areaModelArray = [NSMutableArray array];
    }
    return _areaModelArray;
}


/**
 *  获得对象
 *
 *  @return DZMArea
 */
+ (DZMArea *)area
{
    static DZMArea *area = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        area = [[self alloc] init];
    });
    
    return area;
}

- (instancetype)init
{
    if (self = [super init]) {
        
        
    }
    return self;
}

/**
 *  初始化地址数据
 */
- (void)initAreaData
{
    // 从本地取出地址数据
    NSString*filePath = [[NSBundle mainBundle] pathForResource:@"area"ofType:@"txt"];
    NSString *areaStr = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    [DZMArea areaUpdateWithJsonString:areaStr update:NO];
}

/**
 *  更新地址数据
 *
 *  @param jsonStr jsonStr
 *  @param update  是否需要更新 注意：初始化的时候需要传NO 以后从服务器获取新的地址字符串更新的时候可以传YES 避免了每次开启APP都要更换地址字符串
 */
+ (void)areaUpdateWithJsonString:(NSString *)jsonStr update:(BOOL)update
{
    DZMArea *area = [DZMArea area];
    
    // 获取沙河路径 进行缓存地址数据
    NSString *searchPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"area.text"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    area.filePath = searchPath;

    // 判断文件是否存在
    if (![fileManager fileExistsAtPath:searchPath] || update) {   // 不存在创建 或者 进行更新
    
        [jsonStr writeToFile:searchPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
    }
    
    [area updateAreaModelArray];
}

/**
 *  更新地址模型数据
 */
- (void)updateAreaModelArray
{
    // 获取本地地址数组
    NSString *areaStr = [[NSString alloc] initWithContentsOfFile:self.filePath encoding:NSUTF8StringEncoding error:nil];
    // 解析
    NSData *areaData = [[NSData alloc] initWithData:[areaStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSArray *areaArray = [NSJSONSerialization JSONObjectWithData:areaData options:NSJSONReadingMutableLeaves error:nil];
    
    for (NSDictionary *dict in areaArray)  {
        
        DZMProvinceModel *provinceModel = [DZMProvinceModel provinceModelWithDict:dict];
        [self.areaModelArray addObject:provinceModel];
    }
    
}
/**  (获取名称跟索引的单利初始化方法)
 *  通过省市区ID获得省市区顺序的名称和索引字典数组(注意 必须是同一个省市区范围的才有值 例如：区必须是市的子集市必须市省的子集，或者只想要省市不要区 区可以传nil，只想要省不要市区 同样 nil或者@""表示不获取该字段)
 *
 *  @param provinceID 省ID
 *  @param cityID     市ID
 *  @param areaID     区ID
 *
 *  @return 省市区排练顺序的名称和索引字典数组（获取的Key在当前文件的顶部，有注释）
 */
+ (NSDictionary *)provinceID:(NSString *)provinceID cityID:(NSString *)cityID areaID:(NSString *)areaID
{
    DZMArea *area = [DZMArea area];
    
    // 清空数组
    if (area.areaIndexArr.count != 0) {
        
        [area.areaIndexArr removeAllObjects];
    }
    if (area.areaNameArr.count != 0) {
        
        [area.areaNameArr removeAllObjects];
    }
    
    // 取出地址数组
    NSMutableArray *areaArr = [DZMArea areaModelArray];
    
    // 获取省相关信息
    DZMProvinceModel *provinceModel = nil;
    if (provinceID.length != 0) {
        NSDictionary *provinceDict = [DZMArea areaWithID:provinceID array:areaArr areaType:DZMAreaTypeProvince];
        provinceModel = areaArr[[provinceDict[DZMAreaIndex] intValue]];
        [area.areaIndexArr addObject:provinceDict[DZMAreaIndex]];
        [area.areaNameArr addObject:provinceDict[DZMAreaName]];
    }
    
    // 获取市相关信息
    DZMCityModel *cityModel = nil;
    if (cityID.length != 0) {
        NSDictionary *cityDict = [DZMArea areaWithID:cityID array:provinceModel.cityModelArray areaType:DZMAreaTypeCity];
        cityModel = provinceModel.cityModelArray[[cityDict[DZMAreaIndex] intValue]];
        [area.areaIndexArr addObject:cityDict[DZMAreaIndex]];
        [area.areaNameArr addObject:cityDict[DZMAreaName]];
    }
    
    // 获取市相关信息
    if (areaID.length != 0) {
        NSDictionary *areaDict = [DZMArea areaWithID:areaID array:cityModel.areaModelArray areaType:DZMAreaTypeArea];
        [area.areaIndexArr addObject:areaDict[DZMAreaIndex]];
        [area.areaNameArr addObject:areaDict[DZMAreaName]];
    }
    
    // 拼接字符串
    NSString *tempName = @"";
    for (NSString *name in area.areaNameArr) {
        
        if (![tempName isEqualToString:name]) {
            tempName = [NSString stringWithFormat:@"%@%@",tempName,name];
        }
    }
    area.areaStr = tempName;
    
    
    area.areaDict = @{DZMAreaName:area.areaNameArr,DZMAreaIndex:area.areaIndexArr};
    
    return area.areaDict;
}

/**
 *  传入一个id 一个数组 获得 名称 跟索引位置 （例如：想要获取市名称跟索引 传入省模型里面的市数组 跟市ID 区以此类推）
 *
 *  @param ID       根据传入的对应的省市区 ID
 *  @param array    根据传入的对应的省市区 模型数组
 *  @param areaType 根据传入的对应的省市区 areaType
 *
 *  @return 省市区中
 */
+ (NSDictionary *)areaWithID:(NSString *)ID array:(NSMutableArray *)array areaType:(DZMAreaType)areaType
{
    NSDictionary *dict = [NSDictionary dictionary];
    
    for (int i = 0 ;i < array.count; i++) {
        
        NSString *name = @"";
        NSString *tempID = @"";
        
        if (areaType == DZMAreaTypeProvince) {
            DZMProvinceModel *provinceModel = array[i];
            name = provinceModel.b;
            tempID = [provinceModel.c stringValue];
        }else if (areaType == DZMAreaTypeCity){
            DZMCityModel *cityModel = array[i];
            name = cityModel.b;
            tempID = [cityModel.c stringValue];
        }else if (areaType == DZMAreaTypeArea){
            DZMAreaModel *areaModel = array[i];
            name = areaModel.b;
            tempID = [areaModel.c stringValue];
        }
        
        if ([tempID isEqualToString:ID]) {
            
            dict = @{DZMAreaName:name,DZMAreaIndex:[NSString stringWithFormat:@"%d",i]};
            break;
        }
    }
    
    if (dict.count == 0) {
        
        dict = @{DZMAreaName:@"",DZMAreaIndex:@""};
    }
    
    return dict;
}


/**
 *  获得一个DZMArea的模型数组
 *
 *  @return 装好省市区的模型数组
 */
+ (NSMutableArray *)areaModelArray
{
    DZMArea *area = [DZMArea area];
    
    [area initAreaData];
    
    return area.areaModelArray;
}

/**
 *  获取通过 + (NSDictionary *)provinceID 方法传入ID初始化过得省市区名称数组
 *
 *  @return 省市区名称数组
 */
+ (NSMutableArray *)areaNameArray
{
    DZMArea *area = [DZMArea area];
    
    return area.areaNameArr;
}

/**
 *  获取通过 + (NSDictionary *)provinceID 方法传入ID初始化过得省市区索引数组
 *
 *  @return 省市区索引数组
 */
+ (NSMutableArray *)areaIndexArray
{
    DZMArea *area = [DZMArea area];
    
    return area.areaIndexArr;
}

/**
 *  获取通过 + (NSDictionary *)provinceID 方法传入ID初始化过得省市区地址字符串
 *
 *  @param suffix 在通过ID拼接好的地址字符串后面更上一段详细地址(不用可传nil) 例如：拼接的是  上海市 + suffix, 传nil则获得通过ID拼接的地址字符串
 *
 *  @return 省市区拼接好的名称字符串(注意：重复的省市名称将缩短成一个 例如：上海市 上海市 浦东新区 = 上海市浦东新区,重庆市 重庆市 ... = 重庆市... )
 */
+ (NSString *)areaStringWithSuffix:(NSString *)suffix
{
    DZMArea *area = [DZMArea area];
    
    if (suffix.length != 0) {
    
        NSString *areaStr = [[NSString alloc] initWithFormat:@"%@%@",area.areaStr,suffix];
        
        return areaStr;
    }
    
    return area.areaStr;
}

@end
