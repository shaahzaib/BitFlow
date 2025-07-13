//
//  HomeView.swift
//  BitFlow
//
//  Created by Macbook Pro on 22/06/2025.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var coinVM : CoinViewModel
    @State private var showProfile: Bool = false
    
    var body: some View {
        ZStack{
        Color.bgColor.ignoresSafeArea()
            
            
            
            VStack(spacing: 0){
              
                // header
                HomeViewHeader
                
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
        }
           .listRowBackground(Color.bgColor)
        }
        .scrollContentBackground(.hidden)
       
    }
    
    //MARK: -TitleBar
    private var TitleBar:some View{
        
        HStack{
            
            Text("Coin")
            
            Spacer()
            
            if  showProfile{
                Text("Holdings")
            }
            
            Text("Price")
            
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.Accent)
        .padding(.horizontal,40)
        
        
    }
}
