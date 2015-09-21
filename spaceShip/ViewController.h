//
//  ViewController.h
//  spaceShip
//
//  Created by Sathish Chinniah on 13/09/15.
//  Copyright (c) 2015 Sathish Chinniah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    IBOutlet UIImageView *friendlyShip;
    IBOutlet UIImageView *enemyShip;
    IBOutlet UIImageView *motherShip;
   
    IBOutlet UIImageView *missile;
    
    IBOutlet UILabel *livesLabel;


    IBOutlet UILabel *scoreLabel;
    
    IBOutlet UIButton *startButton;
    UITouch *touch;
    
    NSString *liveString;
    NSString *scoreString;
    
    NSTimer *enemyMovementTimer;
    NSTimer *missileMovementTimer;
}
-(IBAction)startGame:(id)sender;
@end

