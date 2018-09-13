//
//  AIGroupSendPackViewController.m
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AIGroupSendPackViewController.h"
#import "NSAttributedString+YYText.h"
#import "AIGroupSendPackHeaderView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "AIScaleTool.h"
@interface AIGroupSendPackViewController ()
/**
 群聊数据
 */
@property (nonatomic, strong)NSMutableArray *groupDataSource;
@property (nonatomic, strong)AIGroupSendRedPackModel *group2;
/** 总金额model*/
@property(nonatomic,strong)AIRedPackCellModel *redpackModel2;
@property (nonatomic,assign,getter=isRandomPack)BOOL randomPack;

@property (nonatomic,assign)NSInteger groupSize;
/** 提示语*/
@property(nonatomic,strong)RACChannelTerminal *tipsChannel;
@end

@implementation AIGroupSendPackViewController

-(void)loadGroupDataSource {
    _groupDataSource = [NSMutableArray arrayWithCapacity:3];
    {
        AIGroupSendRedPackModel *group = [[AIGroupSendRedPackModel alloc]init];
        group.headerHeight               = 15;
        AIRedPackCellModel *redpackModel = [[AIRedPackCellModel alloc]init];
        redpackModel.leftString          = [[NSAttributedString alloc]initWithString:@"红包个数"];
        redpackModel.rightString         = @"个";
        redpackModel.plceholder          = [NSString stringWithFormat:@"本群一共%ld人",self.groupSize];
        [group.listArray addObject:redpackModel];
        
        AIRedPackCellModel *redpackModel2 = [[AIRedPackCellModel alloc]init];
        self.redpackModel2                = redpackModel2;
        NSString *string                  = @"总金额 ";
        NSMutableAttributedString *attrM  = [[NSMutableAttributedString alloc]initWithString:string];
        UIImage *image                    = [UIImage imageNamed:@"icon_redpacket_luck"];
        NSMutableAttributedString *attachment = nil;
        attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:[UIFont systemFontOfSize:13] alignment:YYTextVerticalAlignmentCenter];
        [attrM insertAttributedString:attachment atIndex:string.length];
        redpackModel2.leftString          = attrM;
        
        redpackModel2.rightString         = @"元";
        redpackModel2.plceholder          = @"输入金额";
        [group.listArray addObject:redpackModel2];
        
        [_groupDataSource addObject:group];
    }
    {
        AIGroupSendRedPackModel *group = [[AIGroupSendRedPackModel alloc]init];
        group.headerTips               = @"最大金额不不能超过xx元";
        group.headerHeight             = 30;
        AIGreetingCellModel *greetingModel = [[AIGreetingCellModel alloc]init];
        greetingModel.plceholder       = @"祝福语：恭喜发财，大吉大利";
        [group.listArray addObject:greetingModel];
        [_groupDataSource addObject:group];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    AIGroupSendPackHeaderView *headerView = [[AIGroupSendPackHeaderView alloc]init];
    headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 30);
    self.tableView.tableHeaderView = headerView;
    
    self.footerView.frame                 = CGRectMake(0, 0, self.view.bounds.size.width, AIScale_y(66+48));
    self.tableView.tableFooterView        = self.footerView;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    __weak typeof(self)weakSelf = self;
    [headerView.randomSignal subscribeNext:^(id  _Nullable x) {
        NSString *string                  = @"总金额 ";
        NSMutableAttributedString *attrM  = [[NSMutableAttributedString alloc]initWithString:string];
        UIImage *image                    = [UIImage imageNamed:@"icon_redpacket_luck"];
        NSMutableAttributedString *attachment = nil;
        attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:[UIFont systemFontOfSize:13] alignment:YYTextVerticalAlignmentCenter];
        [attrM insertAttributedString:attachment atIndex:string.length];
        weakSelf.redpackModel2.leftString          = attrM;
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationRight)];
    }];
    [headerView.normalSignal subscribeNext:^(id  _Nullable x) {
        
        NSString *string                  = @"单个金额 ";
        NSMutableAttributedString *attrM  = [[NSMutableAttributedString alloc]initWithString:string];
        weakSelf.redpackModel2.leftString          = attrM;
        [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
    }];
    //绑定是否是随机红包
    RACChannelTerminal *randomPackChannel = RACChannelTo(self,randomPack);
    [headerView.getIsRandom subscribe:randomPackChannel];
    [randomPackChannel subscribe:headerView.getIsRandom];
    [self.presenter bindIsRandomPack:headerView.getIsRandom];
    self.randomPack = YES;
    
    [[self.presenter loadConfig]subscribeNext:^(RACTuple *x) {
        NSNumber *number = x.first;
        weakSelf.groupSize = number.integerValue;
        NSNumber *paypassword = [x objectAtIndex:1];
        weakSelf.isSetPayPassword = [paypassword boolValue];
        [weakSelf loadGroupDataSource];
    }error:^(NSError * _Nullable error) {
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    AIGroupSendRedPackModel *group = self.groupDataSource[section];
    return group.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    AIGroupSendRedPackModel *group = self.groupDataSource[section];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AIGroupSendRedPackModel *group = self.groupDataSource[indexPath.section];
    AIBaseSendPackCellModel *model = group.listArray[indexPath.row];
    if ([model isKindOfClass:[AIRedPackCellModel class]]) {
        AIRedPackCellModel *redPackModel = (AIRedPackCellModel*)model;
        AIRedPackTableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:AIRedPackTableViewCell_identifer];
        cell.leftLabel.attributedText    = redPackModel.leftString;
        cell.textField.placeholder       = redPackModel.plceholder;
        cell.rightLabel.text             = redPackModel.rightString;
        if ([redPackModel.rightString isEqual:@"个"]) {
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            [self.presenter bindGroupPackNumber:cell.textField.rac_newTextChannel];
        } else {
            cell.textField.keyboardType = UIKeyboardTypeDecimalPad;
            if (self.isRandomPack) {
                [self.presenter bindTotalMoney:cell.textField.rac_newTextChannel];
            } else {
                [self.presenter bindGroupOnePackMoney:cell.textField.rac_newTextChannel];
            }
        }
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


@end
