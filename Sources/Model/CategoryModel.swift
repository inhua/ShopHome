// CategoryModel.swift - 首页分类数据模型（归属 ShopHome 组件）
import Foundation

public struct CategoryModel {
    public var id: String
    public var name: String
    public var icon: String

    public init(id: String, name: String, icon: String) {
        self.id = id
        self.name = name
        self.icon = icon
    }
}
