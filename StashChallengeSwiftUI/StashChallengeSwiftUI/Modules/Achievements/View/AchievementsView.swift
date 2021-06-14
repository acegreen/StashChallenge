//
//  ContentView.swift
//  StashChallengeSwiftUI
//
//  Created by Ace Green on 6/13/21.
//

import SwiftUI
import AGViperKit

protocol AchievementsModuleView: ModuleView {}

struct AchievementsView: View, AchievementsModuleView {

    var presenter: AchievementsModulePresenter!

    @ObservedObject var viewModel: AchievementsViewModel

    mutating func configure(presenter: ModulePresenter) {
        assert(presenter is AchievementsModulePresenter, "presenter parameter must be of type AchievementsModulePresenter")
        self.presenter = presenter as? AchievementsModulePresenter
    }

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.achievementViewModels) { achievement in
                    ZStack {
                        AsyncImage(url: achievement.imageURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .mask(RoundedRectangle(cornerRadius: 15))
                                .padding()
                                .opacity(achievement.accessible ? 1.0 : 0.5)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 400, height: 300, alignment: .center)
                        }
                        VStack(alignment: .center, spacing: 24) {
                            AchievementsLevelView(level: achievement.level)
                                .frame(width: 100, height: 100, alignment: .center)
                            AchievementsProgressView(progress: Float(achievement.progress),
                                                     minLabel: achievement.minLabel,
                                                     maxLabel: achievement.maxLabel)

                        }
                        .padding(EdgeInsets(top: 48, leading: 48, bottom: 48, trailing: 48))
                    }
                }
            }
            .purpleNavigation
            .navigationBarTitle(viewModel.title, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AchievementsProgressView: View {
    let progress: Float
    let minLabel: String
    let maxLabel: String
    var body: some View {
        VStack {
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .green))
                .background(.white)
            HStack {
                Text(minLabel)
                    .foregroundColor(.white)

                Spacer()
                Text(maxLabel)
                    .foregroundColor(.white)
            }
        }
    }
}

struct AchievementsLevelView: View {
    let level: String
    var body: some View {
        ZStack(alignment: .center) {
            Circle()
                .fill(.white)
            VStack(spacing: -3) {
                Text("Level")
                    .foregroundColor(.black)
                    .font(.headline)
                Text(level)
                    .foregroundColor(.black)
                    .font(.system(size: 40))
                    .fontWeight(.semibold)
            }
        }
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        let mockAchievementViewModel1 = AchievementViewModel(level: "1",
                                                             progress: 0.1,
                                                             minLabel: "10pts",
                                                             maxLabel: "50pts",
                                                             imageURL: URL(string: "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C850B103-B8C5-4518-8631-168BB42FFBBD.png"),
                                                             accessible: true)
        let mockAchievementViewModel2 = AchievementViewModel(level: "2",
                                                             progress: 0,
                                                             minLabel: "0pts",
                                                             maxLabel: "50pts",
                                                             imageURL: URL(string: "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/341E40C8-1C2A-400C-B67D-F490B74BDD81.png"),
                                                             accessible: false)
        let mockAchievementViewModel3 = AchievementViewModel(level: "3",
                                                             progress: 0,
                                                             minLabel: "0pts",
                                                             maxLabel: "50pts",
                                                             imageURL: URL(string: "https://cdn.zeplin.io/5a5f7e1b4f9f24b874e0f19f/screens/C60F6868-A0CD-4D9D-A3B9-3C460FA989FF.png"),
                                                             accessible: false)
        let mockAchievementsViewModel = AchievementsViewModel(title: "Smart Investing",
                                                              achievementViewModels: [mockAchievementViewModel1,
                                                                                      mockAchievementViewModel2,
                                                                                      mockAchievementViewModel3])

        AchievementsView(viewModel: mockAchievementsViewModel)
    }
}
