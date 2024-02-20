//
//  ListOfCharactersViewModel.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import Foundation
import RxSwift
import Alamofire

class ListOfCharactersViewModel {
    var isLoading = BehaviorSubject<Bool>(value: false)
    var apiClient: APIClientProtocol!
    var charactersData = PublishSubject<[CharacterModel]>()
    let disposeBag = DisposeBag()
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getCharacters() {
        self.isLoading.onNext(true)
        apiClient.fetchData(requestConvertible: MarvelRouter.ListOfCharacters(0))
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
    
    func loadNextPage(offset: Int) {
        self.isLoading.onNext(true)
        apiClient.fetchData(requestConvertible: MarvelRouter.ListOfCharacters(offset))
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
