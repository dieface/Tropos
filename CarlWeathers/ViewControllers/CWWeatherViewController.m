#import "CWWeatherViewController.h"
#import "CWWeatherController.h"
#import "CWWeatherViewModel.h"
#import "CWLocationController.h"
#import "CWPrecipitationMeterView.h"

@interface CWWeatherViewController ()

@property (nonatomic) CWWeatherController *controller;

@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdatedLabel;
@property (weak, nonatomic) IBOutlet UIImageView *conditionsImageView;
@property (weak, nonatomic) IBOutlet UILabel *conditionsDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *highLowTemperatureLabel;
@property (weak, nonatomic) IBOutlet UIImageView *windSpeedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *temperatureImageView;
@property (weak, nonatomic) IBOutlet CWPrecipitationMeterView *precipitationMeterView;

@end

@implementation CWWeatherViewController

#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.controller = [CWWeatherController new];
    [self.KVOController observe:self.controller keyPath:@"viewModel" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) action:@selector(controllerDidChange:object:)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refresh];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Actions

- (IBAction)refresh
{
    [self.controller updateWeather];
}

#pragma mark - Private

- (void)controllerDidChange:(NSDictionary *)changes object:(CWWeatherController *)controller
{
    self.cityLabel.text = controller.viewModel.locationName;
    self.lastUpdatedLabel.text = controller.viewModel.formattedDate;
    self.conditionsImageView.image = controller.viewModel.conditionsImage;
    self.highLowTemperatureLabel.text = controller.viewModel.formattedTemperatureRange;
    self.windSpeedLabel.text = controller.viewModel.formattedWindSpeed;
    self.conditionsDescriptionLabel.attributedText = controller.viewModel.attributedTemperatureComparison;
    self.precipitationMeterView.precipitationProbability = controller.viewModel.precipitationProbability;
}

@end
