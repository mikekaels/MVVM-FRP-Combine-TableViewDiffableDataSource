//
//  Gift.swift
//  MultipleSectionsWithCombine
//
//  Created by Santo Michael on 10/08/23.
//

import Foundation

internal struct Gift: Hashable {
	let id: String
	let giftTitle: String
	let image: String
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(giftTitle)
		hasher.combine(image)
	}
}
