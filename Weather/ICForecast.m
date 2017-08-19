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
        
        // Formatters
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        NSMeasurementFormatter *measurementFormatter = [[NSMeasurementFormatter alloc] init];
        NSNumberFormatter *percentNumberFormatter = [[NSNumberFormatter alloc] init];
        percentNumberFormatter.numberStyle = NSNumberFormatterPercentStyle;
        
        self.dateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dictionary[@"dt"] doubleValue]]];
        
        // I'm storing the values in an array istead of instance properties because this way
        // is easier to display on a UITableView.
        
        NSMutableArray<ICForecastItem *> *items = [NSMutableArray array];
        
        // Weather
        NSString *weather = [dictionary[@"weather"] firstObject][@"description"];
        if (weather) {
            [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Weather", nil) valueText:weather]];
        }
        
        NSDictionary *main = dictionary[@"main"];
        if (main) {
            
            // Temperature
            NSNumber *temp = main[@"temp"];
            if (temp) {
                [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Temperature", nil) valueText:[measurementFormatter stringFromMeasurement:[[NSMeasurement alloc] initWithDoubleValue:[temp doubleValue] unit:NSUnitTemperature.kelvin]]]];
            }
            
            // Max Temperature
            NSNumber *tempMax = main[@"temp_max"];
            if (tempMax) {
                [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Maximum temperature", nil) valueText:[measurementFormatter stringFromMeasurement:[[NSMeasurement alloc] initWithDoubleValue:[tempMax doubleValue] unit:NSUnitTemperature.kelvin]]]];
            }
            
            // Min Temperature
            NSNumber *tempMin = main[@"temp_min"];
            if (tempMin) {
                [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Minimum temperature", nil) valueText:[measurementFormatter stringFromMeasurement:[[NSMeasurement alloc] initWithDoubleValue:[tempMin doubleValue] unit:NSUnitTemperature.kelvin]]]];
            }
            
            // Pressure
            NSNumber *pressure = main[@"pressure"];
            if (pressure) {
                [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Pressure", nil) valueText:[measurementFormatter stringFromMeasurement:[[NSMeasurement alloc] initWithDoubleValue:[pressure doubleValue] unit:NSUnitPressure.hectopascals]]]];
            }
            
            // Sea Pressure
            NSNumber *seaPressure = main[@"sea_level"];
            if (seaPressure) {
                [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Sea level pressure", nil) valueText:[measurementFormatter stringFromMeasurement:[[NSMeasurement alloc] initWithDoubleValue:[seaPressure doubleValue] unit:NSUnitPressure.hectopascals]]]];
            }
            
            // Ground Pressure
            NSNumber *groundPressure = main[@"grnd_level"];
            if (groundPressure) {
                [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Ground level pressure", nil) valueText:[measurementFormatter stringFromMeasurement:[[NSMeasurement alloc] initWithDoubleValue:[groundPressure doubleValue] unit:NSUnitPressure.hectopascals]]]];
            }
            
            // Humidity
            NSNumber *humidity = main[@"humidity"];
            if (humidity) {
                [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Humidity", nil) valueText:[percentNumberFormatter stringFromNumber:@([humidity doubleValue] / 100)]]];
            }
        }
        
        // Cloudiness
        NSNumber *cloudiness = dictionary[@"clouds"][@"all"];
        if (cloudiness) {
            [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Cloudiness", nil) valueText:[percentNumberFormatter stringFromNumber:@([cloudiness doubleValue] / 100)]]];
        }
        
        // Wind Speed
        NSNumber *windSpeed = dictionary[@"wind"][@"speed"];
        if (windSpeed) {
            [items addObject:[[ICForecastItem alloc] initWithLabelText:NSLocalizedString(@"Wind speed", nil) valueText:[measurementFormatter stringFromMeasurement:[[NSMeasurement alloc] initWithDoubleValue:[windSpeed doubleValue] unit:NSUnitSpeed.metersPerSecond]]]];
        }
        
        self.items = [items copy];
    }
    return self;
}

@end
