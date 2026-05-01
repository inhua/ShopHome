// CTMediator+Home.swift - ShopHome 组件的 CTMediator 扩展（通过 Target-Action 调用，无直接业务依赖）
import UIKit
import ShopMediator

public extension CTMediator {

    func homeViewController() -> UIViewController? {
        return performTarget("Home", action: "viewController", params: nil) as? UIViewController
    }
}
