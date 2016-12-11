//
//  ViewController.h
//  My Clicks
//
//  Created by Md. Kamrujjaman Akon on 12/9/16.
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UIScrollView *myScrollView;
    UIImageView *myImageView;
    NSMutableArray <UIImage *> *imageList;
}
@property (strong, nonatomic) IBOutlet UIView *btnBack;

@property (weak, nonatomic) IBOutlet UIView *myView;
- (IBAction)btnBackAction:(id)sender;
@end

