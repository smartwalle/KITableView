//
//  KITableViewAction.h
//  KITableView
//
//  Created by apple on 16/11/18.
//  Copyright © 2016年 SmartWalle. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KITableViewActionType) {
    KITableViewActionTypeOfInsertion   = 0x01,
    KITableViewActionTypeOfRemoval     = 0x02,
    KITableViewActionTypeOfReplacement = 0x03
};

@interface KITableViewAction : NSObject

@property (nonatomic, assign) KITableViewActionType   type;
@property (nonatomic, assign) UITableViewRowAnimation animation;
@property (nonatomic, strong) NSArray *oldIndexes;
@property (nonatomic, strong) NSArray *indexes;

@end
