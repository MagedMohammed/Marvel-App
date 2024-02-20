//
//  CharactersModel.swift
//  MarvelApp
//
//  Created by Maged on 18/02/2024.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let charactersModel = try? JSONDecoder().decode(CharactersModel.self, from: jsonData)

import Foundation

// MARK: - CharactersModel
struct CharactersModel: Codable {
    var code: Int?
    var status, copyright, attributionText, attributionHTML: String?
    var etag: String?
    var data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    var offset, limit, total, count: Int?
    var results: [CharacterModel]?
}

// MARK: - Result
struct CharacterModel: Codable {
    var id: Int?
    var name, description: String?
    var modified: Date? // Change the type to Date?
    var thumbnail: Thumbnail?
    var resourceURI: String?
    var comics, series: Comics?
    var stories: Stories?
    var events: Comics?
    var urls: [URLElement]?

    private enum CodingKeys: String, CodingKey {
        case id, name, description, modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        resourceURI = try container.decodeIfPresent(String.self, forKey: .resourceURI)
        comics = try container.decodeIfPresent(Comics.self, forKey: .comics)
        series = try container.decodeIfPresent(Comics.self, forKey: .series)
        stories = try container.decodeIfPresent(Stories.self, forKey: .stories)
        events = try container.decodeIfPresent(Comics.self, forKey: .events)
        urls = try container.decodeIfPresent([URLElement].self, forKey: .urls)

        let dateString = try container.decodeIfPresent(String.self, forKey: .modified)
        modified = DateFormatter.customDateFormatter.date(from: dateString ?? "")
    }
}

extension DateFormatter {
    static let customDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Update the format according to your API response
        return formatter
    }()
}


// MARK: - Comics
struct Comics: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [ComicsItem]?
    var returned: Int?
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    var resourceURI: String?
    var name: String?
}

// MARK: - Stories
struct Stories: Codable {
    var available: Int?
    var collectionURI: String?
    var items: [StoriesItem]?
    var returned: Int?
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    var resourceURI: String?
    var name, type: String?
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    var path: String?
    var thumbnailExtension: String?

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    var type: String?
    var url: String?
}
