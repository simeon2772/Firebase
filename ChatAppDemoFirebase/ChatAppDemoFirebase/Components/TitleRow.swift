//
//  TitleRow.swift
//  ChatAppDemoFirebase
//
//  Created by Simeon Ivanov on 31.10.23.
//

import SwiftUI

struct TitleRow: View {
    var imageURl = URL(string: "https://www.zbrushcentral.com/uploads/default/original/4X/b/a/4/ba4534225c2d0b36ac17ae3c4fe605c344a500c7.jpeg")
    var name = "Yana Jones"
    
    var body: some View {
        HStack(spacing: 20) {
            AsyncImage(url: imageURl) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 80, height: 70)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title).bold()
                
                Text("Online")
                    .font(.caption)
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "phone.fill")
                .foregroundStyle(.gray)
                .padding(10)
                .background(.white)
                .clipShape(Circle())
        }
        .padding([.leading, .trailing])
    }
}

#Preview {
    TitleRow()
        .background(Color.customBlue)
}
