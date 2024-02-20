//
//  ComicObjModel.swift
//  MarvelApp
//
//  Created by Maged on 19/02/2024.
//

import Foundation

struct CollectionModel {
    var title: String
    var image: String
}

enum CollectionType: String {
    case comics
    case series
    case stories
    case events
}

// MARK: - CollectionModel
struct CollectionBaseModel: Codable {
    var code: Int?
    var status, copyright, attributionText, attributionHTML: String?
    var etag: String?
    var data: CollectionDataClass?
}

// MARK: - DataClass
struct CollectionDataClass: Codable {
    var offset, limit, total, count: Int?
    var results: [CollectionResult]?
}

// MARK: - Result
struct CollectionResult: Codable {
    var id: Int?
    var title, description: String?
    var resourceURI: String?
    var urls: [URLElement]?
    var modified: Date?
    var start, end: String?
    var thumbnail: Thumbnail?
    var creators: Creators?
    var characters: Characters?
    var stories: Stories?
    var comics, series: Characters?
    var next, previous: Next?

    enum CodingKeys: String, CodingKey {
        case id
        case title, description
        case resourceURI = "resourceURI"
        case urls, modified, start, end, thumbnail, creators, characters, stories, comics, series, next, previous
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decodeIfPresent(Int.self, forKey: .id)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
        urls = try container.decodeIfPresent([URLElement].self, forKey: .urls)
        start = try container.decodeIfPresent(String.self, forKey: .start)
        end = try container.decodeIfPresent(String.self, forKey: .end)
        thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        creators = try container.decodeIfPresent(Creators.self, forKey: .creators)
        characters = try container.decodeIfPresent(Characters.self, forKey: .characters)
        stories = try container.decodeIfPresent(Stories.self, forKey: .stories)
        comics = try container.decodeIfPresent(Characters.self, forKey: .comics)
        series = try container.decodeIfPresent(Characters.self, forKey: .series)
        next = try container.decodeIfPresent(Next.self, forKey: .next)
        previous = try container.decodeIfPresent(Next.self, forKey: .previous)
        
        let dateString = try container.decodeIfPresent(String.self, forKey: .modified)
        modified = DateFormatter.customDateFormatter.date(from: dateString ?? "")
    }
}


// MARK: - Characters
struct Characters: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [Next]?
    var returned: Int?
}

// MARK: - Next
struct Next: Codable {
    var resourceURI: String?
    var name: String?
}

// MARK: - Creators
struct Creators: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [CreatorsItem]?
    var returned: Int?
}

// MARK: - CreatorsItem
struct CreatorsItem: Codable {
    var resourceURI: String?
    var name, role: String?
}
