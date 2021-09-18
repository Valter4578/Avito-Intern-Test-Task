//
//  EmployeeTableViewCell.swift
//  AvitoTestTask
//
//  Created by Максим Алексеев  on 14.09.2021.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    // MARK:- Views
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var skillsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, skillsLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .light)
        return label
    }()
    
    // MARK:- Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Configures
    func configureNameLabel(with text: String) {
        nameLabel.text = text
    }
    
    func configureSkillsLabel(with text: String) {
        skillsLabel.text = text
    }
    
    func configurePhoneNumberLabel(with text: String) {
        phoneNumberLabel.text = text
    }
    
    // MARK:- Setups
    private func commonInit() {
        setupStackView()
        setupPhoneNumberLabel()
    }
    
    private func setupStackView() {
        addSubview(labelStackView)
        NSLayoutConstraint.activate([
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            labelStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    private func setupPhoneNumberLabel() {
        addSubview(phoneNumberLabel)
        NSLayoutConstraint.activate([
            phoneNumberLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 15),
            phoneNumberLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
        ])
    }
}
