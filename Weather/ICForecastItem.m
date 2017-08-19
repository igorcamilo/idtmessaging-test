//
//  ICForecastItem.m
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import "ICForecastItem.h"

@implementation ICForecastItem

- (instancetype)initWithLabelText:(NSString *)labelText valueText:(NSString *)valueText {
    self = [super init];
    if (self) {
        self.labelText = labelText;
        self.valueText = valueText;
    }
    return self;
}

@end
