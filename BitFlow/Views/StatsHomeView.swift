//
//  StatsHomeView.swift
//  BitFlow
//
//  Created by Macbook Pro on 15/08/2025.
//

import SwiftUI

struct StatsHomeView: View {
    
    @EnvironmentObject var vm : CoinViewModel
    
    @Binding var showProfile: Bool
    
  
    var body: some View {
        HStack{
            
            ForEach(vm.statistics){ stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
               
            }
            
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showProfile ? .trailing : .leading)
        
    }
}

#Preview {
    StatsHomeView(showProfile: .constant(false))
        .environmentObject(coinVM)
}
