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
    // Building the URL
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:@"https://api.openweathermap.org/data/2.5/forecast"];
    NSURLQueryItem *latQuery = [NSURLQueryItem queryItemWithName:@"lat" value:@"-35"];
    NSURLQueryItem *lonQuery = [NSURLQueryItem queryItemWithName:@"lon" value:@"-19"];
    NSURLQueryItem *langQuery = [NSURLQueryItem queryItemWithName:@"lang" value:[NSLocale currentLocale].languageCode];
    NSURLQueryItem *appidQuery = [NSURLQueryItem queryItemWithName:@"appid" value:<#API Key#>];
    urlComponents.queryItems = @[latQuery, lonQuery, langQuery, appidQuery];
    NSLog(@"%@", urlComponents.URL);
    // Making the request
    [[[NSURLSession sharedSession] dataTaskWithURL:urlComponents.URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
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

- (NSString *)titleForSection:(NSInteger)section {
    return self.forecastList[section].dateString;
}

- (ICForecastItem *)forecastItemForIndexPath:(NSIndexPath *)indexPath {
    return self.forecastList[indexPath.section].items[indexPath.row];
}

@end
