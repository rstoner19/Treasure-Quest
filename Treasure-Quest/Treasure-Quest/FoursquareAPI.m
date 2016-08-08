//
//  FoursquareAPI.m
//  Treasure-Quest
//
//  Created by Sean Champagne on 8/6/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import "FoursquareAPI.h"
#import "JSONParser.h"
@import UIKit;
@import AFNetworking;

static NSString * const BaseURLString = @"https://api.foursquare.com/v2/venues/";

@implementation FoursquareAPI

+(void)getFoursquareData:(NSString *)userData completionHandler:(foursquareFetchCompletion)completionHandler
{
    NSString *clientID = @"IPVFQK21YIYRBOAM3JHLKAQXDU2LSDVAUFBLZ1ILNINHBMZY";
    NSString *clientSecret = @"HP0YY4ORAIF1Q1DKM4C24EUYHXG0SZBI5CYFZD030APKYIVL";
    NSString *v = @"20160613";
   // NSString *venueID = "";
    NSString *searchURL = [NSString stringWithFormat:@"%@search?ll=40.7,-74&client_id=%@,&client_secret=%@&v=20160613&radius=1000", BaseURLString, clientID, clientSecret];
    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//    [params setObject:@"IPVFQK21YIYRBOAM3JHLKAQXDU2LSDVAUFBLZ1ILNINHBMZY" forKey:@"client_id"];
//    [params setObject:@"HP0YY4ORAIF1Q1DKM4C24EUYHXG0SZBI5CYFZD030APKYIVL "forKey:@"client_secret"];
//    [params setObject:@"4d4b7104d754a06370d81259" forKey:@"query"];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager GET:searchURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"GETTING JSON: %@", responseObject);
        NSArray *results = [JSONParser foursquareJSONData:responseObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionHandler(results, nil);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"ERROR GETTING JSON: %@", error);
    }];
    
//    FoursquareAPI *object;
//    
//    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
//    [params setObject:object.id forKey:@"id"];
//    [params setObject:object.name forKey:@"name"];
//    [params setObject:object.location forKey:@"location"];
    //    [params setObject:@"IPVFQK21YIYRBOAM3JHLKAQXDU2LSDVAUFBLZ1ILNINHBMZY" forKey:@"client_id"];
    //    [params setObject:@"HP0YY4ORAIF1Q1DKM4C24EUYHXG0SZBI5CYFZD030APKYIVL "forKey:@"client_secret"];
    //    [params setObject:@"4d4b7104d754a06370d81259" forKey:@"query"];
  //  [params setObject:LatLong forKey:@"ll"];
   // [params setObject:<#(nonnull id)#> forKey:@"v"];
    
    
    
//    [manager GET:@"https://api.foursquare.com/v2/venues/search" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
    
//        [manager GET:@"" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//            //
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            
//            NSArray *results = [JSONParser foursquareJSONData:responseObject];
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                completionHandler(results, nil);
//            });
//            
//            NSLog(@"%@", results);
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                completionHandler(nil, error);
//            });
//        }];
    }


@end
