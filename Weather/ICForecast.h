//
//  ICForecast.h
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICCity.h"
#import "ICForecastItem.h"

@interface ICForecast : NSObject

@property (nonatomic, strong) ICCity *city;
@property (nonatomic, strong) NSArray<ICForecastItem *> *list;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
