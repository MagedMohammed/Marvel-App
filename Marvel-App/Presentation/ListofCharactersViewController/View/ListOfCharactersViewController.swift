//
//  ListOfCharactersViewController.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit
import RxSwift
import RxCocoa

class ListOfCharactersViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - Outlet
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var coordinator: Coordinator?
    var disposeBag = DisposeBag()
    var viewModel = ListOfCharactersViewModel(apiClient: APIClient())
    private let indicatorView = UIActivityIndicatorView(style: .large)
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindTableView()
        self.subscribeToSearchButton()
        self.setupUI()
        self.subscribeToIsLoding()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Method
    func bindTableView() {
        // bind TableView in ViewModel
        var offset = 0
        
        self.tableView.register(UINib(nibName: "CharactersListTableViewCell", bundle: nil) , forCellReuseIdentifier: "CharactersListTableViewCell")
        self.tableView.delegate = self
        self.viewModel.charactersData.asObserver().subscribe(onNext: { [weak self] character in
            guard let self = self else { return }
        }).disposed(by: self.disposeBag)
        self.viewModel.charactersData
            .scan([], accumulator: { existingData, newData in
                // Use scan to accumulate the existing data with the new data
                return existingData + newData
            })
            .bind(to: tableView.rx.items(cellIdentifier: "CharactersListTableViewCell", cellType: CharactersListTableViewCell.self)) { _, model, cell in
                let title = model.name ?? ""
                let image = UserHelper.getImageUrl(thumbnail: model.thumbnail)
                cell.setCell(title: title, image: image)
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
        
        // Fitch Data
        self.viewModel.getCharacters()
    }
    
    private func setupUI() {
        // Configure and add the activity indicator
        indicatorView.color = .gray
        indicatorView.hidesWhenStopped = true
        view.addSubview(indicatorView)
        indicatorView.center = view.center
    }
    
    func subscribeToSearchButton() {
        self.searchButton.rx.tap.throttle(.milliseconds(500), scheduler: MainScheduler.instance).asObservable().subscribe(onNext: { [ weak self ] in
            guard let self = self else { return }
            let filterResultsVC = FilterResultsViewController(nibName: "FilterResultsViewController", bundle: nil)
            filterResultsVC.modalPresentationStyle = .overFullScreen
            let navigationController = UINavigationController(rootViewController: filterResultsVC)
            
            self.present(navigationController, animated: true, completion: nil)
        }).disposed(by: self.disposeBag)
    }
    
    func subscribeToIsLoding() {
        viewModel.isLoading.observe(on: MainScheduler.instance).subscribe(onNext: { [weak self] isLoading in
            guard let self else { return }
            isLoading ? self.indicatorView.startAnimating() : self.indicatorView.stopAnimating()
        }).disposed(by: disposeBag)
    }
    // MARK: - Action
}
extension ListOfCharactersViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = self.tableView.bounds.height/4
        return height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            self.viewModel.loadNextPage(offset: lastRowIndex+20)
        }
    }
}
