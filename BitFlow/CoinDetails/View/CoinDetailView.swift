//
//  CoinDetailView.swift
//  BitFlow
//
//  Created by Macbook Pro on 20/08/2025.
//

import SwiftUI

struct CoinDetailView: View {
    
    @StateObject private var vm : CoinDetailViewModel
    @State private var showFullDescription : Bool = false
    
    private let columns:[GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    private let spacing: CGFloat = 30
    
    init(coin: CoinModel) {
        _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
        print("initializig details for \(coin.name)")
    }
    var body: some View {
        ZStack{
            Color.bgColor.ignoresSafeArea()
            ScrollView{
                VStack {
                    ChartView(coin: vm.coin)
                    .padding(.vertical)
                    
                    VStack(spacing: 20){
                        overviewTitle
                        Divider()
                        descriptionSection
                        overviewContent
                        additionalTitle
                        Divider()
                        additionalContet
                        websiteSection
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(vm.coin.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                navBarItems
            }
        }
        .toolbarRole(.editor)
         //.toolbarBackground(Color.bgColor, for: .navigationBar)
    }
}

struct CoinDetailLoadingView: View {
    @Binding var coin: CoinModel?
    var body: some View {
        ZStack{
            if let coin = coin{
                CoinDetailView(coin: coin)
            }
        }
    }
}

#Preview {
    NavigationStack{
        CoinDetailView(coin: CoinPreviewData)
    }
    
}

extension CoinDetailView{
    
    private var navBarItems: some View{
        HStack{
            Text(vm.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.softGray)
                .opacity(0.7)
            
                CoinImageView(coin: vm.coin)
                .frame(width: 25,height: 25)
        }
    }
    
    private var overviewTitle:some View{
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var additionalTitle:some View{
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.accent)
            .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var overviewContent:some View{
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            ForEach(vm.overviewStatistics){ stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalContet:some View{
        LazyVGrid(columns: columns,
                  alignment: .leading,
                  spacing: spacing,
                  pinnedViews: []) {
            ForEach(vm.additionalStatistics){stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var descriptionSection : some View{
        ZStack{
            if let coinDescription = vm.coinDescription,
               !coinDescription.isEmpty{
                 VStack(alignment: .leading) {
                 Text(coinDescription)
                 .lineLimit(showFullDescription ? nil : 3)
                 .font(.callout)
                 .foregroundStyle(Color.softGray)
                
                    Button {
                     showFullDescription.toggle()
                    } label: {
                        Text(showFullDescription ? "See less" : "Read more...")
                      .font(.caption)
                      .bold()
                    }
                }
            }
        }
    }
    
    
    private var websiteSection: some View{
        VStack(alignment: .leading ,spacing: 20){
            if let websiteString = vm.websiteURL,
                let url = URL(string: websiteString){
                Link("Website", destination: url)
            }
            
            if let redditUrl = vm.redditURL,
               let url = URL(string: redditUrl){
                Link("Reddit", destination: url)
            }
        }
        .accentColor(.blue)
        .font(.title3.bold())
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
