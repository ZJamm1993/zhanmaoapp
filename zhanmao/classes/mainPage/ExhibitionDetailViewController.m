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
    [super viewDidLoad];
    
    self.title=@"最新展会";
    
    [self.bottomButton removeFromSuperview];
    
    [self setAdvertiseHeaderViewWithPicturesUrls:[NSArray arrayWithObject:@"image_loading"]];
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
        NSMutableArray* picUrls=[NSMutableArray array];
        for (NSString* u in exhi.smeta) {
            if (u.length>0) {
                NSString* url=[ZZUrlTool fullUrlWithTail:u];
                [picUrls addObject:url];
            }
        }
        [self setAdvertiseHeaderViewWithPicturesUrls:picUrls];
        
        [self.bottomToolBar removeAllSubviews];
        NSArray* bottomTypes=exhi.types;
        NSArray* buttomButtnModels=[SimpleButtonModel exampleButtonModelsWithTypes:bottomTypes];
        for (SimpleButtonModel* mo in buttomButtnModels) {
            mo.circleColor=[UIColor whiteColor];
            mo.circledImage=YES;
            mo.titleColor=[UIColor whiteColor];
            mo.title=[NSString stringWithFormat:@"%@%@",mo.title,mo.type>=5?@"服务":@"定制"];
        }
        CGFloat h=[SimpleButtonsTableViewCell heightWithButtonsCount:buttomButtnModels.count];
        
        SimpleButtonsTableViewCell* buttonsCell=[[SimpleButtonsTableViewCell alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, h)];
        buttonsCell.buttons=buttomButtnModels;
        buttonsCell.delegate=self;
        buttonsCell.backgroundColor=_mainColor;
        [self.bottomToolBar addSubview:buttonsCell];
        
        self.tableView.contentInset=UIEdgeInsetsMake(0, 0, h, 0);
        
        [self.tableView reloadData];
        [self performSelector:@selector(scrollViewDidScroll:) withObject:self.tableView afterDelay:0.01];
    } cache:NO failure:^(NSError *error) {
        
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section!=1) {
        return 1;
    }
    return ExhibitionDetailRowTotal;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=indexPath.row;
    NSInteger sec=indexPath.section;
    
    if (sec==0) {
        ExhiDetailTitleTableViewCell* titleCell=[tableView dequeueReusableCellWithIdentifier:@"ExhiDetailTitleTableViewCell" forIndexPath:indexPath];
        titleCell.title.text=self.exhi.exhibition_name;
        return titleCell;
    }
    else if(sec==2)
    {
        ExhiDetailDescriptionTableViewCell* desCell=[tableView dequeueReusableCellWithIdentifier:@"ExhiDetailDescriptionTableViewCell" forIndexPath:indexPath];
        desCell.title.text=@"展会说明";
        desCell.detail.text=self.exhi.exhibition_description;
        return desCell;
    }
    else
    {
        ExhiDetailInfoTableViewCell* infoCell=[tableView dequeueReusableCellWithIdentifier:@"ExhiDetailInfoTableViewCell" forIndexPath:indexPath];
        NSString* t=@"";
        NSString* d=@"";
        
        if (row==ExhibitionDetailRowDate) {
            t=@"展会日期";
            NSString* star=[[self.exhi.start_date componentsSeparatedByString:@" "]firstObject];
            NSString* endt=[[self.exhi.end_date componentsSeparatedByString:@" "]firstObject];
            d=[NSString stringWithFormat:@"%@ 至 %@",star.length>0?star:@"",endt.length>0?endt:@""] ;
        }
        else if(row==ExhibitionDetailRowCity)
        {
            t=@"展出城市";
            d=self.exhi.city;
        }
        else if(row==ExhibitionDetailRowAddress)
        {
            t=@"展出地址";
            d=self.exhi.address;
        }
        else if(row==ExhibitionDetailRowHallName)
        {
            t=@"展馆名称";
            d=self.exhi.hall_name;
        }
        else if(row==ExhibitionDetailRowSponser)
        {
            t=@"主办单位";
            d=self.exhi.sponsor;
        }
        else if(row==ExhibitionDetailRowOrganizer)
        {
            t=@"承办单位";
            d=self.exhi.organizer;
        }
        
        infoCell.title.text=t;
        infoCell.detail.text=d;
        
        return infoCell;
    }
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
