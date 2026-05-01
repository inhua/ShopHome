// Target_Home.swift - 首页组件对外暴露的 Target-Action 入口
import UIKit

@objc(Target_Home)
public class Target_Home: NSObject {

    @objc public func action_viewController(_ params: [String: Any]?) -> UIViewController {
        return HomeViewController()
    }
}
