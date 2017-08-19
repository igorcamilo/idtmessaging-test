//
//  ICForecastTableViewModel.h
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICForecastItem.h"

@class ICForecastTableViewModel;

@protocol ICForecastTableViewModelDelegate <NSObject>

- (void)forecastTableViewModelUpdateDidSucceed:(ICForecastTableViewModel *)ftvm;

- (void)forecastTableViewModel:(ICForecastTableViewModel *)ftvm updateDidFailWithError:(NSError *)error;

@end

@interface ICForecastTableViewModel : NSObject

@property (nonatomic, weak) id<ICForecastTableViewModelDelegate> delegate;

- (void)update;

- (NSInteger)numberOfSections;

- (NSInteger)numberOfRowsForSection:(NSInteger)section;

- (ICForecastItem *)forecastItemForIndexPath:(NSIndexPath *)indexPath;

@end
