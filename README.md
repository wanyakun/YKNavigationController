## YKNavigationController是什么
YKNavigationController是基于[JTNavigationController](https://github.com/JNTian/JTNavigationController)而封装的自定义NavigationController。

> 使用`[self.navigationController setNavigationBarHidden:YES animated:NO];`方法来隐藏导航栏会导致滑动返回手势无效
>
> 使用`self.navigationController.navigationBar.hidden = YES;`方法来隐藏导航栏会导致返回到带导航栏页面过程中导航栏被切掉的效果。

导航栏和页面View作为整体滑动，避免一些隐藏了导航条无法使用返回手势，或者隐藏导航条后返回到带导航条页面过程中出现导航栏被剪切掉的效果。

### YKNavigationController提供了哪些功能

相比于JTNavigationController，JTNavigationController做了一下修改：

- 去掉全屏返回手势控制，更接近Apple原生效果（个人喜好，直接将控制全屏返回手势去掉）
- 去掉图片资源，改为用CoreGraphics绘制返回按钮
- 增加canNotUseInteractivePopGestureRecognizer来设置返回手势无效（项目中有些奇葩需求，要求页面不能够返回）

### YKNavigationController适用的版本

YKNavigationController继承自UINavigationController，大小项目均可以使用。

YKNavigationController支持iOS7或之后的版本。



### CocoaPods支持

你可以在 Podfile 中加入下面一行代码来使用YKNavigationController

```
    pod 'YKNavigationController'
```


####集成方法

#####1. 代码方式
将原来的`UINavigationController`替换为`YKNavigationController`即可.

#####2. storyboard方式
修改`UINavigationController`的class为`YKNavigationController`

####相关操作
 1. push,pop,popToRoot的操作可以无需作调整,使用`self.navigationController`的方法就行,`popToViewController`稍微有些不同,详情见Demo中的代码
    1. 修改状态栏颜色,用`preferredStatusBarStyle`或者`[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]`(需要在info文件中加入View controller-based status bar appearance = NO)
    2. 返回按钮图标设置请修改`backButtonImage`属性
    3. 修改`barTintColor`,增加`barButtonItem`等导航栏的操作都能放到viewDidLoad中,因为每个控制器都有属于自己的`UINavigationController`,所以不会影响到其他控制器的导航栏

## 感谢

YKNavigationController 是基于[JTNavigationController](https://github.com/JNTian/JTNavigationController)进行开发，感谢他对开源社区做出的贡献。

## 协议

YKNavigationController 被许可在 MIT 协议下使用。查阅 LICENSE 文件来获得更多信息。
