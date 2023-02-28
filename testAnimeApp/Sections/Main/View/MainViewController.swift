//
//  MainViewController.swift
//  testAnimeApp
//
//  Created by Wilson David Molina Lozano on 25/02/23.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var firstCV: UICollectionView!
    @IBOutlet private weak var secondCV: UICollectionView!
    @IBOutlet private var loadingView: UIActivityIndicatorView!
    @IBOutlet private var discoverLabel: UILabel!
    @IBOutlet private var sortedLabel: UILabel!
    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    
    
    // MARK: - Properties
    
    var viewModel: MainViewModel
    var router: MainRouter
    
    lazy var adapter = MainAdapter(viewModel: viewModel, firstCV: firstCV)
    
    init(viewModel: MainViewModel, router: MainRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
    
    // MARK: - Methods
    
    private func setupUI() {
        loadingView.hidesWhenStopped = true
        title = "Discover"
        setCollectionsView()
        searchTextField.delegate = self
    }
    
    private func getBestAnimes() {
        viewModel.getBestAnimes()
    }
    
    private func getAnimeDescription() {
        viewModel.getAnimesDescription()
    }
    
    private func setupBindings() {
        viewModel.outputEvents.observe { [weak self] event in
            self?.validateEvents(event: event)
        }
        adapter.didSelectItemAt.observe { [unowned self] anime in
            router.goToDescription(animeDescription: anime)
        }
    }
    
    private func validateEvents(event: HomeViewModelOutput) {
        switch event {
        case .isLoading(let isLoading):
            if isLoading {
                loadingView.startAnimating()
            } else {
                loadingView.stopAnimating()
            }
        case .didGetData:
            reloadCollectionsView()
        case .errorMessage(let error):
            print(error)
            showAlert(title: "Error", message: "Has been ocurred fetching anime list.")
        case .reloadFirstCV:
            firstCV.reloadData()
        case .topError(let showError):
            errorMessageLabel.isHidden = showError
        }
    }
    
    private func setCollectionsView() {
        firstCV.register(.init(nibName: "FirstCVCell", bundle: nil), forCellWithReuseIdentifier: "firstCell")
        secondCV.register(.init(nibName: "SecondCVCell", bundle: nil), forCellWithReuseIdentifier: "secondCell")
        setCollectionViewDelegates()
    }
    
    private func setCollectionViewDelegates() {
        firstCV.delegate = adapter
        firstCV.dataSource = adapter
        secondCV.delegate = adapter
        secondCV.dataSource = adapter
    }
    
    private func reloadCollectionsView() {
        firstCV.reloadData()
        secondCV.reloadData()
       
        showLabels()
    }
    
    private func showLabels() {
        discoverLabel.isHidden = false
        sortedLabel.isHidden = false
    }

}

extension MainViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.textFieldDidChangeSelection(text: textField.text)
    }
    
}
