//
//  RelatedLinksTableViewCell.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit
import RxSwift

class RelatedLinksTableViewCell: UITableViewCell {

    //  MARK: - Outlet
    @IBOutlet weak private var nameLabel: UILabel! {
        didSet {
            nameLabel.text = "related Links".uppercased()
        }
    }
    @IBOutlet weak private var tableView: UITableView!
    
    //  MARK: - Properties
    var urls = PublishSubject<[URLElement]>()
    var disposeBag = DisposeBag()
    
    //  MARK: - ViewLifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bindTableView()
        // Initialization code
    }
    
    //  MARK: - Method
    func bindTableView() {
        self.tableView.register(UINib(nibName: "URLElementTableViewCell", bundle: nil) , forCellReuseIdentifier: "URLElementTableViewCell")
        self.urls.bind(to: self.tableView.rx.items(cellIdentifier: "URLElementTableViewCell", cellType: URLElementTableViewCell.self)) { _, model, cell in
            let title = (model.type ?? "").uppercased()
            cell.selectionStyle = .none
            cell.setCell(title: title)
        }.disposed(by: self.disposeBag)
        
        // Handle cell selection
        self.tableView.rx
            .modelSelected(URLElement.self)
            .subscribe(onNext: { selectedCharacter in
                // Handle cell selection here
                UserHelper.openLink(link: selectedCharacter.url ?? "")
            })
            .disposed(by: disposeBag)
    }
    //  MARK: - Action
    
}
