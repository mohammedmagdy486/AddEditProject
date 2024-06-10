//
//  SearchBarView.swift
//  
//
//  Created by Mohammed Magdy on 4/11/23.
//

import SwiftUI
struct SearchBar: View {
    @Binding var text: String
    @State private var isEditing = false
    
    var body: some View {
        ZStack {
            
            TextField("Search ...".localized(), text: $text).frame(height: 45)
                .padding(7)
                .padding(.horizontal, 10)
                .background(Color(uiColor: UIColor(hex: "F4F5F9")))
                .cornerRadius(10)
                .padding(.horizontal, 10).textCase(.lowercase)
                .onTapGesture {
                    self.isEditing = true
                }.padding()
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                }) {
                    HStack{Spacer()
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(Asset.mainOrangeColor.name))
                    .padding(.trailing, 30)
                    
                }
                }
                .padding(.trailing, 10)
               
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
