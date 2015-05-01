//
//  ComicViewController.m
//  StatefulTableViewDemo
//
//  Created by Rob Booth on 5/1/15.
//  Copyright (c) 2015 Rob Booth. All rights reserved.
//

#import "ComicViewController.h"

@interface ComicViewController ()

@property (strong, nonatomic) IBOutlet UIImageView * imageView;
@property (strong, nonatomic) IBOutlet UILabel * label;

@end

@implementation ComicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = self.comicData[@"title"];
    self.label.text = self.comicData[@"description"];
    [self getImage];    
}

- (void)getImage
{
    NSString * imagePath = self.comicData[@"thumbnail"][@"path"];
    imagePath = [imagePath stringByAppendingString:@"/portrait_incredible."];
    imagePath = [imagePath stringByAppendingString:self.comicData[@"thumbnail"][@"extension"]];
    NSURL * imageURL = [NSURL URLWithString:imagePath];
    
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakSelf.imageView setImage:image];
        });
    });
}

@end
