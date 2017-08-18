//
//  ICForecastItem.h
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICWind.h"

@interface ICForecastItem : NSObject

@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSMeasurement<NSUnitTemperature *> *temperature;
@property (nonatomic, copy) NSMeasurement<NSUnitTemperature *> *maxTemperature;
@property (nonatomic, copy) NSMeasurement<NSUnitTemperature *> *minTemperature;
@property (nonatomic, copy) NSMeasurement<NSUnitPressure *> *pressure;
@property (nonatomic, copy) NSMeasurement<NSUnitPressure *> *seaPressure;
@property (nonatomic, copy) NSMeasurement<NSUnitPressure *> *groundPressure;
@property (nonatomic, copy) NSNumber *humidity;

@property (nonatomic, copy) NSNumber *cloudiness;
@property (nonatomic, copy) ICWind *wind;
@property (nonatomic, copy) NSMeasurement<NSUnitLength *> *rain;
@property (nonatomic, copy) NSMeasurement<NSUnitLength *> *snow;


@end
