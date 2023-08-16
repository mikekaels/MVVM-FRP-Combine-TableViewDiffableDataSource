//
//  StoreUseCase.swift
//  MultipleSectionsWithCombine
//
//  Created by Santo Michael on 10/08/23.
//

import Foundation

internal protocol StoreUseCaseProtocol {
	func getProducts() -> [Product]
	func getPayments() -> [Payment]
	func getGifts() -> [Gift]
}

internal final class StoreUseCase: StoreUseCaseProtocol {
	func getGifts() -> [Gift] {
		
		let data =
		[
			GiftResponse(giftTitle: "Netflix 90 days trial",
				 image: "https://www.citypng.com/public/uploads/preview/-11594687246vzsjesy7bd.png"),
			
			GiftResponse(giftTitle: "Disney Plus unlimited access",
				 image: "https://m.media-amazon.com/images/I/712ui3rj1RL.png"),
			
			GiftResponse(giftTitle: "Norton Antivirus Mac 90 days trial",
				 image: "https://now.symassets.com/content/dam/norton/global/images/non-product/logos/norton_logo.png"),
			
			GiftResponse(giftTitle: "Tesla Extended Warranty",
				 image: "https://oceansquare.com/wp-content/uploads/2018/04/tesla-logo-500.jpg"),
		]
			.map {
				Gift(id: UUID().uuidString, giftTitle: $0.giftTitle, image: $0.image)
			}
		let rand1 = Int.random(in: 0..<data.count)
		let rand2 = Int.random(in: rand1..<data.count)
		let result = data[rand1...rand2]
		return result.shuffled()
	}
	func getPayments() -> [Payment] {
		let data = 
		[
			PaymentResponse(paymentTitle: "Visa",
					image: "https://lavca.org/app/uploads/2019/07/VISA-logo-square.png"),
			
			PaymentResponse(paymentTitle: "Master",
					image: "https://static.dezeen.com/uploads/2016/07/mastercard-logo-redesign-pentagram-square_dezeen_936_0.jpg"),
			
			PaymentResponse(paymentTitle: "Bitcoin",
					image: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1200px-Bitcoin.svg.png"),
			PaymentResponse(paymentTitle: "GrabPay",
					image: "https://assets.grab.com/wp-content/uploads/sites/8/2021/11/26235239/GrabPay_Final_Logo_RGB_green_StackedVersion-01.png"),
			
			PaymentResponse(paymentTitle: "Paypal",
					image: "https://www.freepnglogos.com/uploads/paypal-logo-png-2.png")
		]
			.map {
				Payment(id: UUID().uuidString, paymentTitle: $0.paymentTitle, image: $0.image)
			}
		
		let rand1 = Int.random(in: 0..<data.count)
		let rand2 = Int.random(in: rand1..<data.count)
		let result = data[rand1...rand2]
		return result.shuffled()
	}
	
	func getProducts() -> [Product] {
		[
			ProductResponse(title: "Playstation control",
					image: "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/HPNG2?wid=1144&hei=1144&fmt=jpeg&qlt=90&.v=1665002952548",
							price: 199,
							itemTotal: 1
				   ),
			
			ProductResponse(title: "XBox",
					image: "https://cdn.shopify.com/s/files/1/0036/4806/1509/products/3872ba156d5595dad2c8c39ea1086a6fdf8c40c3_square2993231_1_1000x.jpg?v=1676652025",
							price: 569,
							itemTotal: 1
				   ),
			
			ProductResponse(title: "Nintendo Switch",
					image: "https://cdn.shopify.com/s/files/1/0972/9804/products/7_81b4007b-5980-49b6-b623-11e4be62d7ed.jpg?v=1591062593",
					price: 455,
					itemTotal: 1
				   )
		]
			.map {
				Product(id: UUID().uuidString, title: $0.title, image: $0.image, price: $0.price, itemTotal: $0.itemTotal)
			}
			.shuffled()
	}
}
