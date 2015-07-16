//
//  ViewController.m
//  Calcohol
//
//  Created by Jason Hua on 7/12/15.
//  Copyright (c) 2015 JJSports. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *beerPercentageTextField;
@property (weak, nonatomic) IBOutlet UISlider *beerCountSlider;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)textFieldDidChange:(UITextField *)sender {

    // Make sure the text is a number
    
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // if user typed 0 or something that's NaN, clear the field
        sender.text = nil;
    }
    
}

- (IBAction)sliderValueDidChange:(UISlider *)sender {

    NSLog(@"Slider value changed to %f", sender.value);
    
    //[self.beerPercentageTextField resignFirstResponder];
    
}

- (IBAction)buttonPressed:(UIButton *)sender {

    [self.beerPercentageTextField resignFirstResponder];
    
    // first, calculate how much alcohol is in all beers
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 20; // 20 ounces in one pint bar glass
    
    float alcoholPercentageOfBeer = [self.beerPercentageTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now calculate the equivalent amount of wine
    
    float ouncesInOneWineGlass = 5; // Typical wine glasses are usually 5 oz
    float alcoholPercentageOfWine = 0.13; // 13% is the average alcohol percentage
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer" or "beers" and "glass" or "glasses" in response
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // Generate the result text and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.",nil), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
}

- (IBAction)tapGestureDidFire:(UITapGestureRecognizer *)sender {

    //[self.beerPercentageTextField resignFirstResponder];
}

@end
