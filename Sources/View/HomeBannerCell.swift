// HomeBannerCell.swift - 首页Banner轮播
import UIKit

public class HomeBannerCell: UICollectionViewCell {
    public static let reuseID = "HomeBannerCell"

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 20)
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()

    private let bgView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 12
        v.clipsToBounds = true
        return v
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor)
        ])
    }
    required public init?(coder: NSCoder) { fatalError() }

    public func configure(with banner: BannerModel, index: Int) {
        titleLabel.text = banner.title
        let colors: [UIColor] = [
            UIColor(red: 1.0, green: 0.4, blue: 0.4, alpha: 1),
            UIColor(red: 0.4, green: 0.6, blue: 1.0, alpha: 1),
            UIColor(red: 0.4, green: 0.8, blue: 0.5, alpha: 1)
        ]
        bgView.backgroundColor = colors[index % colors.count]
    }
}
