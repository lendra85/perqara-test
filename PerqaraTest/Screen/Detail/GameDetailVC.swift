//
//  GameDetailVC.swift
//  PerqaraTest
//
//  Created by Sailendra Salsabil on 17/08/23.
//

import UIKit
import CoreData

class GameDetailVC: UIViewController {
    private lazy var topView = UIView().with(parent: view)
    private lazy var favoriteImageView = UIImageView().with(parent: topView)
    private lazy var scrollView = UIScrollView().with(parent: view)
    private lazy var contentStackView = UIStackView().with(parent: scrollView)
    private lazy var detailImageView = UIImageView()
    private lazy var publisherLabel = UILabel()
    private lazy var titleLabel = UILabel()
    private lazy var releaseLabel = UILabel()
    private lazy var ratingLabel = UILabel()
    private lazy var numOfPlayedLabel = UILabel()
    private lazy var descriptionLabel = UILabel()
    
    var id: Int!
    private var viewModel: GameDetailVM!
    
    private lazy var persistentContainer: NSPersistentContainer = {
        NSPersistentContainer(name: "Games")
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopView()
        setupScrollView()
        setupImageView()
        setupPublisherView()
        setupTitleView()
        setupReleaseView()
        setupRatingView()
        setupDescriptionView()
        setupObserver()
        
        persistentContainer.loadPersistentStores { [weak self] persistentStoreDescription, error in
                if let error = error {
                    print("Unable to Add Persistent Store")
                    print("\(error), \(error.localizedDescription)")

                } else {
                    print(persistentStoreDescription.url, persistentStoreDescription.type)
                }
            }
    }
    
    private func setupObserver() {
        viewModel = GameDetailVM()
        viewModel.loadData(id)
        viewModel.detailResponse = { [weak self] detail in
            self?.bindDataToView(detail)
        }
    }
    
    private func setupTopView() {
        topView.backgroundColor = .systemIndigo
        topView.makeConstraint {
            $0.topAnchor == view.topAnchor
            $0.leadingAnchor == view.leadingAnchor
            $0.trailingAnchor == view.trailingAnchor
        }
        let backImageView = UIImageView(image: UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)).with(parent: topView)
        backImageView.tintColor = .white
        backImageView.contentMode = .center
        backImageView.addTapGesture(target: self, action: #selector(onBackClicked))
        backImageView.setWidth(48, andHeight: 48)
        backImageView.makeConstraint {
            $0.topAnchor == view.safeAreaLayoutGuide.topAnchor
            $0.leadingAnchor == topView.leadingAnchor
            $0.bottomAnchor == topView.bottomAnchor
        }
        let detailLabel = UILabel().with(parent: topView)
        detailLabel.text = "Detail"
        detailLabel.textColor = .white
        detailLabel.font = .boldSystemFont(ofSize: 16)
        detailLabel.makeConstraint {
            $0.centerYAnchor == backImageView.centerYAnchor
            $0.centerXAnchor == topView.centerXAnchor
        }
        favoriteImageView.addTapGesture(target: self, action: #selector(onFavoriteClicked))
        favoriteImageView.image = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        favoriteImageView.tintColor = .white
        favoriteImageView.makeConstraint {
            $0.trailingAnchor == topView.trailingAnchor - .x16
            $0.centerYAnchor == backImageView.centerYAnchor
        }
    }
    
    private func setupScrollView() {
        scrollView.makeConstraint {
            $0.topAnchor == topView.bottomAnchor
            $0.leadingAnchor == view.leadingAnchor
            $0.trailingAnchor == view.trailingAnchor
            $0.bottomAnchor == view.bottomAnchor
        }
        contentStackView.makeConstraint {
            $0.topAnchor == scrollView.topAnchor
            $0.leadingAnchor == scrollView.leadingAnchor
            $0.trailingAnchor == scrollView.trailingAnchor
            $0.bottomAnchor == scrollView.bottomAnchor
        }
        contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0).isActive = true
        contentStackView.distribution = .fill
        contentStackView.alignment = .fill
        contentStackView.axis = .vertical
        contentStackView.spacing = 0
    }
    
    private func setupImageView() {
        detailImageView.contentMode = .scaleAspectFill
        detailImageView.setHeight(by: 300)
        contentStackView.addArrangedSubview(detailImageView)
    }
    
    private func setupPublisherView() {
        let publisherView = UIView()
        publisherLabel.with(parent: publisherView)
        publisherLabel.textColor = .gray
        publisherLabel.font = .systemFont(ofSize: 14)
        publisherLabel.makeConstraint {
            $0.topAnchor == publisherView.topAnchor + .x16
            $0.leadingAnchor == publisherView.leadingAnchor + .x16
            $0.trailingAnchor == publisherView.trailingAnchor - .x16
            $0.bottomAnchor == publisherView.bottomAnchor - .x8
        }
        contentStackView.addArrangedSubview(publisherView)
    }
    
