//
//  ProductCell.swift
//  MultipleSectionsWithCombine
//
//  Created by Santo Michael on 10/08/23.
//

import UIKit
import SDWebImage
import CombineCocoa
import Combine

internal final class ProductCell: UITableViewCell {
	
	internal enum EventType {
		case decrease
		case increase
	}
	
	static let identifier: String = "ProductCell"
	internal var cancellables = Set<AnyCancellable>()
	internal var eventPublisher = PassthroughSubject<EventType, Never>()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		setupView()
		bindView()
	}
	
	private let productImage: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private let titleLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14, weight: .regular)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let priceLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12, weight: .semibold)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let buttonStackView: UIStackView = {
		let stack = UIStackView()
		stack.axis = .horizontal
		stack.spacing = 5
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	private let decreaseButton: UIButton = {
		let button = UIButton()
		button.setTitle("-", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	private let itemTotalLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12, weight: .regular)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let increaseButton: UIButton = {
		let button = UIButton()
		button.setTitle("+", for: .normal)
		button.setTitleColor(.systemBlue, for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	private func bindView() {
		decreaseButton.tapPublisher
			.sink { [weak self] _ in
				self?.eventPublisher.send(.decrease)
			}
			.store(in: &cancellables)
		
		increaseButton.tapPublisher
			.sink { [weak self] _ in
				self?.eventPublisher.send(.increase)
			}
			.store(in: &cancellables)
	}
	
	private func setupView() {
		contentView.addSubview(titleLabel)
		contentView.addSubview(productImage)
		contentView.addSubview(priceLabel)
		contentView.addSubview(buttonStackView)
		[decreaseButton, itemTotalLabel, increaseButton].forEach { buttonStackView.addArrangedSubview($0) }
		
		NSLayoutConstraint.activate([
			productImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			productImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			productImage.heightAnchor.constraint(equalToConstant: 60),
			productImage.widthAnchor.constraint(equalToConstant: 60),
			productImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
			
			titleLabel.centerYAnchor.constraint(equalTo: productImage.centerYAnchor, constant: -10),
			titleLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 20),
			
			priceLabel.centerYAnchor.constraint(equalTo: productImage.centerYAnchor, constant: 10),
			priceLabel.leftAnchor.constraint(equalTo: productImage.rightAnchor, constant: 20),
			
			buttonStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
			buttonStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			
			decreaseButton.widthAnchor.constraint(equalToConstant: 50),
			decreaseButton.heightAnchor.constraint(equalToConstant: 50),
		])
	}
	
	internal func set(imageURL: String) {
		productImage.sd_setImage(with: URL(string: imageURL))
	}
	
	internal func set(title: String) {
		titleLabel.text = title
	}
	
	internal func set(price: Int) {
		priceLabel.text = "$\(price)"
	}
	
	internal func set(itemTotal: Int) {
		itemTotalLabel.text = "\(itemTotal)"
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		eventPublisher = PassthroughSubject<EventType, Never>()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
