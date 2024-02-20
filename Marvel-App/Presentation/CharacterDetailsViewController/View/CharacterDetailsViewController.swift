//
//  CharacterDetailsViewController.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import UIKit
import Kingfisher

class CharacterDetailsViewController: UIViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var tableView: UITableView!
    
    //  MARK: - enum
    enum Sections: Int, CaseIterable {
        case characterImage = 0
        case characterDetails
        case comics
        case series
        case stories
        case events
        case relatedLinks
    }
    
    // MARK: - Properties
    var character: CharacterModel!
    var backgroundImageView: UIImageView!
    var blurEffectView: UIVisualEffectView!
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.setupBackground()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        self.removeBackground()
    }
    
    // MARK: - Method
    func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "CharacterImageTableViewCell", bundle: nil) , forCellReuseIdentifier: "CharacterImageTableViewCell")
        self.tableView.register(UINib(nibName: "CharacterDetailsTableViewCell", bundle: nil) , forCellReuseIdentifier: "CharacterDetailsTableViewCell")
        self.tableView.register(UINib(nibName: "ComicsTableViewCell", bundle: nil) , forCellReuseIdentifier: "ComicsTableViewCell")
        self.tableView.register(UINib(nibName: "RelatedLinksTableViewCell", bundle: nil) , forCellReuseIdentifier: "RelatedLinksTableViewCell")
    }
    
    private func setupBackground() {
        // Create an image view with your desired background image
        backgroundImageView = UIImageView()
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        let image = (character.thumbnail?.path ?? "")+"."+(character.thumbnail?.thumbnailExtension ?? "jpg")
        backgroundImageView.kf.setImage(with: URL(string: image))
        view.addSubview(backgroundImageView)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        self.blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    private func removeBackground() {
        self.blurEffectView.removeFromSuperview()
        self.backgroundImageView.removeFromSuperview()
    }
    // MARK: - Action
}

extension CharacterDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = String(character.id ?? 0)
        switch indexPath.section {
        case Sections.characterImage.rawValue:
            let cell: CharacterImageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CharacterImageTableViewCell", for: indexPath) as! CharacterImageTableViewCell
            let image = (character.thumbnail?.path ?? "")+"."+(character.thumbnail?.thumbnailExtension ?? "jpg")
            cell.setCell(image: image)
            cell.backAction = { [weak self] in
                guard let self else { return }
                self.navigationController?.popViewController(animated: true)
            }
            cell.selectionStyle = .none
            return cell
        case Sections.characterDetails.rawValue:
            let cell: CharacterDetailsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CharacterDetailsTableViewCell", for: indexPath) as! CharacterDetailsTableViewCell
            let name = character.name ?? ""
            let description = character.description ?? ""
            cell.setCell(name: name, description: description)
            cell.selectionStyle = .none
            return cell
        case Sections.comics.rawValue: // comics
            let cell: ComicsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ComicsTableViewCell", for: indexPath) as! ComicsTableViewCell
            cell.setCell(id: id, collectionType: .comics)
            cell.selectionStyle = .none
            return cell
        case Sections.series.rawValue: // series
            let cell: ComicsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ComicsTableViewCell", for: indexPath) as! ComicsTableViewCell
            cell.setCell(id: id, collectionType: .series)
            cell.selectionStyle = .none
            return cell
        case Sections.stories.rawValue:
            let cell: ComicsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ComicsTableViewCell", for: indexPath) as! ComicsTableViewCell
            cell.setCell(id: id, collectionType: .stories)
            cell.selectionStyle = .none
            return cell
        case Sections.events.rawValue:
            let cell: ComicsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ComicsTableViewCell", for: indexPath) as! ComicsTableViewCell
            cell.setCell(id: id, collectionType: .events)
            cell.selectionStyle = .none
            return cell
        case Sections.relatedLinks.rawValue:
            let cell: RelatedLinksTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RelatedLinksTableViewCell", for: indexPath) as! RelatedLinksTableViewCell
            guard let urlItems = character.urls else {return RelatedLinksTableViewCell()}
            cell.urls.onNext(urlItems)
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == Sections.characterImage.rawValue {
            let height = tableView.bounds.height/2
            return height
        } else {
           return UITableView.automaticDimension
        }
    }
}
