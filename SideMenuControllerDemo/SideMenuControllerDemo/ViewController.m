//
//  ViewController.m
//  SideMenuControllerDemo
//
//  Created by Vindzigelskis, Paulius on 2/19/19.
//  Copyright © 2019 New Guy Studio. All rights reserved.
//

#import "ViewController.h"

#import <NGSSideMenuController/NGSSideMenuController.h>

@interface ViewController ()
    @property (strong, nonatomic) IBOutlet UIButton *showAllButton;
    @property (strong, nonatomic) IBOutlet UIButton *showMiddleButton;
    
    @property (nonatomic, strong) NGSSideMenuController *sideMenu;
    
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sideMenu = [[NGSSideMenuController alloc] init];
    self.sideMenu.presentingView = self.view;
    self.sideMenu.startOffset = 100.f;
    self.sideMenu.itemSpacing = 5.f;
    self.sideMenu.interItemShowDelay = 0.1f;
}

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    self.sideMenu.position = sender.selectedSegmentIndex;
}
- (IBAction)addItemPressed:(id)sender {
    
    NSString *itemTitle = [NSString stringWithFormat:@"Item No. %li", self.sideMenu.items.count + 1];
    NGSSideMenuItemAction *action = [NGSSideMenuItemAction actionWithTitle:itemTitle image:nil size:CGSizeZero handler:^(NGSSideMenuItemAction * _Nonnull a) {
        [self.sideMenu hideItem:a animated:YES];
    }];
    [action setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sideMenu addItem:action];
    [self.sideMenu showItem:action animated:YES];
    NSLog(@"%@", action.debugDescription);
}
    
- (IBAction)showHideAllPressed:(UIButton*)sender {
    BOOL shouldShow = sender.tag == 0;
    if (shouldShow)
    {
        [self.sideMenu showAllAnimated:YES];
        [_showAllButton setTitle:@"Hide All" forState:UIControlStateNormal];
        [_showMiddleButton setTitle:@"Hide All but middle" forState:UIControlStateNormal];
    } else {
        [self.sideMenu hideAllAnimated:YES];
        [_showAllButton setTitle:@"Show All" forState:UIControlStateNormal];
        [_showMiddleButton setTitle:@"Show Middle" forState:UIControlStateNormal];
    }
    sender.tag = 1 - sender.tag;
    _showMiddleButton.tag = sender.tag;
    
}
    
- (IBAction)showHideMiddlePressed:(UIButton*)sender {
    BOOL shouldShow = sender.tag == 0;
    if (shouldShow)
    {
        NSInteger middleIndex = 0;
        NSArray *allItems = self.sideMenu.items;
        if (allItems.count > 1)
        {
            middleIndex = allItems.count / 2;
        }
        UIView<NGSSideMenuItem>* item = allItems[middleIndex];
        
        [self.sideMenu showItem:item animated:YES];
        [_showAllButton setTitle:@"Hide All" forState:UIControlStateNormal];
        [_showMiddleButton setTitle:@"Hide All but middle" forState:UIControlStateNormal];
        
        sender.tag = 1 - sender.tag;
        _showAllButton.tag = sender.tag;
    } else {
        NSArray *presentedItems = self.sideMenu.presentedItems;
        if (presentedItems.count > 1)
        {
            NSInteger middleIndex = presentedItems.count / 2;
            UIView<NGSSideMenuItem>* item = presentedItems[middleIndex];
            [self.sideMenu hideAllExceptItem:item animated:YES];
        } else {
            //one item is showing. nothing to hide
        }
    }
    
}
    
@end
