//
//  CalculateController.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/21.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "CalculateController.h"
#import "CalculateView.h"
#import "CardCell.h"
#import "ResultController.h"
#import "SelectController.h"
#import "NetworkManager.h"
#import "CardsModel.h"

@interface CalculateController () <ButtonDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) ResultController *resultController;
@property (nonatomic, strong) SelectController *selectController;

@end

@implementation CalculateController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"CARD:%@",[CardsModel shareInstance].cardsArray);
    [self.calculateView.baseTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%d",self.storeId);
    
    self.calculateView = [[CalculateView alloc] initWithFrame:self.view.frame];
    self.view = self.calculateView;
    [self.calculateView showBaseTableView];
    
    self.calculateView.baseTableView.delegate = self;
    self.calculateView.baseTableView.dataSource = self;
    self.calculateView.delegate = self;
    [self.calculateView.addButton addTarget:self action:@selector(addCardAction) forControlEvents:UIControlEventTouchUpInside];
    [self.calculateView.calButton addTarget:self action:@selector(calAction) forControlEvents:UIControlEventTouchUpInside];


    
}

- (void) addCardAction {
    self.selectController = [[SelectController alloc] init];
    [self.navigationController pushViewController:self.selectController animated:YES];
}

- (void) calAction {
//    if ([self.calculateView.totalField.text isEqualToString:@""]) {
//        NSLog(@"asadsd");
//    }
    
    //    NSLog(@"%@",self.calculateView.totalField.text);
    
    //    NSDictionary *parameters = @{@"store_id":@"1",@"price":@"10000",@"card":@[@{@"id":@"1",@"sum":@"2"},@{@"id":@"2",@"sum":@"1"}]};
    //
    //    [[NetworkManager initInstaceWithServerDomain:@"http://172.17.140.75:3000"] requestURL:@"/api/opration" method:RequestPostType parameters:parameters success:^(id responseObject) {
    //        NSLog(@"adsasd%@",responseObject);
    //
    //    }];
    
    self.resultController = [[ResultController alloc] init];
    [self.navigationController pushViewController:self.resultController animated:YES];
    
}

- (void) buttonTrigger:(id)trigger button:(UIButton *)button {
    switch (button.tag) {
        case 100:
            [self backAction];
            break;
        case 101:
            [self homeAction];
            break;
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [CardsModel shareInstance].cardsArray.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cellIdentifier";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier type:0];
    }
    cell.textLabel.text = @"ads";
    cell.backgroundColor =  (indexPath.row == 0) ? [UIColor brownColor] : [UIColor blueColor];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.frame.size.height / 3;
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
