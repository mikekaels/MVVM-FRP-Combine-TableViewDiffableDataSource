//
//  Product.swift
//  MultipleSectionsWithCombine
//
//  Created by Santo Michael on 10/08/23.
//

import Foundation

internal struct Product: Hashable {
	let id: String
	let title: String
	let image: String
	let price: Int
	var itemTotal: Int
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(title)
		hasher.combine(image)
		hasher.combine(price)
	}
}

