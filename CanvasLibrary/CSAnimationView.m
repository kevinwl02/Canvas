/*
 * This file is part of the Canvas package.
 * (c) Canvas <usecanvas@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "CSAnimationView.h"

@implementation CSAnimationView

@synthesize type = _type;
@synthesize delay = _delay;
@synthesize duration = _duration;
@synthesize distance = _distance;

- (void)awakeFromNib {
    
    if (!self.pause) {
        [self startCanvasAnimation];
    }
}

- (void)startCanvasAnimation {
    
    Class <CSAnimation> class = [CSAnimation classForAnimationType:self.type];
    
    [class performAnimationOnView:self duration:self.duration delay:self.delay distance:self.distance onFinished:^{
        [self animationDidFinish];
    }];

    [super startCanvasAnimation];
}

- (void) animationDidFinish {
    
    
}

# pragma mark - Getters

- (CSAnimationType) type {
    if(!_type)
        return _defaultAnimationType;
    return _type;
}
- (NSTimeInterval) delay {
    if(!_delay)
        return _defaultDelay;
    return _delay;
}
- (NSTimeInterval) duration {
    if(!_duration)
        return _defaultDuration;
    return _duration;
}
- (float) distance {
    if(!_distance)
        return _defaultDistance;
    return _distance;
}

# pragma mark - Default values

static CSAnimationType _defaultAnimationType = @"fadeIn";
static NSTimeInterval _defaultDelay = 0;
static NSTimeInterval _defaultDuration = 0.5;
static float _defaultDistance = 300;

+ (CSAnimationType) defaultAnimationType {
    return _defaultAnimationType;
}
+ (void) setDefaultAnimationType:(CSAnimationType)pDefaultAnimationType {
    _defaultAnimationType = pDefaultAnimationType;
}

+ (NSTimeInterval) defaultDelay {
    return _defaultDelay;
}
+ (void) setDefaultDelay:(NSTimeInterval)pDefaultDelay {
    _defaultDelay = pDefaultDelay;
}

+ (NSTimeInterval) defaultDuration {
    return _defaultDuration;
}
+ (void) setDefaultDuration:(NSTimeInterval)pDefaultDuration {
    _defaultDuration = pDefaultDuration;
}

+ (float) defaultDistance {
    return _defaultDistance;
}
+ (void) setDefaultDistance: (float) pDefaultDistance {
    _defaultDistance = pDefaultDistance;
}

@end


# pragma mark - Category

@implementation UIView (CSAnimationView)

- (void)startCanvasAnimation {
    [[self subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj startCanvasAnimation];
    }];
}

@end
