//
//  StoreController.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/21.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "StoreController.h"
#import "StoreView.h"
#import "CalculateController.h"
#import "NetworkManager.h"
#import "StoreModel.h"
#import "NetworkManager+Method.h"
@interface StoreController ()<ButtonDelegate,UIScrollViewDelegate>

@property (nonatomic) NSInteger page;
@property (nonatomic, strong) NSMutableDictionary *storeDic;
@property (nonatomic, strong) CalculateController *calculateController;

@end

@implementation StoreController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.storeView = [[StoreView alloc] initWithFrame:self.view.frame ImageArray:self.testArray];
    self.view = self.storeView;
    self.storeView.delegate = self;
    self.storeView.baseScrollView.delegate = self;
    self.storeDic = [[NSMutableDictionary alloc] initWithObjects:@[@"我愛明禎",@"我超愛明禎",@"我無敵愛明禎"] forKeys:@[@"0",@"1",@"2"]];
    [self.storeView.confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    self.storeView.storeLabel.text = [NSString stringWithFormat:@"%@",[StoreModel shareInstance].storeNameArray[0]];

    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    self.page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.storeView.basePageControl.currentPage = self.page;
    self.storeView.storeLabel.text = [NSString stringWithFormat:@"%@",[StoreModel shareInstance].storeNameArray[self.page]];
}

- (void) confirmAction {
    [[NetworkManager initInstaceWithServerDomain:@"http://172.17.140.75:3000"] requestURL:[NSString stringWithFormat:@"/api/store/%@",[StoreModel shareInstance].storeIdArray[self.page]] method:RequestGetType parameters:nil success:^(id responseObject) {
        self.calculateController = [[CalculateController alloc] init];
        self.calculateController.storeId = [[StoreModel shareInstance].storeIdArray[self.page] integerValue];
        [self.navigationController pushViewController:self.calculateController animated:YES];

    }];
}

- (void) buttonTrigger:(id)trigger button:(UIButton *)button {
    switch (button.tag) {
        case 100:
            [self backAction];
            break;
        case 101:
            [self homeAction];
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
    CGRect frame = CGRectMake(pageValue * self.storeView.baseScrollView.frame.size.width, 0, self.storeView.baseScrollView.frame.size.width, self.storeView.baseScrollView.frame.size.height);
    [self.storeView.baseScrollView scrollRectToVisible:frame animated:YES];
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
