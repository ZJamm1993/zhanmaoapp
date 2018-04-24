//
//  MoreExhibitionsCollectionViewController.m
//  zhanmao
//
//  Created by ZJam on 2018/4/24.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MoreExhibitionsCollectionViewController.h"
#import "ExhibitionCollectionViewCell.h"
#import "ExhibitionModel.h"
#import "ExhibitionDetailViewController.h"

#import "ZZSearchBar.h"
#import "CitySelectionPicker.h"
#import "PickerShadowContainer.h"
#import "MoreExhiHeaderView.h"

@interface MoreExhibitionsCollectionViewController ()<UITextFieldDelegate>

@property  (nonatomic,strong) ZZSearchBar* searchBar;
@property (nonatomic,strong) MoreExhiHeaderView* headerView;

@property (nonatomic,strong) NSString* keyword;
@property (nonatomic,strong) NSString* exhibition_city;
@property (nonatomic,strong) NSString* date;

@property (nonatomic,assign) NSInteger page;

@end

@implementation MoreExhibitionsCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page=1;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ExhibitionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    self.title=@"展会排期";
    
    [self showLoadMoreView];
    
    if (self.isSearching==NO) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(goSearchController)];
        
        self.headerView=[[[UINib nibWithNibName:@"MoreExhiHeaderView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
        [self.collectionView addSubview:self.headerView];
        [self performSelector:@selector(scrollViewDidScroll:) withObject:self.collectionView afterDelay:0.01];
        
        __weak typeof(self) weself=self;
        self.headerView.areaClickBlock = ^(MoreExhiHeaderView *view) {
            CitySelectionPicker* dit=[CitySelectionPicker defaultCityPickerWithSections:2];
            [PickerShadowContainer showPickerContainerWithView:dit completion:^{
                NSArray* models=dit.selectedCityModels;
                if (models.count>=2) {
                    CityModel* city=[models objectAtIndex:1];
                    weself.exhibition_city=city.id;
                    view.areaLabel.text=city.name;
                    [weself refresh];
                }
            }];
        };
        self.headerView.dateClickBlock = ^(MoreExhiHeaderView *view) {
            UIDatePicker* dat=[[UIDatePicker alloc]init];
            dat.backgroundColor=[UIColor whiteColor];
            dat.datePickerMode=UIDatePickerModeDate;
            [PickerShadowContainer showPickerContainerWithView:dat completion:^{
                NSDateFormatter* fora=[[NSDateFormatter alloc]init];
                fora.dateFormat=@"yyyy-MM";
                NSString* dataString=[fora stringFromDate:dat.date];
                weself.date=dataString;
                view.dateLabel.text=dataString;
            }];
        };
        
        [self refresh];
    }
    else
    {
        ZZSearchBar* bar=[ZZSearchBar defaultBar];
        bar.delegate=self;
        bar.placeholder=@"请输入展会名称";
        self.navigationItem.titleView=bar;
        self.searchBar=bar;
        
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchClick)];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)goSearchController
{
    MoreExhibitionsCollectionViewController* vc=[[UIStoryboard storyboardWithName:@"MainPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MoreExhibitionsCollectionViewController"];
    vc.isSearching=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)searchClick
{
    [self.searchBar resignFirstResponder];
    self.keyword=self.searchBar.text;
    [self refresh];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self searchClick];
    return NO;
}

-(NSDictionary*)postParametersWithPage:(NSInteger)page;
{
    NSMutableDictionary* dic=[NSMutableDictionary dictionary];
    [dic setValue:@(page) forKey:@"page"];
    [dic setValue:self.keyword forKey:@"keyword"];
    [dic setValue:self.date forKey:@"date"];
    [dic setValue:self.exhibition_city forKey:@"exhibition_city"];
    return dic;
}

- (void)refresh
{
    [ZZHttpTool get:[ZZUrlTool fullUrlWithTail:@"/Content/Exhibition/new_exhibition"] params:[self postParametersWithPage:1] usingCache:NO success:^(NSDictionary *dict) {
        NSArray* list=[dict valueForKeyPath:@"data.list"];
        NSArray* models=[NSArray modelsWithDictionaries:list modelCreate:^id(NSInteger index, NSDictionary *dict) {
            return [[ExhibitionModel alloc]initWithDictionary:dict];
        }];
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:models];
        [self.collectionView reloadData];
        [self.refreshControl endRefreshing];
        self.page=1;
    } failure:^(NSError *err) {
        [MBProgressHUD showErrorMessage:BadNetworkDescription];
        [self.refreshControl endRefreshing];
    }];
}

-(void)loadMore
{
    [ZZHttpTool get:[ZZUrlTool fullUrlWithTail:@"/Content/Exhibition/new_exhibition"] params:[self postParametersWithPage:self.page+1] usingCache:NO success:^(NSDictionary *dict) {
        NSArray* list=[dict valueForKeyPath:@"data.list"];
        NSArray* models=[NSArray modelsWithDictionaries:list modelCreate:^id(NSInteger index, NSDictionary *dict) {
            return [[ExhibitionModel alloc]initWithDictionary:dict];
        }];
        [self.dataSource addObjectsFromArray:models];
        [self.collectionView reloadData];
        self.page=self.page+1;
    } failure:^(NSError *err) {
        [MBProgressHUD showErrorMessage:BadNetworkDescription];
//        [self.refreshControl endRefreshing];
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ExhibitionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    ExhibitionModel* mo=[self.dataSource objectAtIndex:indexPath.row];
    [cell.image setImageUrl:[ZZUrlTool fullUrlWithTail:mo.thumb]];
    cell.title.text=mo.exhibition_name;
    cell.subtitle.text=[NSString stringWithFormat:@"%@-%@",[[mo.start_date componentsSeparatedByString:@" "]firstObject],[[mo.end_date componentsSeparatedByString:@" "]firstObject]];
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat w=(collectionView.frame.size.width-collectionViewLayout.minimumInteritemSpacing-collectionViewLayout.sectionInset.left-collectionViewLayout.sectionInset.right)/2;
    CGFloat h=w/343*209+60;
    return CGSizeMake(w, h);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.isSearching==NO) {
        return CGSizeMake(collectionView.frame.size.width, collectionViewLayout.headerReferenceSize.height);
    }
    return CGSizeZero;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSearching==NO&&[kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
    }
    return nil;
}

#pragma mark <UICollectionViewDelegate>

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.collectionView&&self.headerView) {
        //        UICollectionViewFlowLayout* flow=(UICollectionViewFlowLayout*)self.collectionViewLayout;
        CGFloat topY=0;//flow.headerReferenceSize.height-50;
        if (scrollView.contentOffset.y>0) {
            topY=scrollView.contentOffset.y;
        }
        CGRect newFrame=CGRectMake(0, topY, scrollView.frame.size.width, 44);
        self.headerView.frame=newFrame;
        [self.collectionView bringSubviewToFront:self.headerView];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ExhibitionModel* mo=[self.dataSource objectAtIndex:indexPath.row];
    ExhibitionDetailViewController* exh=[[ExhibitionDetailViewController alloc]init];
    exh.exhi=mo;
    [self.navigationController pushViewController:exh animated:YES];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
