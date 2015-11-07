//
//  ViewController.m
//  FriendsAPI
//
//  Created by Ethan Hess on 11/4/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import "ViewController.h"
#import "FriendController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //retrieves friend array and relaoads views
    
    [[FriendController sharedInstance]getFriendsWithCompletion:^(NSArray *friends) {
        
        [self.tableView reloadData];
    }];
    
    //sets up scroll view
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width * 2);
    [self.view addSubview:self.scrollView];
    
    //and table view
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, self.view.frame.size.height - 240) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.dataSource = self;
    self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [[UIColor blackColor]CGColor];
    [self registerTableView:self.tableView];
    [self.scrollView addSubview:self.tableView];
    
    //sets up collection view as main view
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height - 180, self.view.frame.size.width - 20, self.view.frame.size.height - 240) collectionViewLayout:layout];
    
    layout.sectionInset = UIEdgeInsetsMake(2, 2, 2, 2);
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.layer.cornerRadius = 10;
    self.collectionView.backgroundColor = [UIColor cyanColor];
    self.collectionView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.collectionView.layer.borderWidth = 1;
    [self registerCollectionView:self.collectionView];
    [self.scrollView addSubview:self.collectionView];
    
}

- (void)registerTableView:(UITableView *)tableView {
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)registerCollectionView:(UICollectionView *)collectionView {
    
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collCell"];
}

#pragma TableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    
    NSDictionary *friend = [FriendController sharedInstance].resultFriends[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", friend[@"first_name"], friend[@"last_name"]];
    cell.detailTextLabel.text = friend[@"status"];
    
    NSString *imageUrl = friend[@"img"];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
    
    cell.imageView.image = [UIImage imageWithData:imageData];
    
    UIView *availability = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    availability.layer.cornerRadius = 10;
    availability.layer.borderWidth = 2;
    
    if ([friend[@"available"] boolValue] == YES) {
        availability.backgroundColor = [UIColor redColor];
        availability.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        availability.backgroundColor = [UIColor blueColor];
        availability.layer.borderColor = [UIColor blueColor].CGColor;
    }
    
    cell.accessoryView = availability;
    
    cell.layer.cornerRadius = 10;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [[UIColor blackColor]CGColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [FriendController sharedInstance].resultFriends.count;
}

#pragma CollectionView methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.layer.cornerRadius = cell.frame.size.height / 2;
    cell.layer.borderColor = [[UIColor blackColor]CGColor];
    cell.layer.borderWidth = 1; 
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.view.frame.size.width / 2) - 8,180);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
