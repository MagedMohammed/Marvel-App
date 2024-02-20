//
//  Router.swift
//  MarvelApp
//
//  Created by Maged on 17/02/2024.
//

import Foundation
import Alamofire

enum MarvelRouter: URLRequestConvertible {
    case ListOfCharacters(Int)
    case CharacterComics(String)
    case CharacterStories(String)
    case CharacterEvents(String)
    case CharacterSeries(String)
    case FilterCharacter(String,Int)

    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .ListOfCharacters, .CharacterComics(_), .CharacterStories(_), .CharacterEvents(_), .CharacterSeries(_), .FilterCharacter(_, _):
                return .get
            }
        }
        
        var url: URL = {
            // build up and return the URL for each endpoint
            let relativePath: String?
            switch self {
            case .ListOfCharacters(_):
                relativePath = "/characters"
            case .CharacterComics(let id):
                relativePath = "/characters/\(id)/comics"
            case .CharacterStories(let id):
                relativePath = "/characters/\(id)/stories"
            case .CharacterEvents(let id):
                relativePath = "/characters/\(id)/events"
            case .CharacterSeries(let id):
                relativePath = "/characters/\(id)/series"
            case .FilterCharacter(_, _):
                relativePath = "/characters"
            }
            
            var url = URL(string: Constants.servicesLink)!
            if let relativePath = relativePath {
                url = url.appendingPathComponent(relativePath)
                url.append(queryItems: [
                    URLQueryItem(name: "apikey", value: Constants.publicKey),
                    URLQueryItem(name: "ts", value: Constants.ts),
                    URLQueryItem(name: "hash", value: Constants.hash)
                ])
                switch self {
                case .ListOfCharacters(let offset):
                    url.append(queryItems: [URLQueryItem(name: "offset", value: String(offset))])
                case .CharacterComics(_), .CharacterStories(_), .CharacterEvents(_), .CharacterSeries(_):
                    print("")
                case .FilterCharacter(let search, let offset):
                    url.append(queryItems: [URLQueryItem(name: "offset", value: String(offset)),
                                            URLQueryItem(name: "nameStartsWith", value: String(search))])
                }
            }
            return url
        }()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        return try encoding.encode(urlRequest, with: [:])
    }
}
