//
//  ViewController.m
//  DZMAreaPickerView
//
//  Created by haspay on 15/11/9.
//  Copyright © 2015年 DZM. All rights reserved.
//

#import "ViewController.h"
#import "DZMAreaPickerView.h"
@interface ViewController ()<DZMAreaPickerViewDelegate>
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建即可用（自定选中加代理回调）
    DZMAreaPickerView *areaPickerView = [DZMAreaPickerView areaPickerViewWithaDelegate:self];
    areaPickerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 320);
    [self.view addSubview: areaPickerView];
    
    
    #pragma mark - 附加功能(可看需求用)
    // 可以通过服务器传回来的ID 传入进去直接进行选中对应的省市区 （建议进去看该方法介绍）传nil默认位置为0注意
    // 该方法只能用于对应ID 选中 普通选中DZMAreaPickerView以自带选中加代理回调
    [areaPickerView selectProvinceID:nil cityID:nil areaID:nil];
    
    // 服务器请求回来的城市ID 可直接传进去初始化 可以进去看下该方法的介绍
    [DZMArea provinceID:nil cityID:nil areaID:nil];
    
    // 初始化之后可以获得 (同过ID 初始化之后得到 的省市区名称数组)
    NSMutableArray *areaNameArray = [DZMArea areaNameArray];
    
    // 初始化之后可以获得 (同过ID 初始化之后得到 的省市区索引数组，可用于选中pickview)
    NSMutableArray *areaIndexArray = [DZMArea areaIndexArray];
    
    // 初始化之后可以获得 (同过ID 初始化之后得到 的省市区名称字符串) 在通过ID拼接好的地址字符串后面更上一段详细地址(不用可传nil) 例如：拼接的是  上海市 + suffix, 传nil则获得通过ID拼接的地址字符串
    // (注意：重复的省市名称将缩短成一个 例如：上海市 上海市 浦东新区 = 上海市浦东新区,重庆市 重庆市 ... = 重庆市... )
    NSString *areaString = [DZMArea areaStringWithSuffix:nil];
}



#pragma mark - DZMAreaPickerViewDelegate
- (void)areaPickerView:(DZMAreaPickerView *)areaPickerView currentProvinceModel:(DZMProvinceModel *)currentProvinceModel currentCityModel:(DZMCityModel *)currentCityModel currentAreaModel:(DZMAreaModel *)currentAreaModel
{
    NSLog(@"name - %@     %@     %@",currentProvinceModel.b,currentCityModel.b,currentAreaModel.b);
    NSLog(@"id   - %@     %@     %@",currentProvinceModel.c,currentCityModel.c,currentAreaModel.c);
}

@end
