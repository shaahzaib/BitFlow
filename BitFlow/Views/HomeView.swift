//
//  HomeView.swift
//  BitFlow
//
//  Created by Macbook Pro on 22/06/2025.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var coinVM : CoinViewModel
    @State private var showProfile: Bool = false // for animation
    @State private var showProfileView : Bool = false // to switch to Profile View
    @State private var showsettingsView : Bool = false // to switch to Settings View
    @State private var selectedCoin: CoinModel? = nil
    @State private var showDetails: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack{
                Color.bgColor.ignoresSafeArea()
                    .sheet(isPresented: $showProfileView, content: {
                        ProfileView()
                            .environmentObject(coinVM)
                    })
                
                
                VStack(spacing: 0){
                    // header
                    HomeViewHeader
                    
                    //statistics
                    StatsHomeView(showProfile: $showProfile)
                    
                    // searchBar
                    SearchBarView(searchText: $coinVM.searchtext)
                    Spacer()
                    
                    // titles
                    TitleBar
                    
                    // coin listings
                    if !showProfile{
                        AllCoins
                            .transition(.move(edge: .leading))
                    }
                    else{
                        ProfileCoins
                            .transition(.move(edge: .trailing))
                    }
                    Spacer(minLength: 0)
                    
                }
                .sheet(isPresented: $showsettingsView, content: {
                    SettingsView()
                })
            }
            .navigationDestination(isPresented: $showDetails) {
                CoinDetailLoadingView(coin: $selectedCoin)                            }
        }
    }
    
}

#Preview {
    NavigationView {
        HomeView()
            .navigationBarHidden(true)
    }
    .environmentObject(CoinViewModel())
    
}


extension HomeView{
    
    // MARK: - HomeViewHeader
    private var HomeViewHeader: some View{
        HStack{
            CircleButton(iconName: showProfile ? "plus" : "info")
                .animation(.none,value: showProfile)
                .onTapGesture {
                    if showProfile{
                        showProfileView.toggle()
                    }else{
                        showsettingsView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimation(animate: $showProfile)
                )
            
            Spacer()
            
            Text(showProfile ? "Profile" : "Hot")
                .font(.title)
                .bold()
                .foregroundStyle(Color.Accent)
                .animation(.none,value: showProfile)
            
            Spacer()
            CircleButton(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showProfile ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring) {
                        showProfile.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    
    //MARK: - AllCoins
    private var AllCoins:some View{
        List{
            ForEach(coinVM.allCoins){coin in
                CoinRowView(coin: coin, showHoldings: false)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
        }
         .listRowBackground(Color.bgColor)
        }
        .scrollContentBackground(.hidden)
    }
    
    //MARK: - ProfileCoins
    private var ProfileCoins:some View{
        List{
            ForEach(coinVM.profileCoins){coin in
                CoinRowView(coin: coin, showHoldings: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                    .onTapGesture {
                        segue(coin: coin)
                    }
        }
           .listRowBackground(Color.bgColor)
        }
        .scrollContentBackground(.hidden)
       
    }
    
    
    //MARK: - Segue
    private func segue(coin: CoinModel){
        selectedCoin = coin
        showDetails.toggle()
    }
    
    //MARK: -TitleBar
    private var TitleBar:some View{
        
        HStack{
            HStack{
                Text("Coin")
                
                Image(systemName: "chevron.down")
                    .opacity((coinVM.sortOption == .price || coinVM.sortOption == .priceRevesed) ? 1.0 : 0.0 )
                    .rotationEffect(Angle(degrees: coinVM.sortOption == .price ? 0 : 180 ))
            }
            .onTapGesture {
                withAnimation(.default) {
                    coinVM.sortOption = coinVM.sortOption == .price ? .priceRevesed : .price
                }
            }
            Spacer()
            if  showProfile{
                Text("Holdings")
            }
            
            Text("Price")
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    coinVM.reloadCoins()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: coinVM.isLoading ? 360 : 0), anchor: .center)

        }
        .font(.callout)
        .foregroundStyle(Color.Accent)
        .padding(.horizontal,40)
        
        
    }
}
