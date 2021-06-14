//
//  IGStoryViewModel.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 11.06.2021.
//

import UIKit

final class IGStoryViewModel: ObservableObject {
    
    private var data : [IGStoryModel] = [
        IGStoryModel(id: 0, name: "Eren"  , profilePicture: "photo1", stories: ["photo10","photo2","photo3","photo5"], seen: false),
        IGStoryModel(id: 1, name: "Angela", profilePicture: "photo2", stories: ["photo6" ,"photo7","photo8","photo9"], seen: false),
        IGStoryModel(id: 2, name: "Codey" , profilePicture: "photo3", stories: ["photo1"]                            , seen: false),
        IGStoryModel(id: 3, name: "Apple" , profilePicture: "photo4", stories: ["photo2"]                            , seen: false),
        IGStoryModel(id: 4, name: "Mike"  , profilePicture: "photo5", stories: ["photo3"]                            , seen: false),
        IGStoryModel(id: 5, name: "Jamie" , profilePicture: "photo6", stories: ["photo4"]                            , seen: false)
    ]
    
    @Published var dummyData : [IGStoryModel] = []
    
    init() {
        self.dummyData = data
    }
    
}

extension IGStoryViewModel {
    func orderedData() {
        self.dummyData = dummyData.sorted { $1.seen && !$0.seen }
    }
    
    func calculateAngle(offset: CGFloat) -> Double {
        let angle = offset / (UIScreen.main.bounds.width / 2)
        let degree : CGFloat = 30
        return  Double(angle * degree)
    }
}
