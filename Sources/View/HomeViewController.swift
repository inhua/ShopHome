// HomeViewController.swift - 首页
import UIKit
import ShopBase
import ShopMediator
import ShopRouter

public class HomeViewController: BaseViewController {

    private let viewModel = HomeViewModel()
    private var collectionView: UICollectionView!
    private var bannerTimer: Timer?
    private var currentBannerIndex = 0

    // Section枚举
    private enum Section: Int, CaseIterable {
        case banner, category, product
    }

    public override func setupUI() {
        title = "首页"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .plain, target: self, action: #selector(onSearch))

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        collectionView.backgroundColor = UIColor.systemGroupedBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeBannerCell.self, forCellWithReuseIdentifier: HomeBannerCell.reuseID)
        collectionView.register(HomeCategoryCell.self, forCellWithReuseIdentifier: HomeCategoryCell.reuseID)
        collectionView.register(HomeProductCell.self, forCellWithReuseIdentifier: HomeProductCell.reuseID)
        collectionView.register(HomeSectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HomeSectionHeader.reuseID)

        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    public override func bindViewModel() {
        viewModel.onDataUpdated = { [weak self] in
            self?.collectionView.reloadData()
            self?.startBannerTimer()
        }
        viewModel.loadData()
    }

    // MARK: - Layout
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            guard let self = self else { return nil }
            switch Section(rawValue: section) {
            case .banner:   return self.bannerSection()
            case .category: return self.categorySection()
            case .product:  return self.productSection()
            case .none:     return nil
            }
        }
    }

    private func bannerSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(180)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 10
        section.contentInsets = .init(top: 12, leading: 0, bottom: 12, trailing: 0)
        return section
    }

    private func categorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.125), heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(90)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44)),
            elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }

    private func productSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        item.contentInsets = .init(top: 6, leading: 6, bottom: 6, trailing: 6)
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(260)), subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 0, leading: 6, bottom: 20, trailing: 6)
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(44)),
            elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        return section
    }

    // MARK: - Banner Timer
    private func startBannerTimer() {
        bannerTimer?.invalidate()
        guard viewModel.banners.count > 1 else { return }
        bannerTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            self?.scrollToNextBanner()
        }
    }

    private func scrollToNextBanner() {
        currentBannerIndex = (currentBannerIndex + 1) % viewModel.banners.count
        collectionView.scrollToItem(at: IndexPath(item: currentBannerIndex, section: 0),
                                    at: .centeredHorizontally, animated: true)
    }

    @objc private func onSearch() {
        routePush(RouterPath.Home.search)
    }

    deinit { bannerTimer?.invalidate() }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int { Section.allCases.count }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .banner:   return viewModel.banners.count
        case .category: return viewModel.categories.count
        case .product:  return viewModel.products.count
        case .none:     return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section) {
        case .banner:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerCell.reuseID, for: indexPath) as! HomeBannerCell
            cell.configure(with: viewModel.banners[indexPath.item], index: indexPath.item)
            return cell
        case .category:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCategoryCell.reuseID, for: indexPath) as! HomeCategoryCell
            cell.configure(with: viewModel.categories[indexPath.item])
            return cell
        case .product:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCell.reuseID, for: indexPath) as! HomeProductCell
            let product = viewModel.products[indexPath.item]
            cell.configure(with: product)
            // 通过 CTMediator Target-Action 调用购物车，避免直接依赖 ShopCart/CartManager
            cell.onAddCart = { [weak self] in
                self?.addProductToCart(product)
            }
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeSectionHeader.reuseID, for: indexPath) as! HomeSectionHeader
        switch Section(rawValue: indexPath.section) {
        case .category: header.configure(title: "商品分类")
        case .product:  header.configure(title: "热门推荐")
        default: break
        }
        return header
    }

    // 通过 CTMediator Target-Action 调用购物车，无直接业务依赖
    private func addProductToCart(_ product: ProductModel) {
        CTMediator.shared.performTarget("Cart", action: "addProduct", params: ["product": product])
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == Section.product.rawValue {
            let product = viewModel.products[indexPath.item]
            // 通过路由跳转商品详情，避免直接依赖 ShopProduct 组件
            //routePush(RouterPath.Product.detail, params: [RouterParamKey.product: product])
        }
    }
}
