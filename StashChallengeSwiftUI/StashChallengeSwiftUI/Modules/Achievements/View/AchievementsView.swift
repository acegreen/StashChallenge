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

    @State private var viewModel: AchievementsViewModel 

    mutating func configure(presenter: ModulePresenter) {
        assert(presenter is AchievementsModulePresenter, "presenter parameter must be of type AchievementsModulePresenter")
        self.presenter = presenter as? AchievementsModulePresenter
    }

    public init(viewModel: AchievementsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.achievementViewModels.indices, id: \.self) { index in
                    AchievementsCardView(achievementViewModel: $viewModel.achievementViewModels[index])
                }
            }
            .task {
                await self.updateView()
            }
            .refreshable {
                await self.updateView()
            }
            .padding(EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0))
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

    private func updateView() async {
        async {
            do {
                let viewModel = try await presenter.updateView()
                self.viewModel = viewModel
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct AchievementsCardView: View {
    @Binding var achievementViewModel: AchievementViewModel

    var body: some View {
        LazyVStack {
            ZStack {
                AsyncImage(url: achievementViewModel.imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .mask(RoundedRectangle(cornerRadius: 15))
                } placeholder: {
                    ProgressView()
                        .frame(width: 400, height: 300, alignment: .center)
                }
                VStack(alignment: .center, spacing: 24) {
                    AchievementsLevelView(level: achievementViewModel.level)
                        .frame(width: 100, height: 100, alignment: .center)
                    AchievementsProgressView(progress: Float(achievementViewModel.progress),
                                             minLabel: achievementViewModel.minLabel,
                                             maxLabel: achievementViewModel.maxLabel)

                }
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24))
            }
        }
        .opacity(achievementViewModel.accessible ? 1.0 : 0.5)
        .padding(EdgeInsets(top: 12, leading: 24, bottom: 0, trailing: 24))
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

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        let contextPresenter = AchievementsPresenter()
        let contextInteractor = AchievementsInteractor()
        let contextRouter = DefaultRouter()
        var contextView = AchievementsView(viewModel: AchievementsViewModel.makeMockAchievementsViewModel())

        contextPresenter.configure(view: contextView, interactor: contextInteractor, router: contextRouter)
        contextInteractor.configure(presenter: contextPresenter)
        contextView.configure(presenter: contextPresenter)

        return contextView
    }
}
