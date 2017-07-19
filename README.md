# GuidancePage
启动引导页：支持点击进入主页面和滑动进入主界面两种模式，只需要在AppDelegate的分类里初始化控制器的时候更改参数类型就可以实现。同时有仿网易启动广告，可设置能否跳过，能否点击跳转到详情页。

启动页：

1，只需要导入文件，然后在AppDelegate+GuidancePage.m中把原来的图片名字替换成自己的图片就可以了

2，注意事项：选择滑动进入主界面的时候务必使图片数组中最后多出一个图片(这个图片不会显示),否则启动引导图的最后一张不显示。点击进入主界面的话就放按钮图片就OK了。






广告页：在AppDelegate里添加如下代码就可以。

传入的参数分别是skip（是否可以点击跳过广告）、 touchEnable（是否能点击广告跳转到详情页）、 timeInterval（广告展示时长）、 adInfoDictionary（广告信息字典）
注意：字典格式暂定为（key值请勿改变）
{
    @"imageURL":@"http://xxx.jpg",              //图片链接
    @"detailURL":@"https:www.xx.com"            //详情页链接
}

#{
#   NSString* lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:kLastVersionKey];
#    NSString* currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
#    if (lastVersion && [lastVersion isEqualToString:currentVersion]) {
#    StartAdController *controller = [[StartAdController alloc] init];
#   [controller showCustomAdvertiseAtStartAllowSkip:YES timeInterval:5.f adAllowTouch:YES adInfoDictionary:@{@"imageURL":@"http://d.hiphotos.baidu.com/zhidao/pic/item/e61190ef76c6a7eff535cd85fcfaaf51f3de6605.jpg", @"detailURL":@"https:www.baidu.com"}];
#}
