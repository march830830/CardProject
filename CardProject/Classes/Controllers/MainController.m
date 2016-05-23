//
//  MainController.m
//  CardProject
//
//  Created by 陳泓諺 on 2015/12/3.
//  Copyright © 2015年 陳泓諺. All rights reserved.
//

#import "MainController.h"
#import "MainView.h"
#import "RecordController.h"
#import "StoreController.h"
#import "NetworkManager.h"
#import "StoreModel.h"

@interface MainController ()<ButtonDelegate,UIScrollViewDelegate>

@property (nonatomic) NSInteger page;
@property (nonatomic, strong) StoreController *storeController;
@property (nonatomic, strong) RecordController *recordController;

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
    self.testArray = [NSMutableArray array];
    self.mainView = [[MainView alloc] initWithFrame:self.view.frame];
    self.view = self.mainView;
    self.mainView.delegate = self;
    self.mainView.baseScrollView.delegate = self;
    
//    self.navigationController.navigationBar.alpha = 0.0;
    self.navigationController.navigationBarHidden = YES;
//    
    [[NetworkManager initInstaceWithServerDomain:@"http://163.17.136.88:5566"] requestURL:@"/api/ad" method:RequestGetType parameters:nil success:^(id responseObject) {
    
        
        for (id object in responseObject[@"data"]) {
            NSString *picString  = object[@"image"];
            NSURL *picURL = [NSURL URLWithString:picString];
            NSData *picData = [NSData dataWithContentsOfURL:picURL];
            [self.testArray addObject:picData];
        }
//
        
        [self.mainView setScrollViewWithArray:self.testArray];
        self.mainView.baseScrollView.delegate = self;
//        NSString *picString = responseObject[@"data"][0][@"image"];
//
        
        
    }];

    
    
    
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
            [[NetworkManager initInstaceWithServerDomain:@"http://163.17.136.88:5566"] requestURL:@"/api/store" method:RequestGetType parameters:nil success:^(id responseObject) {
                if (responseObject) {
                    [[StoreModel shareInstance].storeDic setDictionary:(NSDictionary*)responseObject];
                    for (id object in [StoreModel shareInstance].storeDic[@"data"]) {
                        NSString *picString  = [NSString stringWithFormat:@"http://163.17.136.88:5566/img/%@",object[@"image"]];
                        NSURL *picURL = [NSURL URLWithString:picString];
                        NSData *picData = [NSData dataWithContentsOfURL:picURL];
                        [self.storeController.testArray addObject:picData];
                        [[StoreModel shareInstance].storeNameArray addObject:object[@"name"]];
                        [[StoreModel shareInstance].storeIdArray addObject:object[@"id"]];
//                        NSLog(@"%@",responseObject[@"data"]);

                    }
                [self.navigationController pushViewController:self.storeController animated:YES];
                }
            }];
    }
           
            break;
        case 1:
            NSLog(@"aa");
            break;
        case 2:
            self.recordController = [[RecordController alloc] init];
            self.databaseModel = [[DatabaseModel alloc] init];
            NSLog(@"111%@",[self.databaseModel readDataBase:@"VALUE"]);
            NSLog(@"222%@",[self.databaseModel readDataBase:@"DATA"]);
            NSLog(@"333%@",[self.databaseModel readDataBase:@"DATE"]);
            NSLog(@"----%ld",(long)[self.databaseModel countNum]);
            [self.navigationController pushViewController:self.recordController animated:YES];
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
