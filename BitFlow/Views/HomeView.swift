//
//  HomeView.swift
//  BitFlow
//
//  Created by Macbook Pro on 22/06/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showProfile: Bool = false
    var body: some View {
        ZStack{
            
            Color.bgColor.ignoresSafeArea()
            
            VStack{
                
                // header
                HomeViewHeader
                
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
}
