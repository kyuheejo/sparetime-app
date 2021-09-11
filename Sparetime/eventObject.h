//
//  eventObject.h
//  Sparetime
//
//  Created by Brian Fisher on 2/25/20.
//  Copyright © 2020 Brian Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface eventObject : NSObject<NSCoding>
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSDate *start;
@property (nonatomic, strong) NSDate *end;

@end

NS_ASSUME_NONNULL_END
