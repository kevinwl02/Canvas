//
//  CSMultiAnimationView.h
//  Canvas
//
//  Created by Kevin on 11/03/14.
//  Copyright (c) 2014 Kevin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSAnimation.h"

@interface CSMultiAnimationView : UIView

@property (nonatomic, copy) NSString *delay;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic) BOOL pause;  // If set, animation wont starts on awakeFromNib

- (void)startCanvasAnimation;

@end