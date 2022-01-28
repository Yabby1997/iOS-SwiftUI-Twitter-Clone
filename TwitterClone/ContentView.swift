//
//  ContentView.swift
//  TwitterClone
//
//  Created by Seunghun Yang on 2022/01/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showMenu = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if self.viewModel.userSession == nil {
                LoginView()
            } else {
                mainInterfaceView
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    var mainInterfaceView: some View {
        ZStack(alignment: .topLeading) {
            MainTabView()
                .navigationBarHidden(self.showMenu)
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            withAnimation(.easeInOut) {
                                self.showMenu.toggle()
                            }
                        } label: {
                            Circle().frame(width: 32, height: 32)
                        }
                    }
                }
            
            if self.showMenu {
                ZStack {
                    Color(.black)
                        .opacity(self.showMenu ? 0.25 : 0)
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        self.showMenu = false
                    }
                }
                .ignoresSafeArea()
            }
            
            SideMenuView()
                .frame(width: 300)
                .offset(x: self.showMenu ? 0 : -300, y: 44)
                .background(self.showMenu ? Color.white : Color.clear)
                .ignoresSafeArea()
        }
        .onAppear {
            self.showMenu = false
        }
    }
}
