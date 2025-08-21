//
//  ChartView.swift
//  BitFlow
//
//  Created by Macbook Pro on 20/08/2025.
//

import SwiftUI

struct ChartView: View {
    
    var data: [Double]
    
   private let minY : Double
    private let maxY : Double
    private let lineColor : Color
    private let startDate : Date
    private let endingDate : Date
    @State private var percetage : CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0  ? Color.green : Color.red
        
        endingDate = Date(coinString: coin.lastUpdated ?? "")
        startDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    var body: some View {
        ZStack {
            Color.bgColor.ignoresSafeArea()
            VStack{
                chartView
                    .frame(height: 200)
                    .background(GridLines)
                    .overlay(chartYaxis .padding(.horizontal,4), alignment: .leading)
                
                CoinDate
                    .padding(.horizontal,4)
            }
            .font(.caption)
            .foregroundStyle(Color.softGray.opacity(0.7))
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                    withAnimation(.linear(duration: 2.0)) {
                        percetage = 1.0
                    }
                }
            }
        }
    }
}

#Preview {
    ChartView(coin: CoinPreviewData)
}


extension ChartView{
    
    private var chartView: some View{
        GeometryReader{ geometry in
            Path{ path in
                for index in data.indices{
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    // subtracting from 1 to reverse the points as they give in downward ascending graph
                    let yPosition = (1 - CGFloat(data[index] - minY) / yAxis) * geometry.size.height
                    
                    if index == 0 {
                        path .move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0,to: percetage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
            .shadow(color: lineColor, radius: 10,x:0.0 ,y: 10)
            .shadow(color: lineColor.opacity(0.5), radius: 10,x:0.0 ,y: 20)
            .shadow(color: lineColor.opacity(0.2), radius: 10,x:0.0 ,y: 30)
            .shadow(color: lineColor.opacity(0.1), radius: 10,x:0.0 ,y: 40)
        }
    }
    
    private var GridLines: some View{
        VStack{
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYaxis:some View{
        VStack{
            Text(maxY.FormatwithAbbreviation())
            Spacer()
            let price = ((maxY + minY) / 2)
            Text(price.FormatwithAbbreviation())
            Spacer()
            Text(minY.FormatwithAbbreviation())
        }
    }
    
    private var CoinDate: some View{
        HStack{
            Text(startDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}
