//
//  MainViewController.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var firstCV: UICollectionView!
    @IBOutlet private weak var secondCV: UICollectionView!
    @IBOutlet private var loadingView: UIActivityIndicatorView!
    @IBOutlet private var discoverLabel: UILabel!
    @IBOutlet private var sortedLabel: UILabel!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    
    
    // MARK: - Properties
    
    var viewModel: MainViewModel?
    var router: MainRouter?
    
    var bestAnimes: [AnimeDescription] = []
    var animesDescription: [AnimeDescription] = []
    
    // MARK: - Observable Properties
    
    var outputEvents: Observable<HomeViewModelOutput> {
        mutableOutputEvents
    }
    
    private let mutableOutputEvents = MutableObservable<HomeViewModelOutput>()

    // MARK: - Controller Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getBestAnimes()
        getAnimeDescription()
        setupBindings()

    }
    
    // MARK: - Override Methods
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches,
                           with: event)
        self.view.endEditing(true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        Timer.scheduledTimer(withTimeInterval: 0.8, repeats: false) { _ in
            guard let text = textField.text else { return }
            
            if text == "" {
                self.bestAnimes = self.viewModel!.bestAnimes
                self.firstCV.reloadData()
                return
            }
            
            self.bestAnimes = self.viewModel!.bestAnimes
            
            var filteredAnime: [AnimeDescription] = []
            for i in self.bestAnimes {
                if i.title!.lowercased().contains(text.lowercased()) {
                    filteredAnime.append(i)
                }
            }
            
            self.bestAnimes = filteredAnime
            self.firstCV.reloadData()
            
            self.errorMessageLabel.isHidden = filteredAnime.isEmpty ? false : true
        }
    }
    
    // MARK: - Methods
    
    private func setupUI() {
        loadingView.hidesWhenStopped = true
        title = "Discover"
        setCollectionsView()
        searchTextField.delegate = self
    }
    
    private func getBestAnimes() {
        loadingView.startAnimating()
        viewModel?.getBestAnimes()
    }
    
    private func getAnimeDescription() {
        loadingView.startAnimating()
        viewModel?.getAnimesDescription()
    }
    
    private func setupBindings() {
        viewModel?.outputEvents.observe { [weak self] event in
            self?.validateEvents(event: event)
        }
    }
    
    private func validateEvents(event: HomeViewModelOutput) {
        switch event {
        case .isLoading(let isLoading):
            if isLoading {
                print("Loading spinner...")
            } else {
                print("Remove spinner...")
            }
        case .didGetData:
            bestAnimes = viewModel!.bestAnimes
            reloadCollectionsView()
        case .errorMessage(let error):
            print(error)
        }
    }
    
    private func setCollectionsView() {
        firstCV.register(.init(nibName: "FirstCVCell", bundle: nil), forCellWithReuseIdentifier: "firstCell")
        secondCV.register(.init(nibName: "SecondCVCell", bundle: nil), forCellWithReuseIdentifier: "secondCell")
        setCollectionViewDelegates()
    }
    
    private func setCollectionViewDelegates() {
        firstCV.delegate = self
        firstCV.dataSource = self
        secondCV.delegate = self
        secondCV.dataSource = self
    }
    
    private func reloadCollectionsView() {
        let scoredAnimes = viewModel!.animesDescription.sorted(by: { $0.score! > $1.score! })
        bestAnimes = viewModel!.bestAnimes
        animesDescription = scoredAnimes
        firstCV.reloadData()
        secondCV.reloadData()
        loadingView.stopAnimating()
        showLabels()
    }
    
    private func showLabels() {
        discoverLabel.isHidden = false
        sortedLabel.isHidden = false
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        CGFloat(collectionView == firstCV ? bestAnimes.count : animesDescription.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView == firstCV ? CGSize(width: UIScreen.main.bounds.width / 3, height: view.bounds.height / 4) : CGSize(width: UIScreen.main.bounds.width, height: view.bounds.height / 4) 
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == firstCV {
            router?.goToDescription(animeDescription: bestAnimes[indexPath.row])
        } else if collectionView == secondCV {
            router?.goToDescription(animeDescription: animesDescription[indexPath.row])
        }
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView == firstCV ? bestAnimes.count : animesDescription.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCV {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "firstCell", for: indexPath) as? FirstCVCell {
                cell.bestAnime = bestAnimes[indexPath.row]
                return cell
            } else {
                return UICollectionViewCell()
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCell", for: indexPath) as? SecondCVCell {
                cell.animeDescription = animesDescription[indexPath.row]
                return cell
            } else {
                return UICollectionViewCell()
            }
        }
    }
    
}
