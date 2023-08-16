//
//  Payment.swift
//  MultipleSectionsWithCombine
//
//  Created by Santo Michael on 10/08/23.
//

import Foundation

internal struct Payment: Hashable {
	var id: String
	let paymentTitle: String
	let image: String
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
		hasher.combine(paymentTitle)
		hasher.combine(image)
	}
}
