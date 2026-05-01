// RouterPath+Home.swift - ShopHome 组件路由路径常量
import ShopRouter

public extension RouterPath {
    struct Home {
        public static let main   = "\(RouterPath.scheme)://home/main"
        public static let search = "\(RouterPath.scheme)://home/search"
    }
}
