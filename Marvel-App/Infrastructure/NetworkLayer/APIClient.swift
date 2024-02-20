//
//  APIClient.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import Foundation
import Alamofire
import RxSwift

enum APIError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

protocol APIClientProtocol {
    func fetchData<T: Decodable>(
        requestConvertible: URLRequestConvertible
    ) -> Observable<T>
}

class APIClient: APIClientProtocol {
    func fetchData<T: Decodable>(
        requestConvertible: URLRequestConvertible
    ) -> Observable<T> {
        return Observable.create { observer in
            let request = AF.request(requestConvertible).validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let result):
                        observer.onNext(result)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(APIError.requestFailed(error))
                    }
                }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
