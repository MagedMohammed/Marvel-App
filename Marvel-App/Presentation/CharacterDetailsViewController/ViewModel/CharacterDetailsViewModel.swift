//
//  CharacterDetailsViewModel.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import Foundation
import RxSwift

class CharacterDetailsViewModel {
    var collectionItems = PublishSubject<[CollectionModel]>()
    var apiClient: APIClientProtocol!
    let disposeBag = DisposeBag()
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    func fetchCollectionData(request: MarvelRouter) {
        apiClient.fetchData(requestConvertible: request)
            .subscribe(onNext: { (data: CollectionBaseModel) in
                guard let characterArray = data.data?.results else {
                    return
                }
                let collectionItems: [CollectionModel] = characterArray.compactMap({
                    return CollectionModel(title: $0.title ?? "", image: UserHelper.getImageUrl(thumbnail: $0.thumbnail))})
                self.collectionItems.onNext(collectionItems)
            }, onError: { error in
                // Handle the error
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
