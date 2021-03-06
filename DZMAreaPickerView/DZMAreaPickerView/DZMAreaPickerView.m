//
//  DZMAreaPickerView.m
//  shopping
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 haspay. All rights reserved.
//

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2

#import "DZMAreaPickerView.h"
@interface DZMAreaPickerView()<UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong) NSMutableArray *currentProvinceArray;                     // 当前显示的省份数组
@property (nonatomic,strong) NSMutableArray *currentCityArray;                         // 当前显示的市数组
@property (nonatomic,strong) NSMutableArray *currentAreaArray;                         // 当前显示的区数组

// 模型
@property (nonatomic,strong) DZMProvinceModel *currentProvinceModel;                    // 当前选中的省
@property (nonatomic,strong) DZMCityModel *currentCityModel;                            // 当前选中的市
@property (nonatomic,strong) DZMAreaModel *currentAreaModel;                            // 当前选中的区

@property (nonatomic,assign) BOOL openDelegate;                                         // 调用代理
@end
@implementation DZMAreaPickerView

/**
 *  返回显示好地址的areaPickerView
 *
 *  @param aDelegate aDelegate
 *
 *  @return areaPickerView
 */
+ (DZMAreaPickerView *)areaPickerViewWithaDelegate:(id<DZMAreaPickerViewDelegate>)aDelegate
{
    return [DZMAreaPickerView areaPickerViewWithaDelegate:aDelegate openDelegate:YES];
}

/**
 *  返回显示好地址的areaPickerView
 *
 *  @param aDelegate aDelegate
 *  @param openDelegate 初始化选中的时候是否需要回调代理 就是在初始化的里面创建默认选中 000位置 这第一次的结果是否需要代理回调出来
 *
 *  @return areaPickerView
 */
+ (DZMAreaPickerView *)areaPickerViewWithaDelegate:(id<DZMAreaPickerViewDelegate>)aDelegate openDelegate:(BOOL)openDelegate
{
    DZMAreaPickerView *areaPickerView = [[DZMAreaPickerView alloc] init];
    areaPickerView.aDelegate = aDelegate;
    areaPickerView.backgroundColor = [UIColor clearColor];
    areaPickerView.showsSelectionIndicator = YES;
    areaPickerView.openDelegate = openDelegate;
    [areaPickerView setAreaDataWithComponent:0 row:0];
    [areaPickerView selectRow:0 inComponent:0 animated:YES];
    return areaPickerView;
}

- (NSMutableArray *)currentProvinceArray
{
    if (!_currentProvinceArray) {
        _currentProvinceArray = [NSMutableArray array];
    }
    return _currentProvinceArray;
}

- (NSMutableArray *)currentCityArray
{
    if (!_currentCityArray) {
        _currentCityArray = [NSMutableArray array];
    }
    return _currentCityArray;
}

- (NSMutableArray *)currentAreaArray
{
    if (!_currentAreaArray) {
        _currentAreaArray = [NSMutableArray array];
    }
    return _currentAreaArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}


/**
 *  只需传入区ID 即可选中省市区
 *
 *  @param areaID 区ID
 */
- (void)selectAreaID:(NSString *)areaID
{
    DZMAreaModel *areaModel = [DZMArea areaID:areaID];
    
    [self selectProvinceID:areaModel.ProvinceC.stringValue cityID:areaModel.CityC.stringValue areaID:areaModel.c.stringValue];
}

/**  -------》确保传递进来的ID 是字符串啊 一般服务器获得ID 是NSNumber
 *  通过ID选中地址 必须保持依赖 例如：省市区  不要区可传nil 默认0位置 ， 不要市区 只传省ID即可 ，注意： 不能有省区ID  没有市ID  会有未知错误
 *  @param provinceID 省ID
 *  @param cityID     市ID
 *  @param areaID     区ID
 */
