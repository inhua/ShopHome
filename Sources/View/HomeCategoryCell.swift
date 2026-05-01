// HomeCategoryCell.swift - 分类格子
import UIKit

public class HomeCategoryCell: UICollectionViewCell {
    public static let reuseID = "HomeCategoryCell"

    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1)
        return iv
    }()

    private let nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11)
        l.textAlignment = .center
        l.numberOfLines = 1
        return l
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        [iconView, nameLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 36),
            iconView.heightAnchor.constraint(equalToConstant: 36),
            nameLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    required public init?(coder: NSCoder) { fatalError() }

    public func configure(with category: CategoryModel) {
        iconView.image = UIImage(systemName: category.icon)
        nameLabel.text = category.name
    }
}

// MARK: - Section Header
public class HomeSectionHeader: UICollectionReusableView {
    public static let reuseID = "HomeSectionHeader"

    private let titleLabel: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 16)
        return l
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.systemGroupedBackground
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    required public init?(coder: NSCoder) { fatalError() }

    public func configure(title: String) { titleLabel.text = title }
}
