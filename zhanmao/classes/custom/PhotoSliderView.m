//
//  PhotoSliderView.m
//  PhotoSliderView
//
//  Created by bangju on 2017/9/30.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "PhotoSliderView.h"

const NSInteger ScrollViewBgTag=10;
const NSInteger ScrollViewImgTag=20;
const NSInteger TitleLabelTag=30;
const NSInteger PageLabelTag=40;

@interface PhotoSliderView()<UIScrollViewDelegate>

@end

@implementation PhotoSliderView

-(void)setImages:(NSArray *)images
{
    _images=[NSArray arrayWithArray:images];
    
    [self layoutImages];
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage=currentPage;
    UIScrollView* scr=[self viewWithTag:ScrollViewBgTag];
    if ([scr isKindOfClass:[UIScrollView class]]) {
        [scr setContentOffset:CGPointMake(scr.frame.size.width*currentPage, 0) animated:NO];
    }
}

-(void)setTitle:(NSString *)title
{
    _title=title;
    UILabel* titleLabel=[self viewWithTag:TitleLabelTag];
    if ([titleLabel isKindOfClass:[UILabel class]]) {
        [titleLabel setText:title];
    }
}

-(UITapGestureRecognizer*)defaultTapGestureRecognizer
{
    UITapGestureRecognizer *sigleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    return sigleTapRecognizer;
}

-(UILongPressGestureRecognizer*)defaultLongPressGestureRecognizer
{
    UILongPressGestureRecognizer* log=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPressGesture:)];
    return log;
}

-(void)layoutImages
{
    self.backgroundColor=[UIColor blackColor];
    
    NSArray* subviews=[self subviews];
    for (UIView* sub in subviews) {
        [sub removeFromSuperview];
    }
    
    NSInteger count=self.images.count;
    
    CGRect fra=self.frame;
    CGSize siz=fra.size;
    
    UIScrollView* bgScrollview=[[UIScrollView alloc]initWithFrame:self.bounds];
    bgScrollview.contentSize=CGSizeMake(count*siz.width, siz.height);
    [self addSubview:bgScrollview];
    bgScrollview.delegate=self;
    bgScrollview.pagingEnabled=YES;
    bgScrollview.tag=ScrollViewBgTag;
    bgScrollview.showsVerticalScrollIndicator=NO;
    bgScrollview.showsHorizontalScrollIndicator=NO;
    [bgScrollview addGestureRecognizer:[self defaultTapGestureRecognizer]];
    
    bgScrollview.contentOffset=CGPointMake(siz.width*self.currentPage, 0);
    
    //    return;
    CGFloat bottomHeight=64;
    UIView* bottonView=[[UIView alloc]initWithFrame:CGRectMake(0, siz.height-bottomHeight, siz.width, bottomHeight)];
    bottonView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
    [self addSubview:bottonView];
    
    UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, bottonView.frame.size.width*0.6, bottomHeight)];
    titleLabel.tag=TitleLabelTag;
    titleLabel.textColor=[UIColor whiteColor];
    titleLabel.text=self.title;
    [bottonView addSubview:titleLabel];
    
    UILabel* pageLabel=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, bottonView.frame.size.width-CGRectGetMaxX(titleLabel.frame)-20, bottomHeight)];
    pageLabel.tag=PageLabelTag;
    pageLabel.textColor=[UIColor whiteColor];
    pageLabel.text=[NSString stringWithFormat:@"1/%d",(int)count];
    pageLabel.textAlignment=NSTextAlignmentRight;
    [bottonView addSubview:pageLabel];
    
    for (int i=0; i<count; i++) {
        UIScrollView* imageBg=[[UIScrollView alloc]initWithFrame:CGRectMake(i*siz.width, 0, siz.width, siz.height)];
        imageBg.delegate=self;
        imageBg.tag=ScrollViewImgTag;
        imageBg.maximumZoomScale=3;
        imageBg.minimumZoomScale=1;
        imageBg.showsHorizontalScrollIndicator=NO;
        imageBg.showsVerticalScrollIndicator=NO;
        [imageBg addGestureRecognizer:[self defaultTapGestureRecognizer]];
        
        UIActivityIndicatorView* wheel=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [wheel startAnimating];
        wheel.center=CGPointMake(siz.width/2, siz.height/2);
        [imageBg addSubview:wheel];
        
        UIImageView* imgeVi=[[UIImageView alloc]initWithFrame:imageBg.bounds];
        [imageBg addSubview:imgeVi];
        [bgScrollview addSubview:imageBg];
        imgeVi.userInteractionEnabled=YES;
        [imgeVi addGestureRecognizer:[self defaultLongPressGestureRecognizer]];
        
        NSObject* obj=[self.images objectAtIndex:i];
        
        UIImage* img;
        if ([obj isKindOfClass:[UIImage class]]) {
            img=(UIImage*)obj;
        }
        else if([obj isKindOfClass:[NSString class]])
        {
            img=[UIImage imageNamed:(NSString*)obj];
        }
        else
        {
            return;
        }
        if (img==nil) {
            __weak typeof(self) weself=self;
            __weak typeof(imgeVi) weimgv=imgeVi;
            [imgeVi setImageUrl:obj.description placeHolder:nil completed:^(UIImage *image, NSError *error, NSString *imageUrl) {
                if (image==nil) {
                    return;
                }
                weimgv.image=image;
                [weself resizeImageView:weimgv withImage:image andSize:siz];
            }];
//            [imgeVi
        }
        else
        {
            imgeVi.image=img;
            [self resizeImageView:imgeVi withImage:img andSize:siz];
        }
        
    }
    [self scrollViewDidScroll:bgScrollview];
}

