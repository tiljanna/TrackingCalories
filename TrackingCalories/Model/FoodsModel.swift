//
//  FoodsModel.swift
//  TrackingCalories
//
//  Created by Putut Yusri Bahtiar on 20/01/24.
//

import Foundation

struct FoodsModel: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let calories: Int
    
    static func == (lhs: FoodsModel, rhs: FoodsModel) -> Bool {
        lhs.id == rhs.id
      }
}
