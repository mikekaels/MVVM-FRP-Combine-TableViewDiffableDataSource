//
//  StoreVM.swift
//  MultipleSectionsWithCombine
//
//  Created by Santo Michael on 10/08/23.
//

import Foundation
import Combine

internal final class StoreVM {
	let useCase: StoreUseCase
	
	init(useCase: StoreUseCase = StoreUseCase()) {
		self.useCase = useCase
	}
	
	enum DataSourceType: Hashable {
		case products(data: Product)
		case payment(data: Payment)
		case gift(data: Gift)
		case total(data: Int)
	}
}

extension StoreVM {
	struct Input {
		let getData: AnyPublisher<Void, Never>
		let itemDidSelect: AnyPublisher<IndexPath, Never>
		let refreshDidTap: AnyPublisher<Void, Never>
		let productEvent: AnyPublisher<(type: ProductCell.EventType, indexPath: IndexPath), Never>
	}
	
	class Output {
		@Published var dataSource: [DataSourceType] = []
		@Published var snapshootItems: SectionedArrayOf<StoreVC.Section, DataSourceType> = .init()
		var total: Int = 0
	}
	
	func transform(_ input: Input, cancellables: inout Set<AnyCancellable>) -> Output {
		let output = Output()
		
		input.getData
			.sink { [weak self] _ in
				guard let self = self else { return }
				
				let products = SectionedDataSource<StoreVC.Section, DataSourceType>(section: .product("Product"), items: self.useCase.getProducts().map {
					output.total += $0.price * $0.itemTotal
					return DataSourceType.products(data: $0)
				})
				
				let total = SectionedDataSource<StoreVC.Section, DataSourceType>(section: .total("Total"), items: [.total(data: output.total)])
				output.snapshootItems.append(products)
				output.snapshootItems.append(total)
			}
			.store(in: &cancellables)
		
		input.itemDidSelect
			.sink { index in
				if case .products = output.snapshootItems.getElement(index) {
					
					var newSnapshoot = output.snapshootItems.sectionedData.filter {
						$0.section == .product("Product")
					}
					
					let payment = SectionedDataSource<StoreVC.Section, DataSourceType>(section: .payment("Payment"), items: self.useCase.getPayments().map { item in
						return DataSourceType.payment(data: item)
					})
					
					let total = SectionedDataSource<StoreVC.Section, DataSourceType>(section: .total("Total"), items: [.total(data: output.total)]
					)
					
					newSnapshoot.append(payment)
					newSnapshoot.append(total)
					output.snapshootItems.sectionedData = newSnapshoot
				}
				
				if case .payment = output.snapshootItems.getElement(index) {
					
					var newSnapshoot = output.snapshootItems.sectionedData.filter {
						$0.section == .product("Product") || $0.section == .payment("Payment")
					}
					
					let gift = SectionedDataSource<StoreVC.Section, DataSourceType>(section: .gift("Gift"), items: self.useCase.getGifts().map { item in
						return DataSourceType.gift(data: item)
					})
					
					let total = SectionedDataSource<StoreVC.Section, DataSourceType>(section: .total("Total"), items: [.total(data: output.total)]
					)
					
					newSnapshoot.append(gift)
					newSnapshoot.append(total)
					output.snapshootItems.sectionedData = newSnapshoot
				}
			}
			.store(in: &cancellables)
		
		input.productEvent
			.sink { (event, indexPath) in
				if event == .increase, case var .products(data) = output.snapshootItems.getElement(indexPath) {
					data.itemTotal += 1
					output.total += data.price
					output.snapshootItems.sectionedData[indexPath.section].items[indexPath.row] = .products(data: data)
				}
				
				
				if event == .decrease, case var .products(data) = output.snapshootItems.getElement(indexPath) {
					if data.itemTotal > 1 {
						data.itemTotal -= 1
						output.total -= data.price
					}
					output.snapshootItems.sectionedData[indexPath.section].items[indexPath.row] = .products(data: data)
				}
				
				var newSnapshoot = output.snapshootItems.sectionedData.filter {
					$0.section != .total("Total")
				}
				
				let total = SectionedDataSource<StoreVC.Section, DataSourceType>(section: .total("Total"), items: [.total(data: output.total)]
				)
				
				newSnapshoot.append(total)
				output.snapshootItems.sectionedData = newSnapshoot
			}
			.store(in: &cancellables)
		
		input.refreshDidTap
			.sink { _ in
				let newSnapshoot = output.snapshootItems.sectionedData.filter {
					$0.section == .product("Product") || $0.section == .total("Total") 
				}
				output.snapshootItems.sectionedData = newSnapshoot
			}
			.store(in: &cancellables)
		
		return output
	}
}
