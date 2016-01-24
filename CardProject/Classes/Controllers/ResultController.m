//
//  ResultController.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "ResultController.h"
#import "ResultView.h"
#import "CardCell.h"

@interface ResultController ()<UITableViewDataSource,UITableViewDelegate,ButtonDelegate>

@end

@implementation ResultController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.resultView = [[ResultView alloc] initWithFrame:self.view.frame];
    self.view = self.resultView;
    [self.resultView showBaseTableView];
    self.resultView.delegate = self;
    self.resultView.baseTableView.delegate = self;
    self.resultView.baseTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 5;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cellIdentifier";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier type:1];
    }
    cell.textLabel.text = @"ads";
    cell.backgroundColor =  (indexPath.row == 0) ? [UIColor brownColor] : [UIColor blueColor];
    
    return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.frame.size.height / 3;
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
