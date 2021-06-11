//
//  ProfileImageView.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 11.06.2021.
//

import SwiftUI

struct ProfileImageView: View {
    
    @Binding var profileImage: String
    
    var body: some View {
        ZStack {
            Image(profileImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Circle()
                .trim(from: 0, to: 1)
                .stroke(AngularGradient(gradient: Gradient(colors: [.red, .orange, .red]), center: .center),
                        style: StrokeStyle(lineWidth: 3))
                .frame(width: 60,
                       height: 60)
        }
        .padding(.all, 5)
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(profileImage: .constant("photo1"))
    }
}
