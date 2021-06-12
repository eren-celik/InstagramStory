//
//  IGStoryViewModel.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 11.06.2021.
//

import Foundation

final class IGStoryViewModel: ObservableObject {
    
    @Published var dummyData : [IGStoryModel] = [
        IGStoryModel(name: "Eren", profilePicture: "photo1", stories: ["photo10","photo2","photo3","photo5"], seen: false),
        IGStoryModel(name: "Angela", profilePicture: "photo2", stories: ["photo6","photo7","photo8","photo9"], seen: false),
        IGStoryModel(name: "Codey", profilePicture: "photo3", stories: ["photo10"], seen: false),
        IGStoryModel(name: "Apple", profilePicture: "photo4", stories: ["photo1"], seen: false),
        IGStoryModel(name: "Mike", profilePicture: "photo5", stories: ["photo1"], seen: false),
        IGStoryModel(name: "Jamie", profilePicture: "photo6", stories: ["photo1"], seen: false)
    ]
}
