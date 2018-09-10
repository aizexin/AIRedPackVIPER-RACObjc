//
//  AISingleSendPackViewController.m
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AISingleSendPackViewController.h"
//#import "WalletQueryTransactionAmountRespondModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "AIScaleTool.h"

@interface AISingleSendPackViewController ()
/**
 单聊数据
 */
@property (nonatomic, strong)NSMutableArray *singleDataSource;
@property (nonatomic, strong)AIGroupSendRedPackModel *group1;
@property (nonatomic, strong)AIGroupSendRedPackModel *group2;
/** 提示语*/
@property(nonatomic,strong)RACChannelTerminal *tipsChannel;
@end

@implementation AISingleSendPackViewController
-(void)loadSingleDataSource {
    _singleDataSource = [NSMutableArray arrayWithCapacity:2];
    {
        AIGroupSendRedPackModel *group   = [[AIGroupSendRedPackModel alloc]init];
        self.group1                      = group;
        group.headerHeight               = 15;
        
        AIRedPackCellModel *redpackModel = [[AIRedPackCellModel alloc]init];
        redpackModel.leftString          = [[NSAttributedString alloc]initWithString:@"红包金额"];
        redpackModel.rightString         = @"元";
        redpackModel.plceholder          = @"请输入金额";
        
        [group.listArray addObject:redpackModel];
        [_singleDataSource addObject:group];
    }
    {
        AIGroupSendRedPackModel *group   = [[AIGroupSendRedPackModel alloc]init];
        self.group2                      = group;
        group.headerHeight               = 30;
        group.headerTips                 = [NSString stringWithFormat:@"红包最大金额不能超过%.2f元",self.maxMoney.floatValue];
        AIGreetingCellModel *greetingModel = [[AIGreetingCellModel alloc]init];
        greetingModel.plceholder         = @"祝福语：恭喜发财，大吉大利";
        [group.listArray addObject:greetingModel];
        [_singleDataSource addObject:group];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self)weakSelf = self;
    [[self.presenter loadConfig]subscribeNext:^(RACTuple *x) {
        NSNumber *paypassword = [x objectAtIndex:1];
        weakSelf.isSetPayPassword = [paypassword boolValue];
        [weakSelf loadSingleDataSource];
        //这里不用reload因为数据已经绑定，而且reload会重复创建channel和重复绑定
    }error:^(NSError * _Nullable error) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.singleDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AIGroupSendRedPackModel *group = self.singleDataSource[section];
    return group.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AIGroupSendRedPackModel *group = self.singleDataSource[indexPath.section];
    AIBaseSendPackCellModel *model = group.listArray[indexPath.row];
    if ([model isKindOfClass:[AIRedPackCellModel class]]) {
        AIRedPackCellModel *redPackModel = (AIRedPackCellModel*)model;
        AIRedPackTableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:AIRedPackTableViewCell_identifer];
        cell.leftLabel.attributedText    = redPackModel.leftString;
        cell.textField.placeholder       = redPackModel.plceholder;
        cell.rightLabel.text             = redPackModel.rightString;
        [self.presenter bindTotalMoney:cell.textField.rac_newTextChannel];
    
        return cell;
    } else {
        AIGreetingCellModel *greetModel  = (AIGreetingCellModel*)model;
        AIGreetingTableViewCell *cell    = [tableView dequeueReusableCellWithIdentifier:AIGreetingTableViewCell_identifer];
        cell.textField.placeholder       = greetModel.plceholder;
        [self.presenter bindGreeting:cell.textField.rac_newTextChannel];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    AIGroupSendRedPackModel *group = self.singleDataSource[section];
    return group.headerHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        AISendPackSectionHeaderView *view        = [tableView dequeueReusableHeaderFooterViewWithIdentifier:AISendPackSectionHeaderView_identifer];
        if (!self.tipsChannel) {
            self.tipsChannel = RACChannelTo(view.label,text);
        }
        [self.presenter bindTips:self.tipsChannel];
        return view;
    } else {
        return nil;
    }
}

@end
