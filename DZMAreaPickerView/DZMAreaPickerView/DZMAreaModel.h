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
 *  区名称
 */
@property (nonatomic,copy) NSString *b;

/**
 *  区ID
 */
@property (nonatomic,copy) NSNumber *c;

+ (instancetype)areaModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
