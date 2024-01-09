//
//  ChartView.swift
//  CryptoTracker
//
//  Created by Микита Кузьмінов on 09.01.2024.
//

import SwiftUI

struct ChartView: View {
    
    @State var trimValue: CGFloat = 0
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private var endingDate: Date
    private var startingDate: Date
    
    init(coin: CoinModel) {
        self.data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.customGreen : Color.customRed
        
        endingDate = Date(coinDateString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartPriceOverlay)
                .font(.caption)
                .foregroundStyle(Color.secondaryText)
                .padding(.horizontal, 9)
            
            chartDateOverlay
                
        }
    }
}

#Preview {
    ChartView(coin: DeveloperPreview.instance.coin)
}

extension ChartView {
    
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0.0, to: trimValue)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2.0, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10, x: 0.0, y: 10.0)
            .shadow(color: lineColor.opacity(0.5), radius: 10, x: 0.0, y: 10.0)
            .shadow(color: lineColor.opacity(0.2), radius: 10, x: 0.0, y: 10.0)
            .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0.0, y: 10.0)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.linear(duration: 2.0)) {
                        trimValue = 1.0
                    }
                }
            }
        }
    }
    
    private var chartBackground: some View {
        ZStack {
            VStack {
                horizontalDividers()
            }
            
            HStack {
                verticalDividers()
            }
        }
    }
    
    private var chartPriceOverlay: some View {
            VStack() {
                Text("\(maxY.formattedWithAbbreviations())")
                Spacer()
                Text("\(((maxY + minY) / 2).formattedWithAbbreviations())")
                Spacer()
                Text("\(minY.formattedWithAbbreviations())")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var chartDateOverlay: some View {
        HStack {
            ForEach(0..<7) { index in
                if index == 6 {
                    VStack(spacing: 0) {
                        Text(endingDate.asDayString())
                        Text(endingDate.asMonthString())
                    }
                } else {
                    VStack(spacing: 0) {
                        Text(startingDate.addingTimeInterval(period(days: index)).asDayString())
                        Text(endingDate.addingTimeInterval(period(days: index)).asMonthString())
                    }
                    Spacer()
                }
            }
        }
        .font(.caption)
        .foregroundStyle(Color.secondaryText)
    }
    
    private func verticalDividers() -> some View {
        ForEach(0..<7) { index in
            if index == 6 {
                Divider()
            } else {
                Divider()
                Spacer()
            }
        }
    }
    
    private func horizontalDividers() -> some View {
        ForEach(0..<3) { index in
            if index == 2 {
                Divider()
            } else {
                Divider()
                Spacer()
            }
        }
    }
    
    private func period(days: Int) -> TimeInterval {
        return Double(days)*24*60*60
    }
}
