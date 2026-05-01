// HomeViewModel.swift
import Foundation
import ShopBase

public class HomeViewModel {

    public var banners: [BannerModel] = []
    public var categories: [CategoryModel] = []
    public var products: [ProductModel] = []

    public var onDataUpdated: (() -> Void)?
    public var onError: ((String) -> Void)?

    public init() {}

    public func loadData() {
        // 模拟数据（实际替换为网络请求）
        banners = [
            BannerModel(imageURL: "", title: "新品上市", linkURL: ""),
            BannerModel(imageURL: "", title: "限时特惠", linkURL: ""),
            BannerModel(imageURL: "", title: "品牌专区", linkURL: "")
        ]
        categories = [
            CategoryModel(id: "1", name: "手机数码", icon: "iphone"),
            CategoryModel(id: "2", name: "服装鞋包", icon: "bag"),
            CategoryModel(id: "3", name: "美妆护肤", icon: "sparkles"),
            CategoryModel(id: "4", name: "家居生活", icon: "house"),
            CategoryModel(id: "5", name: "食品生鲜", icon: "cart"),
            CategoryModel(id: "6", name: "运动户外", icon: "figure.run"),
            CategoryModel(id: "7", name: "图书文具", icon: "book"),
            CategoryModel(id: "8", name: "更多分类", icon: "ellipsis")
        ]
        products = mockProducts()
        onDataUpdated?()
    }

    private func mockProducts() -> [ProductModel] {
        return (1...10).map { i in
            ProductModel(id: "\(i)", name: "商品\(i) 精选好物推荐",
                         price: Double(Int.random(in: 99...999)),
                         originalPrice: Double(Int.random(in: 1000...1999)),
                         imageURL: "", category: "数码",
                         description: "这是商品\(i)的详细描述",
                         sales: Int.random(in: 100...9999),
                         rating: Double(Int.random(in: 40...50)) / 10.0)
        }
    }
}
