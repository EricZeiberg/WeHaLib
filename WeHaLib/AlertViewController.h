//
//  AlertViewController.h
//  WeHaLib
//
//  Created by Eric Zeiberg on 7/11/17.
//  Copyright © 2017 Eric Zeiberg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UIView *popupView;

@end
