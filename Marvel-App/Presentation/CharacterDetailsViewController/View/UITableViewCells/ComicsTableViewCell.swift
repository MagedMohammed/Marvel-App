//
//  ComicsTableViewCell.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit
import RxSwift

class ComicsTableViewCell: UITableViewCell {
    
    //  MARK: - Outlet
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var collectionView: UICollectionView!
    
    //  MARK: - Properties
    var disposeBag = DisposeBag()
    var viewModel = CharacterDetailsViewModel(apiClient: APIClient())
    var collectionItems = [CollectionModel]()
    
    //  MARK: - ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bindCollectionView()
        // Initialization code
    }
    
    //  MARK: - Method
    func setCell(id: String, collectionType: CollectionType) {
        self.titleLabel.text = collectionType.rawValue.uppercased()
        switch collectionType {
        case .comics:
            self.viewModel.fetchCollectionData(request: .CharacterComics(id))
        case .series:
            self.viewModel.fetchCollectionData(request: .CharacterSeries(id))
        case .stories:
            self.viewModel.fetchCollectionData(request: .CharacterStories(id))
        case .events:
            self.viewModel.fetchCollectionData(request: .CharacterEvents(id))
        }
    }
    
    func bindCollectionView() {
        // bind collectionView in ViewModel
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "ComicCollectionViewCell", bundle: nil) , forCellWithReuseIdentifier: "ComicCollectionViewCell")
        self.viewModel.collectionItems.subscribe(onNext: { collectionItems in
            self.collectionItems = collectionItems
        }).disposed(by: self.disposeBag)
        self.viewModel.collectionItems.bind(to: self.collectionView.rx.items(cellIdentifier: "ComicCollectionViewCell", cellType: ComicCollectionViewCell.self)) { _, model, cell in
            let title = model.title
            let image = model.image
            cell.setCell(title: title, image: image)
        }.disposed(by: self.disposeBag)
    }
    //  MARK: - Action
    
}
extension ComicsTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 90, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0 // Adjust the value as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let topVC = UserHelper.getTopViewController() {
            let vc = ComicsViewController(nibName: "ComicsViewController", bundle: nil)
            vc.collectionItems = self.collectionItems
            vc.modalPresentationStyle = .fullScreen
            topVC.present(vc, animated: true)
        }
    }
}
