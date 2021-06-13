//
//  UserStoryModel.swift
//  Instagram Stories View
//
//  Created by Eren  Çelik on 9.06.2021.
//

import Foundation


struct IGStoryModel: Identifiable {
    var id = UUID()
    let name : String
    let profilePicture: String
    let stories : [String]
    var seen: Bool
}
