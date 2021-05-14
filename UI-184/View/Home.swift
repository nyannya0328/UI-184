//
//  Home.swift
//  UI-184
//
//  Created by にゃんにゃん丸 on 2021/05/13.
//

import SwiftUI

struct Home: View {
    
    @State var txt = ""
    var body: some View {
        
        HStack(spacing:0){
            
            SlideTabButtonView()
            
            ScrollView(.vertical, showsIndicators: false, content: {
                
                
                VStack{
                    
                    HStack(spacing:15){
                        
                        HStack(spacing:15){
                            
                            
                            Circle()
                                .stroke(Color.white,lineWidth: 5)
                                .frame(width: 25, height: 25)
                            
                            TextField("Entert", text: $txt)
                            
                           
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal,20)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(8)
                        
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image("pro")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        })
                        
                    }
                    
                    Text("Recent Play")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,30)
                    
                    TabView{
                        
                        ForEach(recentlyPlayed){item in
                            
                            GeometryReader{proxy in
                                
                                
                                
                                ZStack(alignment:.bottomLeading){
                                    
                                    Image(item.album_cover)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: proxy.frame(in: .global).width,height: 350)
                                        .cornerRadius(10)
                                        .overlay(
                                        
                                            LinearGradient(gradient: .init(colors: [.clear,.clear,.black]), startPoint: .top, endPoint: .bottom)
                                                .cornerRadius(20)
                                        
                                        )
                                    
                                    
                                    HStack{
                                        
                                        
                                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                            Image(systemName: "play.fill")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                                .padding(20)
                                                .background(Color("logo"))
                                                .clipShape(Circle())
                                        })
                                        
                                        VStack(alignment: .leading, spacing: 15, content: {
                                            Text(item.album_name)
                                                .font(.title2)
                                                .fontWeight(.heavy)
                                            
                                            Text(item.album_author)
                                                .font(.none)
                                                .fontWeight(.bold)
                                        })
                                        .foregroundColor(.white)
                                    }
                                    .padding()
                                    
                                }
                                
                                
                            }
                            .padding(.horizontal)
                            .frame(height: 350)
                            
                            
                            
                            
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .frame(height: 350)
                    
                    .padding(.top,20)
                    
                    Text("Genres")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,30)
                    let columns = Array(repeating: GridItem(.flexible(),spacing: 15), count: 3)
                    let columns2 = Array(repeating: GridItem(.flexible(),spacing: 15), count: 2)
                    
                    LazyVGrid(columns: columns,spacing: 15, content: {
                        
                        
                        ForEach(generes,id:\.self){index in
                            
                            Text(index)
                                
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding(.vertical,8)

                                .frame(maxWidth: .infinity)
                                .background(Color.white.opacity(0.5))
                                .cornerRadius(10)
                                
                            
                        }
                       
                    })
                    .padding(.top,20)
                    Text("Liked Song")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.top,30)
                    
                    
                    LazyVGrid(columns: columns2,spacing: 15, content: {
                        
                        
                        ForEach(likedSong.indices,id:\.self){index in
                            
                            GeometryReader{proxy in
                                
                                
                                Image(likedSong[index].album_cover)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: proxy.frame(in: .global).width, height: 150)
                                    .clipShape(CustomCorner(radi: 15, corner: index % 2 == 0 ? [.topLeft,.bottomLeft] : [.topRight,.bottomRight]))
                                
                                
                                
                                
                            }
                            .frame(height: 150)
                            
                        
                            
                            
                        }
                       
                    })
                    
                    
                    
                    
                    
                }
                .padding()
                .frame(maxWidth: .infinity)
               
            })
            
            
        }
      .background(Color("bg").ignoresSafeArea())
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct CustomCorner : Shape {
    var radi : CGFloat
    var corner : UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: radi, height: radi))
        
        return Path(path.cgPath)
    }
}




extension View{
    
    func getRect()->CGRect{
        
        return UIScreen.main.bounds
    }
    
    func getSafeArea()->UIEdgeInsets{
        
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
