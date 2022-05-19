//
//  EventsFeatured.swift
//  Events Radar
//
//  Created by Alejandro on 5/5/22.
//

import SwiftUI

struct EventsFeatured: View {
    
    @EnvironmentObject var vm: ViewModel

    var body: some View {
        ScrollView {
        VStack {
//            Text("Featured Events")
//                .fontWeight(.thin)
//                .padding()
//                .font(.largeTitle)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .background(Color(hue: 0.553, saturation: 0.784, brightness: 0.644))
//                .foregroundColor(.white)
            
            Text("Most Liked")
                .fontWeight(.thin)
                .padding()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(vm.myImages) { MyImage in
                        VStack {
                            Image(uiImage: MyImage.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .shadow(color: .black.opacity(0.6), radius: 2, x: 2, y: 2)
                            Text(MyImage.name)
                        }
                        .onTapGesture {
                            vm.display(MyImage)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Text("Music")
                .fontWeight(.thin)
                .padding()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(vm.myImages) { MyImage in
                        VStack {
                            Image(uiImage: MyImage.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .shadow(color: .black.opacity(0.6), radius: 2, x: 2, y: 2)
                            Text(MyImage.name)
                        }
                        .onTapGesture {
                            vm.display(MyImage)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Text("Social")
                .fontWeight(.thin)
                .padding()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(vm.myImages) { MyImage in
                        VStack {
                            Image(uiImage: MyImage.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .shadow(color: .black.opacity(0.6), radius: 2, x: 2, y: 2)
                            Text(MyImage.name)
                        }
                        .onTapGesture {
                            vm.display(MyImage)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            Text("Unrest")
                .fontWeight(.thin)
                .padding()
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(vm.myImages) { MyImage in
                        VStack {
                            Image(uiImage: MyImage.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .shadow(color: .black.opacity(0.6), radius: 2, x: 2, y: 2)
                            Text(MyImage.name)
                        }
                        .onTapGesture {
                            vm.display(MyImage)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
        }
            Spacer()
        }
    }
}

struct EventsFeatured_Previews: PreviewProvider {
    static var previews: some View {
        EventsFeatured()
    }
}