-(void)resizeImageView:(UIImageView*)imgeVi withImage:(UIImage*)img andSize:(CGSize)siz
{
    imgeVi.contentMode=UIViewContentModeScaleAspectFit;
    
    //        continue;
    CGFloat rateImgWh=img.size.width/img.size.height;
    CGFloat rateScrWh=siz.width/siz.height;
    
    CGSize newImageSize=CGSizeZero;
    if (rateImgWh>rateScrWh) {
        newImageSize=CGSizeMake(siz.width, siz.width/rateImgWh);
    }
    else
    {
        newImageSize=CGSizeMake(siz.height*rateImgWh, siz.height);
    }
    imgeVi.frame=CGRectMake(siz.width/2-newImageSize.width/2, siz.height/2-newImageSize.height/2, newImageSize.width, newImageSize.height);
}

#pragma mark zooming

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView.tag==ScrollViewImgTag) {
        //        return scrollView.subviews.firstObject;
        for (UIView* view in scrollView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                return view;
            }
        }
    }
    return nil;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (scrollView.tag==ScrollViewImgTag) {
        CGFloat xcenter = scrollView.bounds.size.width/2;
        CGFloat ycenter = scrollView.bounds.size.height/2;
        
        xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
        ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
        
        for (UIView* view in scrollView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view setCenter:CGPointMake(xcenter, ycenter)];
            }
        }
        //        [scrollView.subviews.firstObject setCenter:CGPointMake(xcenter, ycenter)];
    }
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag==ScrollViewBgTag) {
        CGPoint contentOffset=scrollView.contentOffset;
        CGSize boundsSize=scrollView.bounds.size;
        NSArray* subviews=scrollView.subviews;
        for (int i=0;i<subviews.count;i++) {
            UIView* sub=[subviews objectAtIndex:i];
            CGFloat leftx=contentOffset.x;
            CGRect showingRect=CGRectMake(leftx, 0, boundsSize.width, boundsSize.height);
            BOOL isShowing=CGRectIntersectsRect(showingRect, sub.frame);
            if (!isShowing) {
                if ([sub isKindOfClass:[UIScrollView class]]) {
                    UIScrollView* subScr=(UIScrollView*)sub;
                    subScr.zoomScale=subScr.minimumZoomScale;
                }
            }
        }
        if (!scrollView.isTracking) {
            NSInteger page=contentOffset.x/boundsSize.width+1;
            UILabel* pageLabel=[self viewWithTag:PageLabelTag];
            _currentPage=page-1;
            if ([pageLabel isKindOfClass:[UILabel class]]) {
                [pageLabel setText:[NSString stringWithFormat:@"%d/%d",(int)page,(int)self.images.count]];
            }
        }
        
    }
}

#pragma mark - gesture

-(void)handleTapGesture:(UIGestureRecognizer*)recognizer
{
    if([self.delegate respondsToSelector:@selector(photoSliderViewDidSinglePress:)])
    {
        [self.delegate photoSliderViewDidSinglePress:recognizer.view];
    }
}

-(void)handleLongPressGesture:(UIGestureRecognizer*)recognizer
{
    if (recognizer.state != UIGestureRecognizerStateBegan)
    {
        return;
    }
    if([self.delegate respondsToSelector:@selector(photoSliderViewDidLongPress:)])
    {
        [self.delegate photoSliderViewDidLongPress:recognizer.view];
    }
}

@end

#pragma mark -view controller

@interface PhotoSliderViewController()<PhotoSliderViewDelegate>

@property (nonatomic,strong) PhotoSliderView* slideView;

@end

@implementation PhotoSliderViewController
{
}

+(UINavigationController*)navgationControllerWithPhotoSlider:(void(^)(PhotoSliderViewController* sliderController))configureBlock
{
    PhotoSliderViewController* vc=[[PhotoSliderViewController alloc]init];
    UINavigationController* nav=[[UINavigationController alloc]initWithRootViewController:vc];
    nav.navigationBar.barStyle=UIBarStyleBlack;
    nav.navigationBar.tintColor=[UIColor whiteColor];
    nav.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    if (configureBlock) {
        configureBlock(vc);
    }
    return nav;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self.slideView layoutImages];
}

-(void)photoSliderViewDidSinglePress:(UIView *)view
{
    [self.navigationController setNavigationBarHidden:!self.navigationController.navigationBarHidden animated:YES];
}

-(void)photoSliderViewDidLongPress:(UIView *)view
{
    UIImage* img=nil;
    if ([view isKindOfClass:[UIImageView class]]) {
        UIImageView* imgView=(UIImageView*)view;
        img=imgView.image;
    }
    if (self.longPressBlock) {
        self.longPressBlock(img);
    }
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.slideView=[[PhotoSliderView alloc]initWithFrame:self.view.bounds];
    self.slideView.images=self.images;
    self.slideView.delegate=self;
    self.slideView.currentPage=self.currentPage;
    self.slideView.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|
    UIViewAutoresizingFlexibleWidth|
    UIViewAutoresizingFlexibleRightMargin|
    UIViewAutoresizingFlexibleTopMargin|
    UIViewAutoresizingFlexibleHeight|
    UIViewAutoresizingFlexibleBottomMargin;
    [self.view addSubview:self.slideView];
    
    UIBarButtonItem* done=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(donePress)];
    self.navigationItem.rightBarButtonItem=done;
}

-(void)setImages:(NSArray *)images
{
    _images=images;
    self.slideView.images=images;
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage=currentPage;
    self.slideView.currentPage=currentPage;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.slideView.images=self.images;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)donePress
{
    if (self==self.navigationController.viewControllers.firstObject||self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end

