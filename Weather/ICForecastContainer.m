//
//  ICForecast.m
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import "ICForecastContainer.h"

@implementation ICForecastContainer

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        // I miss Swift's map(_:) 😢
        NSMutableArray<ICForecast *> *list = [NSMutableArray array];
        for (NSDictionary *item in dictionary[@"list"]) {
            [list addObject:[[ICForecast alloc] initWithDictionary:item]];
        }
        self.list = [list copy];
    }
    return self;
}

@end
