//
//  ViewController.m
//  Calcohol
//
//  Created by Jason Hua on 7/12/15.
//  Copyright (c) 2015 JJSports. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UITextField *numOfBeers;
@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation ViewController

- (void)loadView {
    // allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    // allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc]init];
    UISlider *slider = [[UISlider alloc]init];
    UILabel *label = [[UILabel alloc]init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];

    //add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    //assign the views and gesture recognizer to our properties
    self.beerPercentageTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}

- (void)viewDidLoad {
    //calls the superclass's implementation
    [super viewDidLoad];
    [UnityAds initialize:@"1343083" delegate:self];
    // Do any additional setup after loading the view, typically from a nib.
    
    //set our primary view's background color to lightGrayColor
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //tells the textfield that 'self'.  this instance of 'ViewController' should be treated as the text field's delegate
    self.beerPercentageTextField.delegate = self;
    
    //set the placeholder text
    self.beerPercentageTextField.placeholder = NSLocalizedString(@"% Alcohol Content per Beer", @"Beer percent placeholder text");
    
    // tells 'self.beerCountSlider' that when its value changes, it should call '[self -sliderValueDidChange:];.
    // this is equal to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    //set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // tells 'self.calculateButton' that when a finger is lifted from the button while still inside it's bounds, to call '[self -buttonPressed:]'
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    // tell the tap gesture recognizer to call '[self -tapGestureDidFire:]' when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    CGFloat viewWidth = 320;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.beerPercentageTextField.frame = CGRectMake(padding, padding, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentageTextField.frame);
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth, itemHeight * 4);
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender {

    // Make sure the text is a number
    
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // if user typed 0 or something that's NaN, clear the field
        sender.text = nil;
    }
    
}

- (void)sliderValueDidChange:(UISlider *)sender {
    
    //Need to create a drinkNumber text to have slider visually functional
    
    NSLog(@"Slider value changed to %f", sender.value);
    
    if (sender == _beerCountSlider) {
        _numOfBeers.text = [NSString stringWithFormat:@"%03f", _beerCountSlider.value];
    }
    
    //[self.beerPercentageTextField resignFirstResponder];
    

}

- (void)buttonPressed:(UIButton *)sender {

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

- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {

}

- (void)unityAdsReady:(NSString *)placementId{
}

- (void)unityAdsDidError:(UnityAdsError)error withMessage:(NSString *)message{
}

- (void)unityAdsDidStart:(NSString *)placementId{
}

- (void)unityAdsDidFinish:(NSString *)placementId withFinishState:(UnityAdsFinishState)state{
}



@end
