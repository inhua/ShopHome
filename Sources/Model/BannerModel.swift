// BannerModel.swift - 首页 Banner 数据模型（归属 ShopHome 组件）
import Foundation

public struct BannerModel {
    public var imageURL: String
    public var title: String
    public var linkURL: String

    public init(imageURL: String, title: String, linkURL: String) {
        self.imageURL = imageURL
        self.title = title
        self.linkURL = linkURL
    }
}
