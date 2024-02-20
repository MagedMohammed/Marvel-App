//
//  ComicsViewController.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit
import RxSwift

class ComicsViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var pagesLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    var collectionItems = [CollectionModel]()
    var disposeBag = DisposeBag()
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setCollectionView()
        pagesLabel.text = "\(1)/\(self.collectionItems.count)"
        titleLabel.text = self.collectionItems[0].title
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Method
    func setCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "ComicsPageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ComicsPageCollectionViewCell")
        self.collectionView.reloadData()
    }
    
    // MARK: - Action
    @IBAction func closeButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
extension ComicsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ComicsPageCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicsPageCollectionViewCell", for: indexPath) as! ComicsPageCollectionViewCell
        let image = self.collectionItems[indexPath.row].image
        cell.setCell(image: image)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.collectionView.bounds.width-15
        let height = self.collectionView.bounds.height
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0 // Adjust the value as needed
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int((scrollView.contentOffset.x + collectionView.frame.width / 2) / collectionView.frame.width) + 1
        titleLabel.text = self.collectionItems[currentPage-1].title
        pagesLabel.text = "\(currentPage)/\(self.collectionItems.count)"
    }
}
