//
//  AIBaseSendPackViewController.h
//  Tomato
//
//  Created by aizexin on 2018/9/4.
//

#import "AISendPackPresenterProtocol.h"
#import "AISendPackViewProtocol.h"
#import "AIRedPackCellModel.h"
#import "AIGreetingCellModel.h"
#import "AIRedPackTableViewCell.h"
#import "AIGreetingTableViewCell.h"
#import "AIGroupSendRedPackModel.h"
#import "AISendPackFooterView.h"
#import "AISendPackSectionHeaderView.h"
@interface AIBaseSendPackViewController : UIViewController <AISendPackViewProtocol>
@property (nonatomic,strong)id<AISendPackPresenterProtocol> presenter;
@property (weak , nonatomic)UITableView *tableView;
@property (nonatomic,assign)NSNumber *maxMoney;
@property (nonatomic,assign,readonly)UIEdgeInsets safeAreInsets;
@property (nonatomic,weak)AISendPackFooterView *footerView;
@property (nonatomic,assign)BOOL isSetPayPassword;
@end

