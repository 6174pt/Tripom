import UIKit

// TabBarControllerを継承したクラス
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 自分の持っているViewControllers(ViewControllerの配列)の1番目を選択する。
        self.selectedViewController = self.viewControllers![1]
        UITabBar.appearance().tintColor = UIColor(red: 236 / 255, green: 207 / 255, blue: 101 / 255, alpha: 1)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
