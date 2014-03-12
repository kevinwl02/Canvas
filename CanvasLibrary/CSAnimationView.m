/*
 * This file is part of the Canvas package.
 * (c) Canvas <usecanvas@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "CSAnimationView.h"

@implementation CSAnimationView

- (void)awakeFromNib {
    
    [self setDefaultValues];
    
    if (!self.pause) {
        [self startCanvasAnimation];
    }
}

- (void)setDefaultValues {
    
    if(!self.type)
        self.type = _defaultAnimationType;
    if(!self.duration)
        self.duration = _defaultDuration;
    if(!self.delay)
        self.delay = _defaultDelay;
}

- (void)startCanvasAnimation {
    
    Class <CSAnimation> class = [CSAnimation classForAnimationType:self.type];
    
    [class performAnimationOnView:self duration:self.duration delay:self.delay onFinished:^{
        [self animationDidFinish];
    }];

    [super startCanvasAnimation];
}

- (void) animationDidFinish {
    
    
}

# pragma mark - Default values

static CSAnimationType _defaultAnimationType = @"fadeIn";
static NSTimeInterval _defaultDelay = 0;
static NSTimeInterval _defaultDuration = 0.5;

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

@end


# pragma mark - Category

@implementation UIView (CSAnimationView)

- (void)startCanvasAnimation {
    [[self subviews] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj startCanvasAnimation];
    }];
}

@end
