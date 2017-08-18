//
//  ICForecastItem.m
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import "ICForecastItem.h"

@implementation ICForecastItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.date = [[NSDate alloc] initWithTimeIntervalSince1970:[dictionary[@"dt"] doubleValue]];
        NSDictionary *main = dictionary[@"main"];
        if (main) {
            self.temperature = [[NSMeasurement alloc] initWithDoubleValue:[main[@"temp"] doubleValue] unit:NSUnitTemperature.kelvin];
        }
    }
    return self;
}

@end
