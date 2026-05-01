// Bundle+ShopHome.swift - ShopHome 资源 Bundle 扩展
import Foundation

private class BundleToken: NSObject {}

extension Bundle {
    static var shopHome: Bundle {
        let bundleName = "ShopHome_Resources"
        let candidates = [
            Bundle(for: BundleToken.self),
            Bundle.main,
        ]
        for bundle in candidates {
            if let path = bundle.path(forResource: bundleName, ofType: "bundle"),
               let resourceBundle = Bundle(path: path) {
                return resourceBundle
            }
        }
        return Bundle(for: BundleToken.self)
    }
}
