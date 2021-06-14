//
//  ProfileImageView.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 11.06.2021.
//

import SwiftUI

struct ProfileImageView: View {
    
    @Binding var data : IGStoryModel
    
    var body: some View {
        VStack(alignment: .center) {
            ZStack {
                Image(data.profilePicture)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                Circle()
                    .trim(from: 0, to: 1)
                    .stroke(AngularGradient(gradient: Gradient(colors: data.seen ?  [.gray] : [.red, .orange, .red]), center: .center),
                            style: StrokeStyle(lineWidth: 3))
                    .frame(width: 60,
                           height: 60)
            } 
            
            Text(data.name)
                .font(.system(.subheadline, design: .rounded))
        }
        .padding(.all, 10)
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(data: .constant(
                            IGStoryModel(name: "Eren", profilePicture: "photo1", stories: ["photo10","photo2","photo3","photo5"], seen: false)))
    }
}
