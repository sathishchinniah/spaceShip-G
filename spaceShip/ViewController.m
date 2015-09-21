//
//  ViewController.m
//  spaceShip
//
//  Created by Sathish Chinniah on 13/09/15.
//  Copyright (c) 2015 Sathish Chinniah. All rights reserved.
//
#import "ViewController.h"

@interface ViewController ()

@end
int score;
int lives;
int enemyPosition;
int enemyAttackOccurance;
int randomSpeed;
float spedOfEnemy;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated {
    
    //imgs to be hidden
    friendlyShip.hidden = YES;
    enemyShip.hidden = YES;
    missile.hidden = YES;
    motherShip.hidden = YES;
    
    //label hidden
    scoreLabel.hidden = YES;
    livesLabel.hidden = YES;
    
    //set score and lives
    score = 0;
    lives = 3;
    
    //string
    scoreString =[NSString stringWithFormat:@"SCORE: 0"];
    liveString =[NSString stringWithFormat:@"LIVES: 0"];
  
//initial label text
    
    scoreLabel.text = scoreString;
    livesLabel.text = liveString;
    //position of images
    friendlyShip.center = CGPointMake(140, 400);
    enemyShip.center = CGPointMake(140, -40);
    missile.center = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
    motherShip.layer.cornerRadius = 75;
    
    
    
    
}
-(IBAction)startGame:(id)sender {
    startButton.hidden = YES;
    //show images
    friendlyShip.hidden = NO;
    enemyShip.hidden = NO;
    motherShip.hidden = NO;
    
    //display label
    scoreLabel.hidden = NO;
    livesLabel.hidden = NO;
    [self positionEnemy];
    
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    friendlyShip.center =CGPointMake(point.x, friendlyShip.center.y);
    
    
    
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [missileMovementTimer invalidate];
    missile.hidden = NO;
    missile.center  = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
    missileMovementTimer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(missileMovement) userInfo:nil repeats:YES];
}
-(void)positionEnemy {
    
    //random enemy position
    enemyPosition = arc4random() % 249;
    enemyPosition = enemyPosition + 20;
    
    //set enemy image location
    
    enemyShip.center = CGPointMake(enemyPosition, -40);
    //set enemy speed
    randomSpeed = arc4random() %3;
    switch (randomSpeed) {
        case 0:
            spedOfEnemy = 0.03;
            break;
        case 1:
            spedOfEnemy = 0.02;
            break;
        case 2:
            spedOfEnemy = 0.01;
        default:
            break;
    }
    enemyAttackOccurance = arc4random() %5;
    [self performSelector:@selector(enemyMovementTimerMethod) withObject:nil afterDelay:enemyAttackOccurance];
    
    
}
-(void)enemyMovementTimerMethod {
    
    enemyMovementTimer = [NSTimer  scheduledTimerWithTimeInterval:spedOfEnemy target:self selector:@selector(enemyMovement) userInfo:nil repeats:YES];
    
    
}
-(void)enemyMovement {
    
    enemyShip.center = CGPointMake(enemyShip.center.x, enemyShip.center.y + 2);
    if (CGRectIntersectsRect(enemyShip.frame, motherShip.frame)) {
        
        lives  = lives - 1;
        liveString =[NSString stringWithFormat:@"Lives : %i", lives];
        livesLabel.text = liveString;
        //stop enemy moving
        
        [enemyMovementTimer invalidate];
        if (lives>0) {
            [self positionEnemy];
        }
        if (lives == 0) {
            [self gameOver];
        }
    }
    
    
}
-(void)missileMovement {
    
    missile.hidden = NO;
    missile.center = CGPointMake(missile.center.x, missile.center.y - 2);
    if (CGRectIntersectsRect(missile.frame, enemyShip.frame)) {
        score = score + 5;
        scoreString = [NSString stringWithFormat:@"SCORE: %i", score];
        scoreLabel.text = scoreString;
        //stop missile
        [missileMovementTimer invalidate];
        //position missile to controll friendly ship
        missile.center = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
        missile.hidden = YES;
        //stop enemy movement
        [enemyMovementTimer invalidate];
        [self positionEnemy];
    }
    
}
-(void)gameOver {
    [enemyMovementTimer invalidate];
    [missileMovementTimer invalidate];
    [self performSelector:@selector(replayGme) withObject:nil afterDelay:3];
    
    
}
-(void)replayGme {
    startButton.hidden = NO;
    //imgs to be hidden
    friendlyShip.hidden = YES;
    enemyShip.hidden = YES;
    missile.hidden = YES;
    motherShip.hidden = YES;
    
    //label hidden
    scoreLabel.hidden = YES;
    livesLabel.hidden = YES;
    
    //set score and lives
    score = 0;
    lives = 3;
    
    //string
    scoreString =[NSString stringWithFormat:@"SCORE: 0"];
    liveString =[NSString stringWithFormat:@"LIVES: 3"];
    
    //initial label text
    
    scoreLabel.text = scoreString;
    livesLabel.text = liveString;
    //position of images
    friendlyShip.center = CGPointMake(140, 400);
    enemyShip.center = CGPointMake(140, -40);
    missile.center = CGPointMake(friendlyShip.center.x, friendlyShip.center.y);
      motherShip.layer.cornerRadius = 75;

    
}
@end
