//
//  ProfileView.swift
//  BitFlow
//
//  Created by Macbook Pro on 16/08/2025.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var vm: CoinViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
     
            
            NavigationView{
                ZStack {
                    Color.bgColor.ignoresSafeArea()
                ScrollView{
                    VStack{
                        SearchBarView(searchText: $vm.searchtext)
                        
                        // search results
                        ResultCoinList
                        
                        
                        // input section
                        if selectedCoin != nil{
                            profileInputSection
                        }
                    }
                }
                .navigationTitle("Edit Profile")
                .toolbar {
                    ToolbarItem(placement: . navigationBarTrailing) {
                        navBarButton
                    }
                }
                .onChange(of: vm.searchtext) { value in
                    if value == ""{
                        removeSelectedCoin()
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
        .environmentObject(coinVM)
}


extension ProfileView{
    
    private var ResultCoinList:some View{
        ScrollView(.horizontal,showsIndicators: true, content:{
            LazyHStack(spacing:10){
                ForEach(vm.searchtext.isEmpty ? vm.profileCoins : vm.allCoins){ coin in
                    CoinLogoView(coin: coin)
                        .frame(width:75,height:110)
                        .padding(4)
                        .onTapGesture{
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke( selectedCoin?.id == coin.id ? Color.green : Color.clear
                                         , lineWidth: 1)
                        }
                }
                
            }
            .frame(height: 120)
            .padding(.leading)
        })
    }
    
    // updates the currentholdings in edit profile section
     func updateSelectedCoin(coin: CoinModel){
        
        selectedCoin = coin
        
        if let profileCoin = vm.profileCoins.first(where: { $0.id == coin.id }),
           let amount = profileCoin.currentHoldings {
            quantityText = "\(amount)"
        }else{
            quantityText = ""
        }
    }
    
    private func getCurrentValue()->Double{
        
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var profileInputSection: some View{
        VStack(spacing: 20){
            HStack{
                Text("Current price of \( selectedCoin?.symbol.uppercased() ?? ""):")
                
                Spacer()
                
                Text(selectedCoin?.currentPrice.asCurrency() ?? "" )
            }
            
            
            Divider()
            
            HStack{
                Text("Amount holding: ")
                Spacer()
                TextField("Ex: 1.8", text: $quantityText)
                    .multilineTextAlignment(.trailing )
                    .keyboardType(.decimalPad)
            }
            
            
            Divider()
            
            HStack{
                Text("Current Value: ")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
            
        }
        .padding()
        .font(.headline)
        .foregroundStyle(Color.accent)
        
    }
    

    private var navBarButton: some View{
        HStack(spacing: 10){
            Image(systemName: "checkmark")
                .opacity(showCheckMark ? 1.0 : 0.0)
            Button {
                saveButtonPressed()
            } label: {
                Text("Save".uppercased())
            }
        }
        .opacity(
            (selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
        )
        .font(.headline)
        .foregroundStyle(Color.accent)
    }
    
    private func saveButtonPressed(){
        guard
            let coin = selectedCoin,
        let amount = Double(quantityText)
        else{
            return
        }
        
        // save to profile
        vm.upadteProfile(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
        // dismiss keyboard
        UIApplication.shared.inputAccessoryView?.endEditing(false)
        
        
        //hide checkmark
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchtext = ""
    }
}
