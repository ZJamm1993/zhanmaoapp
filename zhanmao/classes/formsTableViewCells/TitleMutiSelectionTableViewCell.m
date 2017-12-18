//
//  TitleMutiSelectionTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/11/10.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "TitleMutiSelectionTableViewCell.h"

const CGFloat mutiSelectionButtonMarginY=10;
const CGFloat mutiSelectionButtonMarginX=10;
const CGFloat mutiSelectionButtonHeight=32;
const NSInteger mutiSelectionButtonRowCount=3;

@implementation TitleMutiSelectionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionView.delegate=self;
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setModel:(BaseFormModel *)model
{
    [super setModel:model];
    
    self.title.text=model.name;
    self.selectionViewHeight.constant=[MutiSelectionButtonsView heightForItemCount:model.option.count];
    self.selectionView.titles=model.option;
    self.selectionView.selectedTitles=[NSMutableArray arrayWithArray:[self.model.value componentsSeparatedByString:@","]];
}

-(void)mutiSelectionButtonsViewValueDidChanged:(NSString *)value
{
    self.model.value=value;
    [self reloadModel];
}

@end



/////////

@implementation MutiSelectionButtonsView

+(CGFloat)heightForItemCount:(NSInteger)count
{
    if (count==0) {
        return 44;
    }
    NSInteger rows=count/mutiSelectionButtonRowCount;
    if (count%mutiSelectionButtonRowCount>0) {
        rows=rows+1;
    }
    CGFloat he=(mutiSelectionButtonHeight+mutiSelectionButtonMarginY)*rows+mutiSelectionButtonMarginY;
    return he;
}

-(void)setSelectedTitles:(NSMutableArray *)selectedTitles
{
    _selectedTitles=selectedTitles;
    [self heightLightButtonsWithSelectedTitles];
}

-(void)setTitles:(NSArray *)titles
{
    _titles=titles;
    [self removeAllSubviews];
    self.backgroundColor=[UIColor clearColor];
    
    CGFloat widthPerEach=([[UIScreen mainScreen]bounds].size.width-(1+mutiSelectionButtonRowCount)*mutiSelectionButtonMarginX)/mutiSelectionButtonRowCount;
    CGFloat heightPerEach=mutiSelectionButtonHeight;
    
    NSInteger counts=titles.count;
    for (NSInteger i=0; i<counts; i++) {
        NSInteger row=i/mutiSelectionButtonRowCount;
        NSInteger sec=i%mutiSelectionButtonRowCount;
        NSString* tit=[titles objectAtIndex:i];
        tit=[tit stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (tit.length>4) {
            NSInteger cent=tit.length/2;
            NSMutableString* str=[[NSMutableString alloc]initWithString:tit];
            [str insertString:@"\n" atIndex:cent];
            tit=str.description;
        }
//        tit=@"全部全部全部全部全部全部全部全部全部全部全部全部全部";
        
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake((widthPerEach+mutiSelectionButtonMarginX)*sec, mutiSelectionButtonMarginY+(heightPerEach+mutiSelectionButtonMarginY)*row, widthPerEach, heightPerEach)];
        btn.tag=i;
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn.titleLabel setLineBreakMode:NSLineBreakByClipping];
//        btn.titleLabel.adjustsFontSizeToFitWidth=YES;
//        btn.titleLabel.minimumScaleFactor=0;
        btn.titleLabel.numberOfLines=2;
        
        [btn addTarget:self action:@selector(buttonClicks:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:tit forState:UIControlStateNormal];
        [btn setTitleColor:_mainColor forState:UIControlStateSelected];
        [btn setTitleColor:gray_6 forState:UIControlStateNormal];
        [btn.layer setCornerRadius:heightPerEach/2];
        [btn.layer setBorderWidth:0.5];
        
        btn.tag=i;
        
        [self addSubview:btn];
    }
    
    [self heightLightButtonsWithSelectedTitles];
}

-(void)buttonClicks:(UIButton*)btn
{
    [self setButton:btn selected:!btn.selected];
    NSInteger tag=btn.tag;
    NSString* title=[self.titles objectAtIndex:tag];
//    NSString* title=[btn titleForState:UIControlStateNormal];
    if ([self.selectedTitles containsObject:@""]) {
        [self.selectedTitles removeObject:@""];
    }
    
    if (btn.selected) {
        if (![self.selectedTitles containsObject:title]) {
            [self.selectedTitles addObject:title];
        }
        
        if (self.selectedTitles.count==self.titles.count-1&&[self.titles containsObject:@"全部"]) {
            [self.selectedTitles removeAllObjects];
            [self.selectedTitles addObjectsFromArray:self.titles];
        }
    }
    else
    {
        if ([self.selectedTitles containsObject:title]) {
            [self.selectedTitles removeObject:title];
        }
        
        if ([self.selectedTitles containsObject:@"全部"]) {
            [self.selectedTitles removeObject:@"全部"];
        }
    }
    
    if ([title isEqualToString:@"全部"]) {
        [self.selectedTitles removeAllObjects];
        if (btn.selected) {
            [self.selectedTitles addObjectsFromArray:self.titles];
        }
    }
    NSLog(@"%@",self.selectedTitles);
    if ([self.delegate respondsToSelector:@selector(mutiSelectionButtonsViewValueDidChanged:)]) {
        [self.delegate mutiSelectionButtonsViewValueDidChanged:[self.selectedTitles componentsJoinedByString:@","]];
    }
}

-(void)heightLightButtonsWithSelectedTitles
{
    for (UIButton* btn in self.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            NSInteger tag=btn.tag;
            NSString* title=[self.titles objectAtIndex:tag];
            [self setButton:btn selected:[self.selectedTitles containsObject:title]];
        }
    }
}

-(void)setButton:(UIButton*)btn selected:(BOOL)selected
{
    btn.selected=selected;
    if (selected) {
        [btn.layer setBorderColor:_mainColor.CGColor];
    }
    else
    {
        [btn.layer setBorderColor:[btn titleColorForState:UIControlStateNormal].CGColor];
    }
}

@end
