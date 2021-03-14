//
//  Data Model.swift
//  FlickrFeedApp
//
//  Created by Egor Vedeneev on 14.03.2021.
//

import Foundation


struct Items: Decodable{
    let items: [Item]
    enum CodingKeys: String, CodingKey{
        case items
    }
 
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.items = try container.decode([Item].self, forKey: .items)

    }
}
    
    
struct Item: Decodable{
        let title: String
        let published: String
        let media: Media
        let tags: String
        
        enum CodingKeys: String, CodingKey{
            case title = "title"
            case media
            case published
            case tags
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.title = try container.decode(String.self, forKey: .title)
            self.media = try container.decode(Media.self, forKey: .media)
            self.published = try container.decode(String.self, forKey: .published)
            self.tags = try container.decode(String.self, forKey: .tags)
    }
    
    
}
        
struct Media: Decodable{
            let m: String
            
            enum CodingKeys: String, CodingKey{
                case m
            }
            
            init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: CodingKeys.self)
                self.m = try container.decode(String.self, forKey: .m)
            }
}
