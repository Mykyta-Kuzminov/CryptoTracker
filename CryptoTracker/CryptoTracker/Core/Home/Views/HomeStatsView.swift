//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 02.01.2024.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack() {
            ForEach(vm.statistics) { stat in
                StatisticView(stat: stat)
            }
            .frame(width: UIScreen.main.bounds.width / 3)
        }
        .frame(width: UIScreen.main.bounds.width, alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(HomeViewModel())
}
