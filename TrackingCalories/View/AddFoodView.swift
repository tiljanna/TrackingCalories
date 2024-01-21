//
//  AddFoodView.swift
//  TrackingCalories
//
//  Created by Putut Yusri Bahtiar on 20/01/24.
//

import SwiftUI

struct AddFoodView: View {
    
    @Binding var addFood: Bool
    @Binding var selectedFood: FoodsModel?
    
    @State var dummyFoods: [FoodsModel] = [
        FoodsModel(name: "Baked Potato", calories: 212),
        FoodsModel(name: "baked Potate with Sour Cream", calories: 338),
        FoodsModel(name: "Boiled Potato", calories: 559),
        FoodsModel(name: "Broccoli", calories: 68),
        FoodsModel(name: "Cabbage", calories: 61),
        FoodsModel(name: "Carrot", calories: 23),
        FoodsModel(name: "Chicken Breast fillet", calories: 132),
        FoodsModel(name: "Duck", calories: 251),
        FoodsModel(name: "Abalone", calories: 157),
        FoodsModel(name: "Bass", calories: 384),
        FoodsModel(name: "Lobster", calories: 124),
        FoodsModel(name: "Mackerel", calories: 155),
    ]
    
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            Button(action: {
                addFood.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            })
            
            Spacer()
            
            NavigationStack {
                List {
                    ForEach(searchAbleResults) { index in
                        Button(action: {
                            selectedFood = index
                            addFood.toggle()
                        }, label: {
                            HStack {
                                Text(index.name)
                                Spacer()
                                HStack(spacing: 0) {
                                    Text("(")
                                        .foregroundStyle(.blue)
                                    Text("\(index.calories)")
                                    Text(")")
                                        .foregroundStyle(.blue)
                                    
                                }
                            }
                            .padding(.vertical)
                        })
                    }
                }
                .searchable(text: $searchText, placement: .toolbar)
                .autocorrectionDisabled()
                .listStyle(.inset)
            }
            
            Spacer()
        }
    }
}

#Preview {
    AddFoodView(addFood: .constant(false), selectedFood: .constant(FoodsModel(name: "Example", calories: 0)))
}


extension AddFoodView {
    var searchAbleResults: [FoodsModel] {
        if searchText.isEmpty {
            return dummyFoods
        } else {
            return dummyFoods.filter { $0.name.contains(searchText) }
        }
    }
}
