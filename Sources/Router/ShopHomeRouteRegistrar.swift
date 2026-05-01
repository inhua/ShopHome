// ShopHomeRouteRegistrar.swift - ShopHome 路由注册
import ShopRouter

public final class ShopHomeRouteRegistrar: NSObject, MTRouteRegistrable {
    public static func registerRoutes() {
        MTRouter.shared.register(RouterPath.Home.main)   { _ in HomeViewController() }
        MTRouter.shared.register(RouterPath.Home.search) { _ in SearchViewController() }
    }
}
