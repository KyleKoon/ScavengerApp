//
//  Person.swift
//  ScavengerAppTest
//
//  Created by Ajay Bati on 10/23/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
struct Person: Identifiable, Codable {
    var id: String
    var Total: [String: Int]
    var name: String
    var location: GeoPoint
    var steps: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "location_name"
        case Total
        case location = "Location"
        case steps
    }
}
