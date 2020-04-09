//
//  Quake.swift
//  Quakes
//
//  Created by Ufuk Türközü on 09.04.20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

import Foundation

// Conforming to MKAnnotation requires a NSObject subclass

class Quake: NSObject, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case magnitude = "mag"
        case time
        case place
        case latitude
        case longitude
        case properties
        case geometry
        case coordinates
    }
   
    let magnitude: Double
    let time: Date
    let place: String
    let longitude: Double
    let latitude: Double
    
    required init(from decoder: Decoder) throws {
        // Containers to pull out data
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let properties = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .properties)
        let geometry = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .geometry)
        var coordinates = try geometry.nestedUnkeyedContainer(forKey: .coordinates)
        
        // Extract our properties
        magnitude = try properties.decode(Double.self, forKey: .magnitude)
        time = try properties.decode(Date.self, forKey: .time)
        place = try properties.decode(String.self, forKey: .place)
        // Longitude is before latitude in the array
        longitude = try coordinates.decode(Double.self)
        latitude = try coordinates.decode(Double.self)
        
        
        super.init()
        
    }
}
