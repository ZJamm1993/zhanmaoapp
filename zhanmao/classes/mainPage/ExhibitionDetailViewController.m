//
//  ExhibitionWebDetailViewController.m
//  zhanmao
//
//  Created by jam on 2017/12/7.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ExhibitionDetailViewController.h"
#import "ExhiDetailInfoTableViewCell.h"
#import "ExhiDetailTitleTableViewCell.h"
#import "ExhiDetailDescriptionTableViewCell.h"

#import "MainPageHttpTool.h"

#import "SimpleButtonsTableViewCell.h"

#import "BaseFormTableViewController.h"
#import "ZhuchangFormTableViewController.h"

typedef NS_ENUM(NSInteger, ExhibitionDetailRow)
{
    ExhibitionDetailRowDate,
    ExhibitionDetailRowCity,
    ExhibitionDetailRowAddress,
    ExhibitionDetailRowHallName,
    ExhibitionDetailRowSponser,
    ExhibitionDetailRowOrganizer,
    ExhibitionDetailRowTotal,
};

@interface ExhibitionDetailViewController ()<SimpleButtonsTableViewCellDelegate>

@end

@implementation ExhibitionDetailViewController

- (void)viewDidLoad {
    self.url=[HTML_ExhiDetail urlWithMainUrl];
    self.idd=self.exhi.idd.integerValue;
    [super viewDidLoad];
    
    self.title=@"最新展会";
    
    [self refresh];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    [MainPageHttpTool getExhibitionDetailById:self.exhi.idd success:^(ExhibitionModel *exhi) {
        self.exhi=exhi;
        NSArray* bottomTypes=exhi.types;
        NSArray* buttomButtnModels=[SimpleButtonModel exampleButtonModelsWithTypes:bottomTypes];
        for (SimpleButtonModel* mo in buttomButtnModels) {
            mo.circleColor=[UIColor whiteColor];
            mo.circledImage=YES;
            mo.titleColor=[UIColor whiteColor];
            mo.title=[NSString stringWithFormat:@"%@%@",mo.title,mo.type>=5?@"服务":@"定制"];
        }
        CGFloat h=[SimpleButtonsTableViewCell heightWithButtonsCount:buttomButtnModels.count];
        
        SimpleButtonsTableViewCell* buttonsCell=[[SimpleButtonsTableViewCell alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, h)];
        buttonsCell.buttons=buttomButtnModels;
        buttonsCell.delegate=self;
        buttonsCell.backgroundColor=rgb(38, 104, 209);
        self.bottomView=buttonsCell;
        
    } cache:NO failure:^(NSError *error) {
        
    }];
}



#pragma mark SimpleButtonsTableViewCellDelegate

-(void)simpleButtonsTableViewCell:(SimpleButtonsTableViewCell *)cell didSelectedModel:(SimpleButtonModel *)model
{
    NSLog(@"%@",model.title);
    if (model.identifier.length>0) {
        Class cla=NSClassFromString(model.identifier);
        BaseFormTableViewController* form=[[cla alloc]init];
        if (![form isKindOfClass:[BaseFormTableViewController class]]) {
            form=[[ZhuchangFormTableViewController alloc]init];
        }
        form.type=model.type;
        form.prefixValues=[NSDictionary dictionaryWithDictionary:self.exhi.prefixDictionary];
        [self.navigationController pushViewController:form animated:YES];
    }
}

@end