- (void)selectProvinceID:(NSString *)provinceID cityID:(NSString *)cityID areaID:(NSString *)areaID
{
    // 初始化
    [DZMArea provinceID:provinceID cityID:cityID areaID:areaID];
    NSMutableArray *areaIndexArray = [DZMArea areaIndexArray];
    
    // 不足3个补足3个
    if (areaIndexArray.count != 3) {
        
        BOOL isOK = YES;
        
        while (isOK) {
            
            [areaIndexArray addObject:@"0"];
            
            if (areaIndexArray.count == 3) {
                
                isOK = NO;
            }
        }
    }
    
    for (int i = 0; i < areaIndexArray.count; i++) {
        if (i == (areaIndexArray.count - 1)) {self.openDelegate = YES;}else{self.openDelegate = NO;}
        [self setAreaDataWithComponent:i row:[areaIndexArray[i] intValue]];
        [self selectRow:[areaIndexArray[i] intValue] inComponent:i animated:NO];
    }
}

#pragma mark- Picker Data Source Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger count = 0;
    
    if (component == PROVINCE_COMPONENT) {
        
        count = self.currentProvinceArray.count;
    }else if (component == CITY_COMPONENT) {
        
        count = self.currentCityArray.count;
    }else {
        count = self.currentAreaArray.count;
    }
    return count;
}


#pragma mark- Picker Delegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *string = @"";
    
    if (component == PROVINCE_COMPONENT) {
        
        // 获取城市名称
        DZMProvinceModel *provinceModel = self.currentProvinceArray[row];
        string = provinceModel.b;
        
    }else if (component == CITY_COMPONENT) {
        
        // 获取市名称
        DZMCityModel *cityModel = self.currentCityArray[row];
        string = cityModel.b;
        
    }else {
        
        // 获取区名称
        DZMAreaModel *areaModel = self.currentAreaArray[row];
        string = areaModel.b;
    }
    return string;
}

/**
 *  pickerView 选中代理
 *
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.openDelegate = YES;
    [self setAreaDataWithComponent:(int)component row:(int)row];
}

/**
 *  更新当前的数据
 *
 *  @param component 当前的列
 *  @param row       当前的行数
 */
- (void)setAreaDataWithComponent:(int)component row:(int)row
{
    // 获取数数据源
    self.currentProvinceArray = [DZMArea areaModelArray];
    
    if (component == PROVINCE_COMPONENT) {
        
        self.currentProvinceModel = self.currentProvinceArray[row];
        self.currentCityArray = self.currentProvinceModel.cityModelArray;
        
        self.currentCityModel = self.currentCityArray[0];
        self.currentAreaArray = self.currentCityModel.areaModelArray;
        
        self.currentAreaModel = self.currentAreaArray[0];
        
        [self reloadComponent: PROVINCE_COMPONENT];
        [self reloadComponent: CITY_COMPONENT];
        [self reloadComponent: DISTRICT_COMPONENT];
        [self selectRow: 0 inComponent: CITY_COMPONENT animated: YES];
        [self selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        
    }else if(component == CITY_COMPONENT){
        
        self.currentCityModel = self.currentCityArray[row];
        self.currentAreaArray = self.currentCityModel.areaModelArray;
        
        self.currentAreaModel = self.currentAreaArray[0];
        
        [self reloadComponent: DISTRICT_COMPONENT];
        [self selectRow: 0 inComponent: DISTRICT_COMPONENT animated: YES];
        
    }else{
        
        self.currentAreaModel = self.currentAreaArray[row];
    }
    
    // 代理传递出去数据
    if (self.openDelegate) {
        if ([self.aDelegate respondsToSelector:@selector(areaPickerView:currentProvinceModel:currentCityModel:currentAreaModel:)]) {
            [self.aDelegate areaPickerView:self currentProvinceModel:self.currentProvinceModel currentCityModel:self.currentCityModel currentAreaModel:self.currentAreaModel];
        }
    }
}
@end
