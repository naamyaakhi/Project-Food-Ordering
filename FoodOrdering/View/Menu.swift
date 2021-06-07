//
//  Menu.swift
//  FoodOrdering
//
//  Created by Altamis Hail Ahsan Nasution on 01/03/21.
//

import SwiftUI

struct Menu: View {
   @ObservedObject var homeData: HomeViewModel
    var body: some View {
      VStack{
         Button(action: {}, label: {
            HStack(spacing: 15) {
               Image(systemName: "cart")
                  .font(.title)
                  .foregroundColor(.blue)
               
               Text("Cart")
                  .fontWeight(.bold)
                  .foregroundColor(.black)
               
               Spacer(minLength: 0)
            }
            .padding()
         })
         
         Spacer()
         
         HStack{
            Spacer()
            
            Text("Version 0.1")
               .fontWeight(.bold)
               .foregroundColor(.blue)
         }
         .padding(10)
      }
      .padding([.top,.trailing])
      .frame(width: UIScreen.main.bounds.width / 1.6)
      .background(Color.white.ignoresSafeArea())
    }
}
