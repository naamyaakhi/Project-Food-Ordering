import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    
    var body: some View {
        ZStack{
            VStack(spacing: 10){
                HStack(spacing: 15){
                    Button(action:{
                        withAnimation(.easeIn){HomeModel.showMenu.toggle() }
                    },label:{
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(Color.purple)
                    })
                    
                    Text(HomeModel.userLocation == nil ? "Locating......" : "Deliver to")
                        .background(Color.black)
                    
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.red)
                    
                    Spacer(minLength: 0)
                }
                    
                .padding([.horizontal , .top])
                
                // Divider adalah garis pembatas bisa vertikal ama horizontal sesuai Stackny ( HStack , VStack , ZStack )
                Divider()
                
                HStack(spacing: 15){
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                        .foregroundColor(Color.gray)
                    TextField("Search" , text: $HomeModel.search)
                }
                    
                .padding(.horizontal)
                .padding(.top , 10)
                
                
                Divider()
                
                
                ScrollView(.vertical,showsIndicators: false, content: {
                    VStack(spacing: 25){
                        ForEach(HomeModel.filtered) {item in
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .center), content: {
                                ItemView(item: item)
                                
                                HStack{
                                    Text("Free Delivery")
                                        .foregroundColor(.white)
                                        .padding(.vertical,10)
                                        .padding(.horizontal)
                                        .background(Color.blue)
                                    
                                    Spacer(minLength: 0)
                                    
                                    Button(action: {},label: {
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Color.blue)
                                            .clipShape(Circle())
                                    })
                                }
                                    
                                .padding(.trailing,10)
                                .padding(.top,10)
                            } )
                                
                                .frame(width: UIScreen.main.bounds.width - 30)
                            
                        }
                    }
                    .padding(.top,10)
                })
            }
            
            HStack{
                Menu(homeData: HomeModel)
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.5)
                
                Spacer()
            }
                
            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
            .onTapGesture(perform: {
                withAnimation(.easeIn){HomeModel.showMenu.toggle()}
            })
            )
        }
        .onAppear(perform: {
            HomeModel.locationManager.delegate = HomeModel
        })
            
            .onChange(of: HomeModel.search,perform: {value in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    if value == HomeModel.search && HomeModel.search != ""{
                        HomeModel.fetchData()
                    }
                    
                }
                
                if HomeModel.search == ""{
                    withAnimation(.linear) {HomeModel.filtered = HomeModel.items}
                }
                
            })
    }
    
}
