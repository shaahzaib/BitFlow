//
//  StatisticView.swift
//  BitFlow
//
//  Created by Macbook Pro on 15/08/2025.
//

import SwiftUI

struct StatisticView: View {
    
    let stat:StatisticsModel
    
    var body: some View {
        VStack {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.softGray)
            
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.accent)
            
            HStack{
                
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text(stat.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
                
            }
            .foregroundStyle((stat.percentageChange ?? 0) >= 0 ? Color.green : Color.red)
            .opacity(stat.percentageChange == nil  ? 0.0 : 1.0)
        }
    }
}

#Preview {
    StatisticView(stat: stat1 )
}
