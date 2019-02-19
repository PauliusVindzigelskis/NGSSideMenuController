//
//  NGSSideMenuItemAction.h
//  DoodleDraw
//
//  Created by Vindziukai on 02/06/2017.
//  Copyright © 2017 Paulius Vindzigelskis. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGSSideMenuItem.h"
NS_ASSUME_NONNULL_BEGIN

@class NGSSideMenuItemAction;
typedef void (^NGSItemHandler)(NGSSideMenuItemAction * _Nonnull);

@interface NGSSideMenuItemAction : UIButton <NGSSideMenuItem>

    @property(nonatomic, assign, readonly) CGSize size;

+ (instancetype) actionWithTitle:(nullable NSString *)title
                           image:(nullable UIImage *)image
                            size:(CGSize)size
                         handler:(nullable NGSItemHandler)handler;

@end

NS_ASSUME_NONNULL_END
