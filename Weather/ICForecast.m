//
//  ICForecast.m
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import "ICForecast.h"

@implementation ICForecast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.city = [[ICCity alloc] initWithDictionary:dictionary[@"city"]];
        // I miss Swift's map(_:) 😢
        NSMutableArray<ICForecastItem *> *list = [NSMutableArray array];
        for (NSDictionary *item in dictionary[@"list"]) {
            [list addObject:[[ICForecastItem alloc] initWithDictionary:item]];
        }
        self.list = [list copy];
    }
    return self;
}

@end
