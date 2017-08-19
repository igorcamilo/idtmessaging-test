//
//  ICForecast.h
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICForecast.h"

@interface ICForecastContainer : NSObject

@property (nonatomic, strong) NSArray<ICForecast *> *list;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
