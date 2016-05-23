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
#import "DatabaseModel.h"
#import "InsertData.h"

@interface CalculateController () <ButtonDelegate,UITableViewDataSource,UITableViewDelegate,cardValueDelegate>

@property (nonatomic, strong) ResultController *resultController;
@property (nonatomic, strong) SelectController *selectController;
@property (nonatomic, strong) NSMutableDictionary *cardDic;

@end

@implementation CalculateController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"CARD:%@",[CardsModel shareInstance].cardsArray);
//    [self.cardDic setValue:[NSString stringWithFormat:@"%d",value] forKey:[NSString stringWithFormat:@"%d", tag]];

    [self.calculateView.baseTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.calculateView = [[CalculateView alloc] initWithFrame:self.view.frame];
    self.view = self.calculateView;
    [self.calculateView showBaseTableView];
    
    self.calculateView.baseTableView.delegate = self;
    self.calculateView.baseTableView.dataSource = self;
    self.calculateView.delegate = self;
    [self.calculateView.addButton addTarget:self action:@selector(addCardAction) forControlEvents:UIControlEventTouchUpInside];
    [self.calculateView.calButton addTarget:self action:@selector(calAction) forControlEvents:UIControlEventTouchUpInside];
    self.cardDic = [NSMutableDictionary dictionary];
    
    
}

- (void) addCardAction {
    [[NetworkManager initInstaceWithServerDomain:@"http://163.17.136.88:5566"] requestURL:@"/api/store/1/card" method:RequestGetType parameters:nil success:^(id responseObject) {
        
        
        NSMutableArray *tempImageArray = [NSMutableArray array];
        NSMutableArray *tempNameArray = [NSMutableArray array];
        NSMutableArray *tempIdArray = [NSMutableArray array];

        for (id object in responseObject[@"data"][@"cards"]) {
            
            NSString *picString  = [NSString stringWithFormat:@"http://163.17.136.88:5566/img/%@",object[@"image"]];
            NSURL *picURL = [NSURL URLWithString:picString];
            NSData *picData = [NSData dataWithContentsOfURL:picURL];
            [tempImageArray addObject:picData];
            [tempNameArray addObject:object[@"name"]];
            [tempIdArray addObject:object[@"id"]];

        }
//        NSLog(@"%@",tempNameArray);
        
        self.selectController = [[SelectController alloc] init];
        self.selectController.tempCardDic = [NSMutableDictionary dictionary];
        
        [self.selectController.tempCardDic setObject:tempImageArray forKey:@"image"];
        [self.selectController.tempCardDic setObject:tempNameArray forKey:@"name"];
        [self.selectController.tempCardDic setObject:tempIdArray forKey:@"Id"];
        [CardsModel shareInstance].cardsArray = [NSMutableArray array];
        [CardsModel shareInstance].tempImageArray = [NSMutableArray array];
        [self.navigationController pushViewController:self.selectController animated:YES];
    
    }];
    
}

- (void) calAction {
//    if ([self.calculateView.totalField.text isEqualToString:@""]) {
//        NSLog(@"asadsd");
//    }
    if (self.cardDic.count == 0) {
        [self alertController:@"請輸入卡片張數"];
    } else if (self.calculateView.totalField.text.length == 0) {
        [self alertController:@"請輸入消費金額"];
    } else {
        self.resultController = [[ResultController alloc] init];
        self.resultController.resultDic = [NSMutableDictionary dictionary];
        
        NSMutableArray *costArray = [NSMutableArray array];
        NSMutableArray *idArray = [NSMutableArray array];
        NSMutableArray *pointArray = [NSMutableArray array];
        NSMutableArray *nameArray = [NSMutableArray array];
        NSMutableArray *imageArray = [NSMutableArray array];
        
        NSMutableArray *cardArray = [NSMutableArray array];
        for (NSString *keyId in self.cardDic.allKeys) {
            [cardArray addObject:@{@"id" : keyId, @"sum" : self.cardDic[keyId]}];
        }
        NSDictionary *parameters = @{@"price":self.calculateView.totalField.text,@"store_id":@"1",@"card":cardArray};
        [[NetworkManager initInstaceWithServerDomain:@"http://163.17.136.88:5566"] requestURL:@"/api/operation" method:RequestPostType parameters:parameters success:^(id responseObject) {
            NSLog(@"%@",responseObject);
            for (id object in responseObject[@"data"]) {
                [costArray addObject:object[@"cost"]];
                [idArray addObject:object[@"id"]];
                [pointArray addObject:object[@"point"]];
                [nameArray addObject:object[@"name"]];
                NSString *picString  = [NSString stringWithFormat:@"http://163.17.136.88:5566/img/%@",object[@"image"]];
                NSURL *picURL = [NSURL URLWithString:picString];
                NSData *picData = [NSData dataWithContentsOfURL:picURL];
                [imageArray addObject:picData];
            }
            [self.resultController.resultDic setValue:costArray forKey:@"cost"];
            [self.resultController.resultDic setValue:idArray forKey:@"id"];
            [self.resultController.resultDic setValue:nameArray forKey:@"name"];
            [self.resultController.resultDic setValue:imageArray forKey:@"image"];
            [self.resultController.resultDic setValue:pointArray forKey:@"point"];
            self.resultController.pointString = [NSString stringWithFormat:@"%@",responseObject[@"value"]];
            
            NSError *err = nil;
            NSData * jsonData = [NSJSONSerialization dataWithJSONObject:responseObject[@"data"] options:0 error:&err];
            NSString * dataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            //        NSLog(@"------%@", dataString);
            InsertData *tempInsert = [[InsertData alloc] init];
            tempInsert.insertData = dataString;
            tempInsert.insertValue = responseObject[@"value"];
            tempInsert.insertOperationID = responseObject[@"operation_id"];
            self.resultController.insertData = tempInsert;
            [self.navigationController pushViewController:self.resultController animated:YES];
            
        }];
    }

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

    cell.cardLabel.text = [NSString stringWithFormat:@"%@",[CardsModel shareInstance].tempNameArray[indexPath.row]];
    cell.cardImage.image = [CardsModel shareInstance].tempImageArray[indexPath.row];
    cell.tag = [[CardsModel shareInstance].cardsArray[indexPath.row] integerValue];
    cell.delegate = self;
    
    return cell;
}

- (void) card:(CardCell *)cardcell didSelectAtTag:(NSInteger)tag value:(NSInteger)value {
    [self.cardDic setValue:[NSString stringWithFormat:@"%d",value] forKey:[NSString stringWithFormat:@"%d", tag]];
    NSLog(@"%@",self.cardDic);
//    self.
//    self.resultDic = [NSMutableDictionary dictionaryWithObject:value forKey:tag];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return tableView.frame.size.height / 3;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) alertController:(NSString*) string {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"錯誤" message:string preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
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
