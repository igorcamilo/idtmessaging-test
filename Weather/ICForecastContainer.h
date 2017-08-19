//
//  ICForecast.h
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICForecast.h"

/// The container is used to encapsulate the top-level parse of the weather JSON
@interface ICForecastContainer : NSObject

@property (nonatomic, strong) NSArray<ICForecast *> *list;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
