//
//  MoreViewController.m
//  loadWeb
//
//  Created by 申帅 on 16/3/23.
//  Copyright © 2016年 申帅. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end

@implementation MoreViewController{
     UIImagePickerController *imagePicker;////相册
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILongPressGestureRecognizer *longPre = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleBtn)];
    [self.view addGestureRecognizer:longPre];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _image.image = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] valueForKey:@"newImage"]];
    // Do any additional setup after loading the view.
}


- (void)handleBtn{
    [self pickImageFromCamera];
}
/**
 *  从摄像头获取相册图片
 */
- (void)pickImageFromCamera{
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_tableView reloadData];
}

- (IBAction)addNewWeb:(id)sender {
        RootViewController *rootVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RootViewController"];
    [self presentViewController:rootVC animated:YES completion:nil];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[HistoryModel manager] findAllWebCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text =  [[HistoryModel manager] fillAllWebTitle][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"web_addtodesktop"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HistoryModel *manager = [HistoryModel manager];
    RootViewController *VC =(RootViewController *)[manager getWebControllerWithwebTitle:[manager fillAllWebTitle][indexPath.row]];
    [self presentViewController:VC animated:YES completion:nil];
}






- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //截图的大小
    UIImage *newImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(375, 667)];
    NSData* imageData = UIImagePNGRepresentation(newImage);
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:imageData forKey:@"newImage"];
    [self dismissViewControllerAnimated:YES completion:^{
        _image.image = [UIImage imageWithData:imageData];
    }];
}
/**
 *  压缩图片
 *
 *  @param image   被压缩
 *  @param newSize 压缩尺寸
 *
 *  @return 被压缩后的图片
 */
- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    HistoryModel *model = [HistoryModel manager];
    model = nil;
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
