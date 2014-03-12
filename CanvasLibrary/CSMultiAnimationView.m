/*
 * This file is part of the Canvas package.
 * (c) Canvas <usecanvas@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "CSMultiAnimationView.h"
#import "CSAnimationView.h"

@interface CSMultiAnimationView()

@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *delayArray;
@property (nonatomic, strong) NSArray *durationArray;
@property (nonatomic) int animationIterator;

@end

@implementation CSMultiAnimationView

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
    
    [class performAnimationOnView:self
                         duration:[self getDurationForIndex:self.animationIterator]
                            delay:[self getDelayForIndex:self.animationIterator]
                       onFinished:^{
        [self performAnimation];
    }];
    
    self.animationIterator ++;
}

# pragma mark - Setters

- (void) setType:(NSString *)type {
    self.typeArray = [type componentsSeparatedByString:@";"];
}
- (void) setDelay:(NSString *)delay {
    self.delayArray = [delay componentsSeparatedByString:@";"];
}
- (void) setDuration:(NSString *)duration {
    self.durationArray = [duration componentsSeparatedByString:@";"];
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

@end
