//
//  RecordController.m
//  CardProject
//
//  Created by 翁瑞祺 on 2016/4/9.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "RecordController.h"
#import "RecordView.h"
#import "DatabaseModel.h"
#import "RecordCell.h"

@interface RecordController ()<UITableViewDataSource,UITableViewDelegate, ButtonDelegate>

@property(nonatomic, strong)DatabaseModel *databaseModel;
@property(nonatomic) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation RecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.databaseModel = [[DatabaseModel alloc] init];
    self.recordView = [[RecordView alloc] initWithFrame:self.view.frame];
    self.recordView.delegate = self;
    self.view = self.recordView;
    [self.recordView setNavBarButton];
    [self.recordView showBaseTableView];
    self.recordView.baseTableView.frame = CGRectMake(CGRectGetWidth(self.view.frame) * 0.12, CGRectGetHeight(self.view.frame) * 0.3,CGRectGetWidth(self.view.frame) * 0.78, CGRectGetHeight(self.view.frame) * 0.6);
    self.recordView.baseTableView.delegate = self;
    self.recordView.baseTableView.dataSource = self;

    self.dataArray = [self.databaseModel readAllData];
    
    
    
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"RecordCellIdentifier";
    RecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.backgroundColor = [UIColor clearColor];
       
    }

    cell.titleBottomLineView.hidden = !(indexPath.row == 0 || indexPath.row == self.indexPath.row);
    cell.backLabel.hidden = (self.indexPath == nil);
    cell.label.textAlignment = (self.indexPath == nil) ? NSTextAlignmentLeft :NSTextAlignmentCenter;
    cell.recordData = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.indexPath == indexPath) {
        return CGRectGetHeight(self.view.frame)*0.6;
    }else{
        return CGRectGetHeight(self.view.frame)*0.07;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecordCell *cell = (RecordCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (self.indexPath == indexPath) {
        cell.titleBottomLineView.hidden = YES;
        cell.tableView.hidden = YES;
        cell.recordFooterView.hidden = YES;
        self.indexPath = nil;
        [tableView reloadData];
        tableView.scrollEnabled = YES;
        
    }else{
        
        NSLog(@"%ld",(long)indexPath.row);
        cell.tableView.hidden = NO;
        cell.recordFooterView.hidden = NO;
        self.indexPath = indexPath;
        [tableView reloadData];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        tableView.scrollEnabled = NO;
        
    }
    
    
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
