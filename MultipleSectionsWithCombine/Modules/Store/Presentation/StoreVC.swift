//
//  StoreVC.swift
//  MultipleSectionsWithCombine
//
//  Created by Santo Michael on 10/08/23.
//

import UIKit
import Combine
import CombineCocoa

internal final class StoreVC: UIViewController {
	enum Section: Hashable, CaseIterable {
		case product(String)
		case payment(String)
		case gift(String)
		case total(String)
		
		static var allCases: [Self] = []
	}
	
	let viewModel: StoreVM
	var cancellables = Set<AnyCancellable>()
	private let refreshPublisher = PassthroughSubject<Void, Never>()
	internal let productEeventPublisher = PassthroughSubject<(type: ProductCell.EventType, indexPath: IndexPath), Never>()
	
	init(viewModel: StoreVM = StoreVM()) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		bindViewModel()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
	}
	
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
		tableView.register(PaymentCell.self, forCellReuseIdentifier: PaymentCell.identifier)
		tableView.register(GiftCell.self, forCellReuseIdentifier: GiftCell.identifier)
		tableView.register(TotalCell.self, forCellReuseIdentifier: TotalCell.identifier)
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()
	
	private lazy var dataSource = SectionedTableDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
		switch itemIdentifier {
		case let .products(product):
			let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
			cell.set(imageURL: product.image)
			cell.set(title: product.title)
			cell.set(price: product.price)
			cell.set(itemTotal: product.itemTotal)
			cell.eventPublisher
				.sink { [weak self] type in
					self?.productEeventPublisher.send((type: type, indexPath: indexPath))
				}
				.store(in: &cell.cancellables)
			return cell
			
		case let .payment(payment):
			let cell = tableView.dequeueReusableCell(withIdentifier: PaymentCell.identifier, for: indexPath) as! PaymentCell
			cell.set(paymentTitle: payment.paymentTitle)
			cell.set(imageURL: payment.image)
			return cell
			
		case let .gift(gift):
			let cell = tableView.dequeueReusableCell(withIdentifier: GiftCell.identifier, for: indexPath) as! GiftCell
			cell.set(imageURL: gift.image)
			cell.set(giftTitle: gift.giftTitle)
			return cell
			
		case let .total(price):
			let cell = tableView.dequeueReusableCell(withIdentifier: TotalCell.identifier, for: indexPath) as! TotalCell
			cell.set(total: price)
			return cell
		}
		
		
	}
	
	private func bindViewModel() {
		let input = StoreVM.Input(getData: Just(()).eraseToAnyPublisher(),
								  itemDidSelect: tableView.didSelectRowPublisher.eraseToAnyPublisher(),
								  refreshDidTap: refreshPublisher.eraseToAnyPublisher(),
								  productEvent: productEeventPublisher.eraseToAnyPublisher()
		)
		let output = viewModel.transform(input, cancellables: &cancellables)

		output.$snapshootItems
			.sink { [weak self] sectionedArray in
				guard let self = self else { return }
				Section.allCases.removeAll()
				var snapshoot = NSDiffableDataSourceSnapshot<Section, StoreVM.DataSourceType>()
				sectionedArray.sectionedData.forEach { item in
					snapshoot.appendSections([item.section])
					Section.allCases.append(item.section)
					snapshoot.appendItems(item.items, toSection: item.section)
				}
				
				self.dataSource.apply(snapshoot, animatingDifferences: true)
			}
			.store(in: &cancellables)
	}
	
	private func setupView() {
		title = "Store"
		view.backgroundColor = .white
		dataSource.defaultRowAnimation = .none
		view.addSubview(tableView)
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
		])
	}
	
	@objc private func refreshTapped() {
		refreshPublisher.send(())
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}


class SectionedTableDataSource: UITableViewDiffableDataSource<StoreVC.Section, StoreVM.DataSourceType> {
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		let header = StoreVC.Section.allCases[section]
		switch header {
		case let .product(title):
			return title
		case let .payment(title):
			return title
		case let .gift(title):
			return title
		case .total:
			return ""
		}
	}
}
