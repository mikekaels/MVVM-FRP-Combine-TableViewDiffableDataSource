//
//  TotalCell.swift
//  MultipleSectionsWithCombine
//
//  Created by Santo Michael on 15/08/23.
//

import UIKit

internal final class TotalCell: UITableViewCell {
	static let identifier: String = "TotalCell"
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		setupView()
	}
	
	private let totalLabel: UILabel = {
		let label = UILabel()
		label.text = "Total: "
		label.font = .systemFont(ofSize: 14, weight: .regular)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private let priceLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14, weight: .regular)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private func setupView() {
		contentView.addSubview(totalLabel)
		contentView.addSubview(priceLabel)
		
		NSLayoutConstraint.activate([
			totalLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			totalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			totalLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
			
			priceLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			priceLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
		])
	}
	
	internal func set(total: Int) {
		priceLabel.text = "$\(total)"
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
