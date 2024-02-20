//
//  FilterResultsViewController.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit
import RxSwift

class FilterResultsViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var disposeBag = DisposeBag()
    var viewModel = FilterResultsViewModel(apiClient: APIClient())
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.subscribeToCancelButton()
        self.bindTableView()
        self.setupSearchTextField()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Method
    
    func bindTableView() {
        // bind TableView in ViewModel
        var offset = 0
        
        self.tableView.register(UINib(nibName: "ComicTableViewCell", bundle: nil) , forCellReuseIdentifier: "ComicTableViewCell")
        self.tableView.delegate = self
        self.viewModel.charactersData.asObserver().subscribe(onNext: { [weak self] character in
            guard let self = self else { return }
        }).disposed(by: self.disposeBag)
        
        self.viewModel.charactersData.bind(to: tableView.rx.items(cellIdentifier: "ComicTableViewCell", cellType: ComicTableViewCell.self)) { _, model, cell in
                let title = model.name ?? ""
                let image = UserHelper.getImageUrl(thumbnail: model.thumbnail)
                cell.setCell(name: title, image: image)
            }
            .disposed(by: disposeBag)
        
        // Handle cell selection
        self.tableView.rx
            .modelSelected(CharacterModel.self)
            .subscribe(onNext: { selectedCharacter in
                // Handle cell selection here
                let vc = CharacterDetailsViewController(nibName: "CharacterDetailsViewController", bundle: nil)
                vc.character = selectedCharacter
                self.navigationController?.pushViewController(vc, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    func setupSearchTextField() {
        textField.rx.text
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) // Add debounce to wait for user to finish typing
            .distinctUntilChanged() // Only emit distinct values
            .subscribe(onNext: { [weak self] searchText in
                guard let self = self, let searchText = searchText else { return }
                // Perform search based on the entered text
                self.viewModel.searchCharacters(withName: searchText)
            })
            .disposed(by: disposeBag)
    }
    
    func subscribeToCancelButton() {
        self.cancelButton.rx.tap.throttle(.milliseconds(0), scheduler: MainScheduler.instance).asObservable().subscribe(onNext: { [ weak self ] in
            guard let self = self else { return }
            self.dismiss(animated: false)
        }).disposed(by: self.disposeBag)
    }
    // MARK: - Action
}

extension FilterResultsViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
