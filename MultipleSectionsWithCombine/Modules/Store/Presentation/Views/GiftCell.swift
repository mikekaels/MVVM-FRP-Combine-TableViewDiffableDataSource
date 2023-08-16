//
//  GiftCell.swift
//  MultipleSectionsWithCombine
//
//  Created by Santo Michael on 10/08/23.
//

import UIKit

internal final class GiftCell: UITableViewCell {
	static let identifier: String = "GiftCell"
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		selectionStyle = .none
		setupView()
	}
	
	private let giftImage: UIImageView = {
		let view = UIImageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()
	
	private let giftLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 11, weight: .regular)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	private func setupView() {
		contentView.addSubview(giftLabel)
		contentView.addSubview(giftImage)
		
		NSLayoutConstraint.activate([
			giftImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
			giftImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
			giftImage.heightAnchor.constraint(equalToConstant: 40),
			giftImage.widthAnchor.constraint(equalToConstant: 40),
			giftImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
			
			giftLabel.centerYAnchor.constraint(equalTo: giftImage.centerYAnchor),
			giftLabel.leftAnchor.constraint(equalTo: giftImage.rightAnchor, constant: 20),
		])
	}
	
	internal func set(imageURL: String) {
		giftImage.sd_setImage(with: URL(string: imageURL))
	}
	
	internal func set(giftTitle: String) {
		giftLabel.text = giftTitle
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
