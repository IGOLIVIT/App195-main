//
//  Users_3.swift
//  App195
//
//  Created by Вячеслав on 9/14/23.
//

import SwiftUI

struct Users_3: View {
    
    let telegram: URL
    let isContacts: Bool
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                Image("users_3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack(spacing: 8, content: {
                    
                    Text("Join our Telegram Channel")
                        .foregroundColor(.black)
                        .font(.system(size: 23, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("And trade with our team")
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.center)
                })
                .padding(.vertical, 30)
                
                Spacer()
                
                Button(action: {
                    
                    UIApplication.shared.open(telegram)
                    
                }, label: {
                    
                    Text("Join")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color(red: 0/255, green: 174/255, blue: 237/255)))
                        .padding()
                })
                
                NavigationLink(destination: {
                    
                    if isContacts == true {
                        
                        Users_4()
                            .navigationBarBackButtonHidden()
                        
                    } else if isContacts == false {
                        
                        Users_5()
                            .navigationBarBackButtonHidden()
                    }
                    
                }, label: {
                    
                    Text("Skip")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 30)
                })
            }
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}

struct Users_3_Previews: PreviewProvider {
    static var previews: some View {
        Users_3(telegram: URL(string: "h")!, isContacts: false)
    }
}
