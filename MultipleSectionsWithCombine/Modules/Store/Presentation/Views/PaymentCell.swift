//
//  PaymentCell.swift
//  MultipleSectionsWithCombine
//
//  Created by Santo Michael on 10/08/23.
//

import UIKit

internal final class PaymentCell: UITableViewCell {
	static let identifier: String = "PaymentCell"
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		setupView()
	}
	
	private let paymentImage: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private let paymentLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 11, weight: .regular)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private func setupView() {
		contentView.addSubview(paymentLabel)
		contentView.addSubview(paymentImage)
		
		NSLayoutConstraint.activate([
			paymentImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			paymentImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			paymentImage.heightAnchor.constraint(equalToConstant: 20),
			paymentImage.widthAnchor.constraint(equalToConstant: 20),
			paymentImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
			
			paymentLabel.centerYAnchor.constraint(equalTo: paymentImage.centerYAnchor),
			paymentLabel.leftAnchor.constraint(equalTo: paymentImage.rightAnchor, constant: 20),
		])
	}
	
	internal func set(imageURL: String) {
		paymentImage.sd_setImage(with: URL(string: imageURL))
	}
	
	internal func set(paymentTitle: String) {
		paymentLabel.text = paymentTitle
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
