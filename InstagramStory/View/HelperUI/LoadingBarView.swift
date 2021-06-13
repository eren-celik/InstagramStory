//
//  LoadingBarView.swift
//  InstagramStory
//
//  Created by Eren Çelik on 13.06.2021.
//

import SwiftUI

struct LoadingBarView: View {
    @EnvironmentObject var storyTimerViewModel: IGStoryTimer
    var userData: IGStoryModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 4){
                ForEach(userData.stories.indices){ index in
                    LoadingBar(progress: progressBarValue(index) )
                        .frame(height: 2, alignment:.leading)
                }
            }
            
            HStack {
                Image(userData.profilePicture)
                    .resizable()
                    .frame(width: 40, height: 40)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                Text(userData.name)
                    .font(.title3)
                    .foregroundColor(.white)
            }
            .padding(.top, 5)
        }
        .padding()
        .background(Color.black)
    }
    
    private func progressBarValue(_ value: Int) -> CGFloat {
        return min( max( (CGFloat(self.storyTimerViewModel.progress) - CGFloat(value)), 0.0) , 1.0)
    }
    
}
