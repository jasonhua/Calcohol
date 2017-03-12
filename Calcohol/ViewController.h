//
//  ViewController.h
//  Calcohol
//
//  Created by Jason Hua on 7/12/15.
//  Copyright (c) 2015 JJSports. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UnityAds/UnityAds.h>

@interface ViewController : UIViewController <UITextFieldDelegate,UnityAdsDelegate>

@property (weak, nonatomic) UITextField *beerPercentageTextField;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *resultLabel;

- (void)buttonPressed: (UIButton *)sender;

@end