    private func setupTitleView() {
        let titleView = UIView()
        titleLabel.with(parent: titleView)
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.numberOfLines = 0
        titleLabel.makeConstraint {
            $0.topAnchor == titleView.topAnchor + .x2
            $0.leadingAnchor == titleView.leadingAnchor + .x16
            $0.trailingAnchor == titleView.trailingAnchor - .x16
            $0.bottomAnchor == titleView.bottomAnchor - .x2
        }
        contentStackView.addArrangedSubview(titleView)
    }
    
    private func setupReleaseView() {
        let releaseView = UIView()
        releaseLabel.with(parent: releaseView)
        releaseLabel.textColor = .gray
        releaseLabel.font = .systemFont(ofSize: 14)
        releaseLabel.makeConstraint {
            $0.topAnchor == releaseView.topAnchor + .x2
            $0.bottomAnchor == releaseView.bottomAnchor - .x2
            $0.leadingAnchor == releaseView.leadingAnchor + .x16
            $0.trailingAnchor == releaseView.trailingAnchor - .x16
        }
        contentStackView.addArrangedSubview(releaseView)
    }
    
    private func setupRatingView() {
        let ratingView = UIView()
        let ratingImageView = UIImageView(image: UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysTemplate)).with(parent: ratingView)
        ratingImageView.tintColor = .systemYellow
        ratingImageView.makeConstraint {
            $0.topAnchor == ratingView.topAnchor + .x4
            $0.bottomAnchor == ratingView.bottomAnchor - .x4
            $0.leadingAnchor == ratingView.leadingAnchor + .x16
        }
        ratingLabel.with(parent: ratingView)
        ratingLabel.textColor = .gray
        ratingLabel.font = .systemFont(ofSize: 14)
        ratingLabel.makeConstraint {
            $0.centerYAnchor == ratingView.centerYAnchor
            $0.leadingAnchor == ratingImageView.trailingAnchor + .x4
        }
        let gameImageView = UIImageView(image: UIImage(systemName: "gamecontroller")?.withRenderingMode(.alwaysTemplate)).with(parent: ratingView)
        gameImageView.tintColor = .gray
        gameImageView.makeConstraint {
            $0.centerYAnchor == ratingView.centerYAnchor
            $0.leadingAnchor == ratingLabel.trailingAnchor + .x16
        }
        numOfPlayedLabel.with(parent: ratingView)
        numOfPlayedLabel.textColor = .gray
        numOfPlayedLabel.font = .systemFont(ofSize: 14)
        numOfPlayedLabel.makeConstraint {
            $0.centerYAnchor == ratingView.centerYAnchor
            $0.leadingAnchor == gameImageView.trailingAnchor + .x4
        }
        contentStackView.addArrangedSubview(ratingView)
    }
    
    private func setupDescriptionView() {
        let descriptionView = UIView()
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.with(parent: descriptionView)
        descriptionLabel.makeConstraint {
            $0.topAnchor == descriptionView.topAnchor + .x12
            $0.leadingAnchor == descriptionView.leadingAnchor + .x16
            $0.trailingAnchor == descriptionView.trailingAnchor - .x16
            $0.bottomAnchor == descriptionView.bottomAnchor - .x64
        }
        contentStackView.addArrangedSubview(descriptionView)
    }
    
    private func bindDataToView(_ detail: GameDetail) {
        detailImageView.load(detail.backgroundImage)
        publisherLabel.text = detail.publishers?.first?.name
        titleLabel.text = detail.name
        descriptionLabel.text = detail.description
        ratingLabel.text = "\(detail.rating.ifNil(0))"
        numOfPlayedLabel.text = "\(detail.playtime.ifNil(0)) played"
        releaseLabel.text = "Release date \(detail.released.ifNil(""))"
    }
    
    @objc private func onBackClicked() {
        navigationController?.popViewController()
    }
    
    @objc private func onFavoriteClicked() {
        guard let data = viewModel?.game, let id = data.id else {
            return
        }
        
        printIfDebug("on favorite Clicked")
        let fetchRequest: NSFetchRequest<GameModel> = GameModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "gameId == %@", "\(id)")
        persistentContainer.viewContext.perform {
            do {
                // Execute Fetch Request
                let result = try fetchRequest.execute()
                
                // Update Books Label
                printIfDebug("\(result.count) Games")
                if result.isEmpty {
                    let managedObjectContext = self.persistentContainer.viewContext
                    let game = GameModel(context: managedObjectContext)
                    game.gameId = Int64(data.id.ifNil(0))
                    game.rating = "\(data.rating.ifNil(0))"
                    game.imageUrl = data.backgroundImage
                    game.name = data.name
                    game.releaseDate = data.released
                    do {
                        try managedObjectContext.save()
                    } catch {
                        printIfDebug("Unable to Save Game, \(error)")
                    }
                }
                
            } catch {
                print("Unable to Execute Fetch Request, \(error)")
            }
        }
        
    }
}

