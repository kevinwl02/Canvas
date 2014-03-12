/*
 * This file is part of the Canvas package.
 * (c) Canvas <usecanvas@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <UIKit/UIKit.h>
#import "CSAnimation.h"

@interface CSMultiAnimationView : UIView

@property (nonatomic, copy) NSString *delay;
@property (nonatomic, copy) NSString *duration;
@property (nonatomic, copy) NSString *type;
@property (nonatomic) BOOL pause;  // If set, animation wont starts on awakeFromNib

@end