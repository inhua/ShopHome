// HomeProductCell.swift - 商品卡片
import UIKit
import ShopBase

public class HomeProductCell: UICollectionViewCell {
    public static let reuseID = "HomeProductCell"

    private let imageView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.systemGray5
        v.layer.cornerRadius = 8
        return v
    }()

    private let nameLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 13)
        l.numberOfLines = 2
        return l
    }()

    private let priceLabel: UILabel = {
        let l = UILabel()
        l.font = .boldSystemFont(ofSize: 16)
        l.textColor = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1)
        return l
    }()

    private let originalPriceLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 12)
        l.textColor = .gray
        return l
    }()

    private let salesLabel: UILabel = {
        let l = UILabel()
        l.font = .systemFont(ofSize: 11)
        l.textColor = .gray
        return l
    }()

    private let addCartButton: UIButton = {
        let b = UIButton(type: .system)
        b.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        b.tintColor = UIColor(red: 1.0, green: 0.3, blue: 0.3, alpha: 1)
        return b
    }()

    public var onAddCart: (() -> Void)?

    override public init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.08
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4

        [imageView, nameLabel, priceLabel, originalPriceLabel, salesLabel, addCartButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),

            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            originalPriceLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
            originalPriceLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 4),

            salesLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 2),
            salesLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),

            addCartButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            addCartButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            addCartButton.widthAnchor.constraint(equalToConstant: 28),
            addCartButton.heightAnchor.constraint(equalToConstant: 28)
        ])
        addCartButton.addTarget(self, action: #selector(addCartTapped), for: .touchUpInside)
    }
    required public init?(coder: NSCoder) { fatalError() }

    public func configure(with product: ProductModel) {
        nameLabel.text = product.name
        priceLabel.text = "¥\(String(format: "%.2f", product.price))"
        let attrStr = NSAttributedString(string: "¥\(Int(product.originalPrice))",
                                         attributes: [.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        originalPriceLabel.attributedText = attrStr
        salesLabel.text = "已售\(product.sales)"
    }

    @objc private func addCartTapped() { onAddCart?() }
}
