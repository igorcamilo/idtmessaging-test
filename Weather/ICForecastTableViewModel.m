//
//  ICForecastTableViewModel.m
//  IDTMessaging
//
//  Created by Igor Camilo on 18/08/17.
//  Copyright © 2017 Igor Camilo. All rights reserved.
//

#import "ICForecastTableViewModel.h"
#import "ICForecastContainer.h"
#import <UIKit/UIKit.h>

@interface ICForecastTableViewModel ()

@property (nonatomic, getter=isDownloading) BOOL downloading;
@property (nonatomic, strong) NSArray<ICForecast *> *forecastList;

@end

@implementation ICForecastTableViewModel

- (void)update {
    
    if (self.isDownloading) {
        return;
    }
    
    self.downloading = YES;
    [[[NSURLSession sharedSession] dataTaskWithURL:[[NSURL alloc] initWithString:@"https://api.openweathermap.org/data/2.5/forecast?lat=-35&lon=-19&lang=fi"] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.downloading = NO;
        
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate forecastTableViewModel:self updateDidFailWithError:error];
            });
            return;
        }
        
        ICForecastContainer *forecast = [[ICForecastContainer alloc] initWithDictionary:[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]];
        self.forecastList = forecast.list;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate forecastTableViewModelUpdateDidSucceed:self];
        });
        
    }] resume];
}

- (NSInteger)numberOfSections {
    return self.forecastList.count;
}

- (NSInteger)numberOfRowsForSection:(NSInteger)section {
    return self.forecastList[section].items.count;
}

- (ICForecastItem *)forecastItemForIndexPath:(NSIndexPath *)indexPath {
    return self.forecastList[indexPath.section].items[indexPath.row];
}

@end
