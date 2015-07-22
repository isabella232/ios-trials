//
//  ViewController.m
//  trials1
//
//  Created by patrick debois on 21/07/15.
//  Copyright (c) 2015 patrick debois. All rights reserved.
//

#import "ViewController.h"
#import "NSUserDefaults+GroundControl.h"

#import "NSBundle+Remote.h"
#import "NMRemoteStrings.h"

@interface ViewController ()
@end

@implementation ViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)init
{
    NSLog(@"do we ever get here");
    
    NSBundle *bundle = [NSBundle mainRemoteBundle];
    
    if (!bundle)
    {
        NSLog(@"no bundle found, falling back to default gui ...");
        return [self initWithNibName:nil bundle:nil];
    }
    
    NSString *nibName = NSStringFromClass([self class]);
    NSLog(@"Loading nibName %@",nibName);
    return [self initWithNibName:nibName bundle:bundle];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.button1 setTitle:@"pushme" forState:UIControlStateNormal];
    
    NSString *bundleText = NMRemoteLocalizedString(@"welcome", @"The Welcome message");
    [self.label1 setText:bundleText];

     NSBundle *remoteBundle = [NSBundle mainRemoteBundle];
    
    if (remoteBundle) {
        NSLog(@"Found remote bundle at %@", [remoteBundle resourcePath]);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)doit:(id)sender {
    
    NSLog(@"got it");
    
    
    // Now reset the tests
    NSString *newBundleText = NMRemoteLocalizedString(@"welcome", @"The Welcome message");
    [self.label1 setText:newBundleText];
    NSBundle *remoteBundle = [NSBundle mainRemoteBundle];
    
    NSString * resourcePath = [remoteBundle resourcePath];
    NSLog(@"Remote bundle path - %@",resourcePath);
    
    
    NSError * error;
    NSArray * directoryContents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:resourcePath error:&error];
 
    NSLog(@"The content of bundle is%@",directoryContents);
    
    NSString *imagePath = [remoteBundle pathForResource:@"zapp-npologo-1024x1024" ofType:@"png"];
    UIImage* image = [UIImage imageWithContentsOfFile:imagePath];
    
    [self.imageView1 setImage:image];
    
}

// https://github.com/calebd/neptune/blob/master/Neptune/NSUserDefaults%2BNeptune.m
// https://github.com/aporat/NSUserDefaults-InitialValues
// https://github.com/mattt/GroundControl

- (IBAction)doit2:(id)sender {
    NSLog(@"got it");
    [self.label1 setText:@"lalal"];
    
    // [NSUserDefaultsDidChangeNotification]
    // http://stackoverflow.com/questions/10871860/nsuserdefaultsdidchangenotification-whats-the-name-of-the-key-that-changed
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:@"bla" forKey:@"age"];
    [defaults synchronize];
    
    // https://github.com/mattt/rack-remote-configuration
    
    // https://github.com/iksnae/Konfig
    
    [defaults objectForKey:@"age"];
    
    // http://stackoverflow.com/questions/1676938/easy-way-to-see-saved-nsuserdefaults
    
    NSLog(@"DDD - %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);

    NSURL *URL = [NSURL URLWithString:@"http://localhost:8000/defaults.plist"];
    [[NSUserDefaults standardUserDefaults] registerDefaultsWithURL:URL
                                                           success:^(NSDictionary *thedictionary) {

                                                               NSLog(@"DDD2 - %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);

                                                               
                                                           } failure:^(NSError *theerror) {
                        NSLog(@"%@",[theerror localizedDescription]);
                                                               // ...
    }];
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *folder = [path objectAtIndex:0];
    NSLog(@"Your NSUserDefaults are stored in this folder: %@/Preferences", folder);

}

@end
