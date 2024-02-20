//
//  FilterResultsViewModel.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import Foundation
import RxSwift

class FilterResultsViewModel {
    var isLoading = BehaviorSubject<Bool>(value: false)
    var apiClient: APIClientProtocol!
    var charactersData = PublishSubject<[CharacterModel]>()
    let disposeBag = DisposeBag()
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func searchCharacters(withName: String) {
        self.isLoading.onNext(true)
        apiClient.fetchData(requestConvertible: MarvelRouter.FilterCharacter(withName, 0))
            .subscribe(onNext: { (data: CharactersModel) in
                self.isLoading.onNext(false)
                guard let characterArray = data.data?.results else {
                    return
                }
                self.charactersData.onNext(characterArray)
                print(data)
            }, onError: { error in
                // Handle the error
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    func loadNextPage(withName: String, offset: Int) {
        self.isLoading.onNext(true)
        apiClient.fetchData(requestConvertible: MarvelRouter.FilterCharacter(withName, offset))
            .subscribe(onNext: { (data: CharactersModel) in
                self.isLoading.onNext(false)
                guard let characterArray = data.data?.results else {
                    return
                }
                self.charactersData.onNext(characterArray)
                print(data)
            }, onError: { error in
                // Handle the error
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
