//
//  ViewController.m
//  My Clicks
//
//  Created by Md. Kamrujjaman Akon on 12/9/16.
//
//

#import "ViewController.h"

#define GAP     12
#define HEIGHT  100
#define WIDTH   100

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    imageList = [[NSMutableArray alloc] init];

    [self generateImageList];
    [self createMyGallery];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) generateImageList
{
    NSString *imagePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingString:@"/MyClicks"];
    NSArray* imgList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imagePath error:NULL];

    for (int i=0; i<[imgList count]; i++)
    {
        NSString *imgPath = [imagePath stringByAppendingFormat:@"/%@",imgList[i]];
        [imageList addObject:[UIImage imageWithContentsOfFile:imgPath]];
    }
}

-(void) createMyGallery
{
    int x, y;

    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 70, 350, 580)];

    myScrollView.showsVerticalScrollIndicator = YES;
    myScrollView.pagingEnabled = YES;
    myScrollView.directionalLockEnabled = YES;
    myScrollView.bounces = YES;
    myScrollView.userInteractionEnabled = YES;
    [myScrollView setCanCancelContentTouches:YES];

    [self.view addSubview:myScrollView];

    x = GAP; y = GAP;

    for (int i=0; i<[imageList count]; i++) {
        myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, WIDTH, HEIGHT)];
        myImageView.image = imageList[i];
        myImageView.userInteractionEnabled=YES;
        myImageView.multipleTouchEnabled=YES;
        myImageView.tag = i;

        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchImage:)];
        [tapRecognizer setNumberOfTouchesRequired:1];
        [myImageView addGestureRecognizer:tapRecognizer];

        [myScrollView addSubview:myImageView];

        x = x + WIDTH + GAP;

        if (i != 0 && i%3 == 2) {
            x = GAP;
            y = y + HEIGHT + GAP;
        }
    }

    [myScrollView setContentSize:CGSizeMake(x ,y)];
}

- (void)onTouchImage:(UITapGestureRecognizer *)recognizer
{
    UIImageView *curImg = (UIImageView *)[recognizer view];
    int imgNumber = (int) curImg.tag;
    NSLog(@"%d",imgNumber);

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 350, 330)];
    imageView.image = imageList[imgNumber];

    myScrollView.hidden = YES;
    self.myView.hidden = NO;
    self.btnBack.hidden = NO;

    self.myView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);

    [UIView animateWithDuration:0.3/1.5 animations:^{
        self.myView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            self.myView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                self.myView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];

    [self.myView addSubview:imageView];

}


- (IBAction)btnBackAction:(id)sender {

    myScrollView.hidden = NO;
    self.myView.hidden = YES;
}
@end
