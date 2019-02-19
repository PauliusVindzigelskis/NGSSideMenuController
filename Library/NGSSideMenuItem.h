//
//  NGSSideMenuItem.h
//  DoodleDraw
//
//  Created by Vindziukai on 02/06/2017.
//  Copyright © 2017 Paulius Vindzigelskis. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NGSSideMenuItem <NSObject, NSCopying>
    @property (nonatomic, assign, readonly) CGSize size;
    
@end
