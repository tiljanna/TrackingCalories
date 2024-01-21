//
//  ContentView.swift
//  TrackingCalories
//
//  Created by Putut Yusri Bahtiar on 19/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var addView: Bool = false
    @State private var selectedFood: FoodsModel?
    
    @State var dummyFoods: [FoodsModel] = []
    
    private var totalCalories: Int {
        dummyFoods.reduce(0) {$0 + $1.calories}
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                Text("Total consumed calories")
                    .font(.system(size: 28))
                
                Text("\(totalCalories)")
                    .font(.system(size: 28))
                
                SummaryDashboard
                
                List {
                    ForEach(dummyFoods) { index in
                        HStack{
                            Text(index.name)
                            Spacer()
                            Text("\(index.calories)")
                        }
                        .padding(.vertical, 10)
                    }
                    .onDelete(perform: { indexSet in
                        deleteItem(indexSet: indexSet)
                    })
                }
                .listStyle(.inset)
                .onChange(of: selectedFood) {
                    guard let newFood = selectedFood else { return }
                    dummyFoods.append(newFood)
                    selectedFood = nil
                }
                
                
                Button(action: {
                    addView.toggle()
                }, label: {
                    Text("Add Food")
                        .foregroundStyle(.white)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal)
                })
            }
            .fullScreenCover(isPresented: $addView, content: {
                AddFoodView(addFood: $addView, selectedFood: $selectedFood)
            })
        }
    }
    
    func deleteItem(indexSet: IndexSet) {
        dummyFoods.remove(atOffsets: indexSet)
    }
}

#Preview {
    ContentView()
}

var SummaryDashboard: some View {
    RoundedRectangle(cornerRadius: 8)
        .stroke(.black, lineWidth: 1.0)
        .foregroundStyle(.clear)
        .frame(width: 340, height: 110)
        .overlay {
            VStack {
                Text("Food diary")
                    .font(.system(size: 18))
                    .padding(.bottom)
                
                HStack(spacing: 80) {
                    VStack {
                        Text("29g")
                            .font(.system(size: 15))
                            .foregroundStyle(.blue)
                        
                        Text("Carbs")
                            .font(.system(size: 15))
                    }
                    
                    VStack {
                        Text("34g")
                            .font(.system(size: 15))
                            .foregroundStyle(.purple)
                        
                        Text("Fat")
                            .font(.system(size: 15))
                    }
                    
                    VStack {
                        Text("29g")
                            .font(.system(size: 15))
                            .foregroundStyle(.red)
                        
                        Text("Protein")
                            .font(.system(size: 15))
                    }
                }
            }
        }
}
