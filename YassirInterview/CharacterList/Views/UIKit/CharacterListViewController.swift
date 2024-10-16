//
//  CharacterListViewController.swift
//  YassirInterview
//
//  Created by Abdelahad on 15/10/2024.
//

import UIKit
import SwiftUI
import Combine

final class CharacterListViewController: UIViewController, UICollectionViewDelegate  {
    enum Section: String { case main }

    private lazy var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private var datasource: UICollectionViewDiffableDataSource<Section, Character>?
    
    private var cancelables: Set<AnyCancellable> = []
    
    private var viewModel: CharacterListViewModel
    
    init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupCollectionView()
        setupCollectionViewDataSource()
        
        bindViewModel()
        Task { await viewModel.viewDidLoad() }
    }
    
    private func bindViewModel() {
        viewModel.$clearDatasource
            .receive(on: DispatchQueue.main)
            .sink {[weak self] clear in
                guard let datasource = self?.datasource, clear else { return }
                var snapshot = NSDiffableDataSourceSnapshot<Section, Character>()
                snapshot.appendSections([.main])
                datasource.apply(snapshot, animatingDifferences: true)
            }.store(in: &cancelables)
        
        
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink {[weak self] characters in
                guard let datasource = self?.datasource else { return }
                var snapshot = datasource.snapshot()
                snapshot.appendItems(characters, toSection: Section.main)
                datasource.apply(snapshot, animatingDifferences: true)
            }.store(in: &cancelables)
    }
    
    private func setupSubviews() {
        title = Strings.Characters
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(collectionView)
    }
        
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        collectionView.register(cell: CharacterCollectionViewCell.self)
        collectionView.register(header: CharacterStatusFilterReusableView.self)
        collectionView.contentInset.top = 0
    }
    
    private func setupCollectionViewDataSource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, character in
            let cell: CharacterCollectionViewCell = collectionView.dequeue(for: indexPath) 
            cell.configure(with: character)
            return cell
        })
        
        datasource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            
            let view: CharacterStatusFilterReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath)
            let statusFilterView = StatusFilterView(filterItems: Status.allCases.map { $0.rawValue }) { status in
                Task {  await self.viewModel.filterCharacters(by: status) }
            }
            view.host(AnyView(statusFilterView))
            return view
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Character>()
        snapshot.appendSections([.main])
        datasource?.apply(snapshot, animatingDifferences: true)
    }

    private func createLayout() -> UICollectionViewLayout {
        
        let section = listSection()
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(40))
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        
        // this activates the "sticky" behaviour
        headerElement.pinToVisibleBounds = true
        
        section.boundarySupplementaryItems = [headerElement]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
    
    private func listSection(withEstimatedHeight estimatedHeight: CGFloat = 120) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(estimatedHeight + 16))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize, subitems: [layoutItem])

        return NSCollectionLayoutSection(group: layoutGroup)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedItem = datasource?.itemIdentifier(for: indexPath) else { return }
        let controller = UIHostingController(rootView: CharacterDetailsView(character: selectedItem))
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            Task { await viewModel.didEndScroll() }
        }
    }
}
