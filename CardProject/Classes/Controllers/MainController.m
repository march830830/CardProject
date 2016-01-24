//
//  MainController.m
//  CardProject
//
//  Created by 陳泓諺 on 2015/12/3.
//  Copyright © 2015年 陳泓諺. All rights reserved.
//

#import "MainController.h"
#import "MainView.h"
#import "StoreController.h"
#import "NetworkManager.h"
#import "StoreModel.h"

@interface MainController ()<ButtonDelegate,UIScrollViewDelegate>

@property (nonatomic) NSInteger page;
@property (nonatomic, strong) StoreController *storeController;
@property (nonatomic, strong) NSMutableArray *testArray;

@end

@implementation MainController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.page = 0;
    [self updateScrollViewWithPage:self.page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testArray = [NSMutableArray arrayWithObjects:@"明禎1",@"明禎2",@"明禎3", nil];
    self.mainView = [[MainView alloc] initWithFrame:self.view.frame ImageArray:self.testArray];
    self.view = self.mainView;
    self.mainView.delegate = self;
    self.mainView.baseScrollView.delegate = self;
    
//    [[NetworkManager initInstaceWithServerDomain:@"http://172.17.140.75:3000"] requestURL:@"/api/store" method:RequestGetType parameters:nil success:^(id responseObject) {
//        NSLog(@"%@",responseObject[@"data"]);
//
//    
//            NSString *picString  = [NSString stringWithFormat:@"http://172.17.140.75:3000%@",responseObject[@"data"][0][@"images"]];
//            NSURL *picURL = [NSURL URLWithString:picString];
//            NSData *picData = [NSData dataWithContentsOfURL:picURL];
//
//        UIImageView *aaa = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 300, 300)];
//        aaa.image = [UIImage imageWithData:picData];
//        aaa.backgroundColor = [UIColor whiteColor];
//        [self.view addSubview:aaa];
//
//    }];

    
    
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
        CGFloat pageWidth = scrollView.frame.size.width;
        self.page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        self.mainView.basePageControl.currentPage = self.page;
}

- (void) buttonTrigger:(id)trigger button:(UIButton *)button {
    switch (button.tag) {
        case 0:{
            self.storeController = [[StoreController alloc] init];
            self.storeController.testArray = [NSMutableArray array];
            
            [[NetworkManager initInstaceWithServerDomain:@"http://172.17.140.75:3000"] requestURL:@"/api/store" method:RequestGetType parameters:nil success:^(id responseObject) {
//                if (responseObject) {
                    [[StoreModel shareInstance].storeDic setDictionary:(NSDictionary*)responseObject];
                    for (id object in [StoreModel shareInstance].storeDic[@"data"]) {
                        NSString *picString  = [NSString stringWithFormat:@"http://172.17.140.75:3000%@",object[@"images"]];
                        NSURL *picURL = [NSURL URLWithString:picString];
                        NSData *picData = [NSData dataWithContentsOfURL:picURL];
                        [self.storeController.testArray addObject:picData];
                        [[StoreModel shareInstance].storeNameArray addObject:object[@"name"]];
                        [[StoreModel shareInstance].storeIdArray addObject:object[@"id"]];
                        NSLog(@"%@",responseObject);

                    }
                [self.navigationController pushViewController:self.storeController animated:YES];
//                }
            }];
    }
            
            break;
        case 1:
            NSLog(@"aa");
            break;
        case 2:
            NSLog(@"aaa");
            break;
        case 3:
            NSLog(@"aaaa");
            break;
        case 10:
            if (self.page < self.testArray.count -1 ) {
                self.page  = self.page + 1;
                [self updateScrollViewWithPage:self.page];
            }
            break;
        case 11:
            if (self.page != 0) {
                self.page  = self.page - 1;
                [self updateScrollViewWithPage:self.page];
            }
            break;
    }

}

- (void) updateScrollViewWithPage:(NSInteger)pageValue {
    CGRect frame = CGRectMake(pageValue * self.mainView.baseScrollView.frame.size.width, 0, self.mainView.baseScrollView.frame.size.width, self.mainView.baseScrollView.frame.size.height);
    [self.mainView.baseScrollView scrollRectToVisible:frame animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
