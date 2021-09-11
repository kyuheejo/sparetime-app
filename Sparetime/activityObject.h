//
//  activityObject.h
//  Sparetime
//
//  Created by Brian Fisher on 2/26/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface activityObject : NSObject<NSCoding>
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *descriptionString;
@property (nonatomic, strong) NSString *typeString;
@property (nonatomic, strong) NSString *locationString;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;
@property (nonatomic, strong) NSData *picture;
@property (nonatomic, strong) NSString *imageNamed;
@property (nonatomic, strong) NSString *eventId;
@property (nonatomic, strong) NSString *appleCalId;
@property (nonatomic, strong) NSString *priceString;
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, strong) NSNumber *numClicks;
@property (nonatomic, strong) NSString *tagString;





@end

NS_ASSUME_NONNULL_END
