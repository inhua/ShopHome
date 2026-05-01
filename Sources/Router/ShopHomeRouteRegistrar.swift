// ShopHomeRouteRegistrar.swift - ShopHome 路由自注册
import ShopRouter

public final class ShopHomeRouteRegistrar: NSObject, MTRouteRegistrable {
    override public class func initialize() {
        super.initialize()
        guard self === ShopHomeRouteRegistrar.self else { return }
        registerRoutes()
    }

    public static func registerRoutes() {
        MTRouter.shared.register(RouterPath.Home.main) { _ in HomeViewController() }
        MTRouter.shared.register(RouterPath.Home.search) { _ in SearchViewController() }
    }
}
