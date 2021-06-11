//
//  MainView.swift
//  InstagramStory
//
//  Created by Eren  Çelik on 11.06.2021.
//

import SwiftUI



struct MainView : View {
    @State var gestureValue: CGFloat = 0
    @ObservedObject private var viewModel = IGStoryViewModel()
    @State private var show  : Bool = false
    @State private var showStory: IGStoryModel?

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.fixed(20))]) {
                            HStack {
                                ForEach(viewModel.dummyData) { item in
                                    ProfileImageView(profileImage: .constant(item.profilePicture))
                                        .onTapGesture {
                                            showStory = item
                                            withAnimation(.easeInOut) {
                                                self.show.toggle()
                                            }
                                        }
                                }
                            }
                        }
                    }
                    .frame(height: 90)
                    Spacer()
                }

            }
            .navigationTitle("Instagram")
            .sheet(item: $showStory) { value in
                IGStoryView(stories: .constant(value.stories))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


