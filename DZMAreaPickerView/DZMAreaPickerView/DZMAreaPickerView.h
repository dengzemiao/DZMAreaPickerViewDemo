//
//  DZMAreaPickerView.h
//  shopping
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 haspay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZMArea.h"
@class DZMAreaPickerView;
@protocol DZMAreaPickerViewDelegate <NSObject>

/**
 *  滚动选中之后代理回调传出模型
 *
 *  @param areaPickerView       DZMAreaPickerView
 *  @param currentProvinceModel 当前选中的省模型
 *  @param currentCityModel     当前选中的市模型
 *  @param currentAreaModel     当前选中的区模型
 */
- (void)areaPickerView:(DZMAreaPickerView *)areaPickerView currentProvinceModel:(DZMProvinceModel *)currentProvinceModel currentCityModel:(DZMCityModel *)currentCityModel currentAreaModel:(DZMAreaModel *)currentAreaModel;

@end
@interface DZMAreaPickerView : UIPickerView

/**
*  返回显示好地址的areaPickerView
*
*  @param aDelegate aDelegate
*
*  @return areaPickerView
*/
+ (DZMAreaPickerView *)areaPickerViewWithaDelegate:(id<DZMAreaPickerViewDelegate>)aDelegate;

/**
 *  返回显示好地址的areaPickerView
 *
 *  @param aDelegate aDelegate
 *  @param openDelegate 初始化选中的时候是否需要回调代理 就是在初始化的里面创建默认选中 000位置 这第一次的结果是否需要代理回调出来
 *
 *  @return areaPickerView
 */
+ (DZMAreaPickerView *)areaPickerViewWithaDelegate:(id<DZMAreaPickerViewDelegate>)aDelegate openDelegate:(BOOL)openDelegate;


/**
 *  只需传入区ID 即可选中省市区
 *
 *  @param areaID 区ID
 */
- (void)selectAreaID:(NSString *)areaID;

/**  -------》确保传递进来的ID 是字符串啊 一般服务器获得ID 是NSNumber
 *  通过ID选中地址 必须保持依赖 例如：省市区  不要区可传nil 默认0位置 ， 不要市区 只传省ID即可 ，注意： 不能有省区ID  没有市ID  会有未知错误
 *  @param provinceID 省ID
 *  @param cityID     市ID
 *  @param areaID     区ID
 */
- (void)selectProvinceID:(NSString *)provinceID cityID:(NSString *)cityID areaID:(NSString *)areaID;

@property (nonatomic,weak) id<DZMAreaPickerViewDelegate> aDelegate;
@end
