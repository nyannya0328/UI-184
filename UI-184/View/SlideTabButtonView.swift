//
//  SlideTabButtonView.swift
//  UI-184
//
//  Created by にゃんにゃん丸 on 2021/05/13.
//

import SwiftUI

struct SlideTabButtonView: View {
    @State var selected = "house.circle"
    @Namespace var animation
    @State var volume : CGFloat = 0.5
    @State var show = false
    var body: some View {
        VStack{
            
            Image("spotify")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack{
                
                TabButton(image: "house.circle", selected: $selected, animation: animation)
                
                TabButton(image: "desktopcomputer", selected: $selected, animation: animation)
                
                TabButton(image: "deskclock.fill", selected: $selected, animation: animation)
                
                TabButton(image: "cross.fill", selected: $selected, animation: animation)
                
            }
            .frame(height: getRect().height / 2.5)
            .padding(.top)
            
            
            
            
            
            Spacer(minLength: getRect().height < 750 ? 30 : 50)
            
            
            Button(action: {
                volume = volume + 0.1 < 1.0 ? volume + 0.1 : 1
                
            }, label: {
                Image(systemName: "speaker.wave.3.fill")
                    .font(.title)
                    .foregroundColor(.white)
            })
            
            GeometryReader{proxy in
                
                let Height = proxy.frame(in:.global).height
                
                let progress = Height * volume
                
                ZStack(alignment:.bottom){
                    
                    
                    Capsule()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width:5)
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 4, height: progress)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
            }
            .padding(.vertical,getRect().height < 750 ? 10 : 20)
            
            
            
            Button(action: {
                
                
                volume = volume - 0.1 > 0 ? volume - 0.1 : 0
                
            }, label: {
                Image(systemName: "speaker.wave.1")
                    .font(.title)
                    .foregroundColor(.white)
            })
            
            Button(action: {
                withAnimation(.easeIn){
                    
                    show.toggle()
                }
                
            }, label: {
                Image(systemName: show ? "chevron.right" : "chevron.left")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.black)
                    .shadow(radius: 10)
                    .cornerRadius(10)
            })
            .padding(.top,getRect().height < 750 ? 10 : 30)
            .padding(.bottom,getSafeArea().bottom == 0 ? 15 : 0)
            .offset(x: show ? 0 : 100)
            
    }
        .frame(width: 80)
        .background(Color.black.ignoresSafeArea())
        .offset(x: show  ? 0 : -100)
        .padding(.trailing,show ? 0 : -100)
        .zIndex(1)
        
    }
}

struct SlideTabButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SlideTabButtonView()
    }
}
struct TabButton : View {
    var image : String
    @Binding var selected : String
    var animation : Namespace.ID
    var body: some View{
        
        Button(action: {
            
            withAnimation{
                
                selected = image
            }
            
        }, label: {
            
            HStack(spacing:5){
                Image(systemName: image)
                    .font(.title)
                    .foregroundColor(selected == image ? .white : .gray)
                   
                
                
                if selected == image{
                    
                    Capsule()
                        .fill(Color.blue)
                        .frame(width: 5, height: 40)
                        .matchedGeometryEffect(id: "TAB", in: animation)
                }
                
                else{
                    
                    Capsule()
                        .fill(Color.clear)
                        .frame(width: 5, height: 40)
                }
            }
            .frame(maxHeight: .infinity)
            
            
            
        })
        
    }
}
