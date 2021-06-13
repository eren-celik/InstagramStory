//
//  LoadingBar.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 11.06.2021.
//

import SwiftUI

struct LoadingBar: View {
    
    var progress : CGFloat
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment:.leading){
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.5))
                    .cornerRadius(5)
                Rectangle()
                    .frame(width: geometry.size.width * self.progress,
                           height: nil,
                           alignment: .leading
                    )
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
    }
}
