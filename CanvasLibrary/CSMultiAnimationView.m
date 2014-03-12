//
//  CSMultiAnimationView.m
//  Canvas
//
//  Created by Kevin on 11/03/14.
//  Copyright (c) 2014 Kevin. All rights reserved.
//

#import "CSMultiAnimationView.h"
#import "CSAnimationView.h"

@interface CSMultiAnimationView()

@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *delayArray;
@property (nonatomic, strong) NSArray *durationArray;
@property (nonatomic, strong) NSArray *distanceArray;
@property (nonatomic) int animationIterator;

@end

@implementation CSMultiAnimationView

NSString * const kElementSeparator = @";";
NSString * const kSubelementSeparator = @":";

- (void)awakeFromNib {
    
    if (!self.pause) {
        [self startCanvasAnimation];
    }
}

- (void)startCanvasAnimation {
    
    self.animationIterator = 0;
    
    [self performAnimation];

    [super startCanvasAnimation];
}

- (void) performAnimation {
    
    if (self.animationIterator >= self.typeArray.count)
        return;
    
    Class <CSAnimation> class = [CSAnimation classForAnimationType:[self getTypeForIndex:self.animationIterator]];
    
    NSArray *distance2D = [self getDistanceComponentsForIndex:self.animationIterator];
    if (distance2D != nil) {
        [class performAnimationOnView:self
                             duration:[self getDurationForIndex:self.animationIterator]
                                delay:[self getDelayForIndex:self.animationIterator]
                             distanceX:[[distance2D objectAtIndex:0] floatValue]
                            distanceY:[[distance2D objectAtIndex:1] floatValue]
                           onFinished:^{
                               [self performAnimation];
                           }];
    }
    else {
        [class performAnimationOnView:self
                             duration:[self getDurationForIndex:self.animationIterator]
                                delay:[self getDelayForIndex:self.animationIterator]
                             distance:[self getDistanceForIndex:self.animationIterator]
                           onFinished:^{
                               [self performAnimation];
                           }];
    }
    
    self.animationIterator ++;
}

# pragma mark - Setters

- (void) setType:(NSString *)type {
    self.typeArray = [[self cleanInputString: type] componentsSeparatedByString:kElementSeparator];
}
- (void) setDelay:(NSString *)delay {
    self.delayArray = [delay componentsSeparatedByString:kElementSeparator];
}
- (void) setDuration:(NSString *)duration {
    self.durationArray = [duration componentsSeparatedByString:kElementSeparator];
}
- (void) setDistance:(NSString *)distance {
    self.distanceArray = [distance componentsSeparatedByString:kElementSeparator];
}

# pragma mark - Array getters

- (NSString*) getTypeForIndex: (int) index {
    
    if (!self.typeArray || index >= self.typeArray.count)
        return CSAnimationView.defaultAnimationType;
    
    return [self.typeArray objectAtIndex:index];
}
- (NSTimeInterval) getDelayForIndex: (int) index {
    
    if (!self.delayArray || index >= self.delayArray.count)
        return CSAnimationView.defaultDelay;
    
    return [[self.delayArray objectAtIndex:index] doubleValue];
}
- (NSTimeInterval) getDurationForIndex: (int) index {
    
    if (!self.durationArray || index >= self.durationArray.count)
        return CSAnimationView.defaultDuration;
    
    return [[self.durationArray objectAtIndex:index] doubleValue];
}
- (float) getDistanceForIndex: (int) index {
    
    if (!self.distanceArray || index >= self.distanceArray.count)
        return CSAnimationView.defaultDistance;
    
    NSString *distance = [self.distanceArray objectAtIndex:index];
    return [distance floatValue];
}
- (NSArray *) getDistanceComponentsForIndex: (int) index {
    if (!self.distanceArray || index >= self.distanceArray.count)
        return nil;
    
    NSString *distance = [self.distanceArray objectAtIndex:index];
    if ([distance rangeOfString:kSubelementSeparator].location == NSNotFound)
        return nil;
    
    return [distance componentsSeparatedByString:kSubelementSeparator];
}

# pragma mark - String input cleaning

- (NSString *) cleanInputString: (NSString*) inputString {
    
    inputString = [inputString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return inputString;
}

@end
