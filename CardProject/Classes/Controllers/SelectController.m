//
//  SelectController.m
//  CardProject
//
//  Created by 陳泓諺 on 2016/1/23.
//  Copyright © 2016年 陳泓諺. All rights reserved.
//

#import "SelectController.h"
#import "SelectView.h"
#import "CardsModel.h"

@interface SelectController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,ButtonDelegate>

@end

@implementation SelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectView = [[SelectView alloc] initWithFrame:self.view.frame];
    self.view = self.selectView;
    [self.selectView.confirmButton addTarget:self action:@selector(comfirmAction) forControlEvents:UIControlEventTouchUpInside];
    self.selectView.delegate = self;

}

- (void) comfirmAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) buttonTrigger:(id)trigger button:(UIButton *)button {
    switch (button.tag) {
        case 100:
            [self backAction];
            break;
        case 101:
            [self homeAction];
            break;
            
        default:{
            button.selected = !button.selected;
            if (button.selected) {
                [[CardsModel shareInstance].cardsArray addObject:[NSString stringWithFormat:@"%ld",(long)button.tag]];
            } else {
                [[CardsModel shareInstance].cardsArray
                 removeObject:[NSString stringWithFormat:@"%ld",(long)button.tag]];
            }
        }
            break;
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
