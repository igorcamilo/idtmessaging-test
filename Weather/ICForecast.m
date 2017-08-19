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
        
        NSMeasurementFormatter *measurementFormatter = [[NSMeasurementFormatter alloc] init];
        
        NSMutableArray<ICForecastItem *> *items = [NSMutableArray array];
        
        NSDictionary *main = dictionary[@"main"];
        if (main) {
            
            NSNumber *temp = main[@"temp"];
            if (temp) {
                [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Temperature", nil) valueText:[measurementFormatter stringFromMeasurement:[[NSMeasurement alloc] initWithDoubleValue:[temp doubleValue] unit:NSUnitTemperature.kelvin]]]];
            }
            
            NSNumber *tempMax = main[@"temp_max"];
            if (tempMax) {
                [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Maximum temperature", nil) valueText:[measurementFormatter stringFromMeasurement:[[NSMeasurement alloc] initWithDoubleValue:[tempMax doubleValue] unit:NSUnitTemperature.kelvin]]]];
            }
            
            
            
//            self.temperature = [[NSMeasurement alloc] initWithDoubleValue:[ doubleValue] unit:NSUnitTemperature.kelvin];
//            self.maxTemperature = [[NSMeasurement alloc] initWithDoubleValue:[main[@""] doubleValue] unit:NSUnitTemperature.kelvin];
//            self.minTemperature = [[NSMeasurement alloc] initWithDoubleValue:[main[@"temp_min"] doubleValue] unit:NSUnitTemperature.kelvin];
//            self.pressure = [[NSMeasurement alloc] initWithDoubleValue:[main[@"pressure"] doubleValue] unit:NSUnitPressure.hectopascals];
//            self.seaPressure = [[NSMeasurement alloc] initWithDoubleValue:[main[@"sea_level"] doubleValue] unit:NSUnitPressure.hectopascals];
//            self.groundPressure = [[NSMeasurement alloc] initWithDoubleValue:[main[@"grnd_level"] doubleValue] unit:NSUnitPressure.hectopascals];
//            self.humidity = @([main[@"humidity"] doubleValue] / 100);
        }
        self.items = items;
    }
    return self;
}

@end

//- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
//    self = [super init];
//    if (self) {
//        self.date = [[NSDate alloc] initWithTimeIntervalSince1970:[dictionary[@"dt"] doubleValue]];
//
//        self.cloudiness = @([dictionary[@"clouds"][@"all"] doubleValue] / 100);
//        NSDictionary *wind = dictionary[@"wind"];
//        if (wind) {
//            self.windSpeed = [[NSMeasurement alloc] initWithDoubleValue:[wind[@"speed"] doubleValue] unit:NSUnitSpeed.metersPerSecond];
//            self.windDegrees = [[NSMeasurement alloc] initWithDoubleValue:[wind[@"deg"] doubleValue] unit:NSUnitAngle.degrees];
//        }
//        NSNumber *rain = dictionary[@"rain"][@"3h"];
//        if (rain) {
//            self.rain = [[NSMeasurement alloc] initWithDoubleValue:[rain doubleValue] unit:NSUnitLength.millimeters];
//        }
//        NSNumber *snow = dictionary[@"snow"][@"3h"];
//        if (snow) {
//            self.snow = [[NSMeasurement alloc] initWithDoubleValue:[rain doubleValue] unit:NSUnitLength.millimeters];
//        }
//    }
//    return self;
//}
