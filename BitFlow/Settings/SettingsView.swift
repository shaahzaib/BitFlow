//
//  SettingsView.swift
//  BitFlow
//
//  Created by Macbook Pro on 25/08/2025.
//


import SwiftUI

struct SettingsView: View {
    
    let linkedInUrl = URL(string: "https://www.linkedin.com/in/shahzaib-chohan/")!
    let githubAppUrl = URL(string: "https://github.com/shaahzaib/BitFlow")!
    let githubUrl = URL(string: "https://github.com/shaahzaib")!
    let coinGeckoUrl = URL(string: "https://www.coingecko.com")!
    let defaulturl = URL(string: "https://www.google.com")!
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.bgColor.ignoresSafeArea()
                List{
                    AppInfoSection
                    CryptoWebSection
                    DeveloperSection
                    ApplicationSection
                       
                }
               
                .listStyle(.grouped)
                .scrollContentBackground(.hidden)
            }
            .font(.headline)
            .accentColor(.blue)
            .navigationTitle("Settings")
            
        }
        
    }
}

#Preview {
    SettingsView()
}

extension SettingsView{
    
    private var AppInfoSection:some  View{
        Section {
            VStack(alignment: .leading){
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app works like a Crypto Vault built in SwiftUI framework using MVVM Architecture, Combine and CoreData.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.softGray)
                
            }
            .padding(.vertical)
            
            Link("Get App", destination: githubAppUrl)
                
        }header: {
            Text("App Info")
                .foregroundStyle(Color.accent)
        }
        .listRowBackground(Color.bgColor)
    }
    
    private var CryptoWebSection:some  View{
        Section {
            VStack(alignment: .leading){
                Image("CoinGecko")
                    .resizable()
                    .frame(height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("The crypto currency data used in this app fetched from a free API from CoinGecko, a leading cryptocurrency data platform that provides real-time information on prices and other details.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.softGray)
                
            }
            
            .padding(.vertical)
            Link("Visit CoinGecko", destination: coinGeckoUrl)
            
        } header: {
            Text("CoinGecko")
                .foregroundStyle(Color.accent)
        }
        .listRowBackground(Color.bgColor)
    }
    
    private var DeveloperSection:some  View{
        Section {
            VStack(alignment: .leading){
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text("This app was developed by Shahzaib. It uses SwiftUI and 100% written in Swift. The project benefits from multi-threading, publishers/subscribers and data persistance")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.softgray)
                
            }
            .padding(.vertical)
            
            Link("Visit Website", destination: githubUrl)
            Link("Connect on LinkedIn", destination: linkedInUrl)
            
        } header: {
            Text("Developer ")
                .foregroundStyle(Color.accent)
        }
        .listRowBackground(Color.bgColor)
    }
    
    private var ApplicationSection:some  View{
        Section {
            Link("Terms & Services", destination: defaulturl)
            Link("Privacy Policy", destination: defaulturl)
            Link("Company Website", destination: defaulturl)
            Link("Learn More", destination: defaulturl)
            
            
        } header: {
            Text("Application")
                .foregroundStyle(Color.accent)
        }
        .listRowBackground(Color.bgColor)
    }
}
