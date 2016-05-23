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
#import "CardsModel.h"
#import "DatabaseModel.h"



@interface ResultController ()<UITableViewDataSource,UITableViewDelegate,ButtonDelegate>

@property (nonatomic, strong) DatabaseModel *databaseModel;
@property(nonatomic, strong)NSString *data;
@property(nonatomic, strong)NSString *value;
@property(nonatomic, strong)NSString *operationID;


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
    [self.resultView.saveButton addTarget:self action:@selector(saveRecord) forControlEvents:UIControlEventTouchUpInside];
    self.resultView.pointLabel.text = [NSString stringWithFormat:@"總共獲得%@元禮券",self.pointString];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) saveRecord {
    self.databaseModel = [[DatabaseModel alloc] init];
    [self.databaseModel create];
//    NSLog(@"--------");
    [self.databaseModel insert:self.data :self.value :self.operationID];
}

-(void)setDBData:(InsertData *)data{
    _insertData = data;
    self.value = _insertData.insertValue;
    self.data = _insertData.insertData;
    self.operationID = _insertData.insertOperationID;
//    NSLog(@"----幹-%@",self.data);
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
    return [self.resultDic[@"id"] count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"cellIdentifier";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier type:1];
    }
//    NSLog(@"%@",self.resultDic[@"cost"][indexPath.row]);
//    cell.cardLabel.text = [NSString stringWithFormat:@"%@",[CardsModel shareInstance].tempNameArray[indexPath.row]];
//    cell.cardImage.image = [CardsModel shareInstance].tempImageArray[indexPath.row];
    cell.costLabel.text = [NSString stringWithFormat:@"%@",self.resultDic[@"cost"][indexPath.row]];
    cell.cardLabel.text = self.resultDic[@"name"][indexPath.row];
    cell.cardImage.image = [UIImage imageWithData:self.resultDic[@"image"][indexPath.row]];
    
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
