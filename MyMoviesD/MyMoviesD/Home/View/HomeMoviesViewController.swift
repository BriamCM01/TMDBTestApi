//
//  HomeMoviesViewController.swift
//  MyMoviesD
//
//  Created by Briam Cano on 02/08/24.
//

import UIKit
import SkeletonView

class HomeMoviesViewController: UIViewController {
    
    @IBOutlet weak var lblTitleView: UILabel!
    @IBOutlet weak var collectionViewUpcomingMovies: UICollectionView!
    @IBOutlet weak var tableViewTopRateMovies: UITableView!
    @IBOutlet weak var imgUserName: UIImageView!
    @IBOutlet weak var lblUpcoming: UILabel!
    @IBOutlet weak var lblTopRate: UILabel!
    
    internal var viewModel: HomeMovieViewModel!
    internal var arrayDataUpcoming = [UpcomingEntity]()
    internal var arrayDataTopRate = [UpcomingEntity]()
    internal var layout = CustomLayoutCollection()
    var numPage = 0
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        navigationController?.navigationBar.isHidden = true
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            if counter == 0 {
                counter += 1
                let alert = GenericCustomAlertViewController(nibName: "GenericCustomAlertViewController", bundle: .main)
                alert.setupViewModel(CustomGenericAlertViewModel(title: "¡Bienvenido!", img: "play.house.fill", overview: "Espero disfrutes mucho esta app, es algo sencillo y se que se puede mejorar. No soy el mejor en diseño pero espero no lastime tus ojos. Saludos."))
                self.present(alert, animated: true)
            }
        }
        
        Task {
            
            imgUserName.image = UIImage(systemName: "person.fill")
            imgUserName.tintColor = .appColor900
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(seePerfil(tapGestureRecognizer:)))
            imgUserName.isUserInteractionEnabled = true
            imgUserName.addGestureRecognizer(tapGestureRecognizer)
            
            try await viewModel.getAuth()
            arrayDataUpcoming = try await viewModel.getUpcomingMovies()
            try await loadPage()
            collectionViewUpcomingMovies.delegate = self
            collectionViewUpcomingMovies.dataSource = self
            collectionViewUpcomingMovies.showsHorizontalScrollIndicator = false
            collectionViewUpcomingMovies.showsVerticalScrollIndicator = false
            collectionViewUpcomingMovies.collectionViewLayout = layout
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 25
            layout.minimumInteritemSpacing = 25
            layout.itemSize.width = 145
            collectionViewUpcomingMovies.backgroundColor = .clear
            collectionViewUpcomingMovies.decelerationRate = .fast
            tableViewTopRateMovies.dataSource = self
            tableViewTopRateMovies.delegate = self
            tableViewTopRateMovies.backgroundColor = .appColor700
            //MARK: Register cells
            let nibName = UINib(nibName: "UpcomingCollectionCell", bundle: .main)
            collectionViewUpcomingMovies.register(nibName, forCellWithReuseIdentifier: "collectionCell")
            let nib = UINib(nibName: "TopRateTableViewCell", bundle: .main)
            tableViewTopRateMovies.register(nib, forCellReuseIdentifier: "tableCell")
            tableViewTopRateMovies.stopSkeletonAnimation()
            self.view.hideSkeleton()
            
            let indexPath = IndexPath(item: 1, section: 0)
            collectionViewUpcomingMovies.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            layout.currentpage = indexPath.item
            layout.previousOffset = layout.updateOffset(collectionViewUpcomingMovies)
            if let cell = collectionViewUpcomingMovies.cellForItem(at: indexPath) {
                tranformCell(cell)
            }
        }
    }
    
    func loadPage() async throws {
        numPage += 1
        arrayDataTopRate = try await viewModel.getTopRatedData(page: String(numPage))
        tableViewTopRateMovies.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        tableViewTopRateMovies.isSkeletonable = true
//        tableViewTopRateMovies.showSkeleton(usingColor: .appColor600, transition: .crossDissolve(0.25))
        Task {
            try await loadPage()
        }
    }
    
    func setupViewModel(viewModel: HomeMovieViewModel) {
        self.viewModel = viewModel
    }
    
    @objc func seePerfil(tapGestureRecognizer: UITapGestureRecognizer) {
        let perfil = PerfilViewController(nibName: "PerfilViewController", bundle: .main)
        self.navigationController?.present(perfil, animated: true)
    }
    
    func convertBase64ToImage(imageString: String) -> UIImage {
//        DispatchQueue.main.async {
            let imageData = Data(base64Encoded: imageString,
                                 options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
            return UIImage(data: imageData)!
//        }
    }
}

extension HomeMoviesViewController: UITableViewDelegate, SkeletonTableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayDataTopRate.count
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        "tableCell"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TopRateTableViewCell else { return UITableViewCell() }
        
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.row == lastRowIndex {
            Task {
                try await loadPage()
            }
        }
        
        cell.setupTableCell(poster: URLBases().imageUrlBase + arrayDataTopRate[indexPath.row].moviewImage, title: arrayDataTopRate[indexPath.row].movieName, overview: arrayDataTopRate[indexPath.row].movieDescription, date: arrayDataTopRate[indexPath.row].date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reusableView = ReusableDetailViewController(nibName: "ReusableDetailViewController", bundle: .main)
        reusableView.setupViewModel(MovieDetailViewModel(detailMovie: MovieDetailEntity(poster: URLBases().imageUrlBase + arrayDataTopRate[indexPath.row].moviewImage, title: arrayDataTopRate[indexPath.row].movieName, description: arrayDataTopRate[indexPath.row].movieDescription, date: arrayDataTopRate[indexPath.row].date)))
        reusableView.modalTransitionStyle = .flipHorizontal
        reusableView.modalPresentationStyle = .formSheet
//            self.present(reusableView, animated: true)
        self.navigationController?.present(reusableView, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(130)
    }
    
}

extension HomeMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.arrayUpcomingData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? UpcomingCollectionCell else { return UICollectionViewCell() }
        cell.setupCollectionCell(movieImg: URLBases().imageUrlBase + viewModel.arrayUpcomingData[indexPath.row].moviewImage, title: viewModel.arrayUpcomingData[indexPath.row].movieName)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == layout.currentpage {
            let reusableView = ReusableDetailViewController(nibName: "ReusableDetailViewController", bundle: .main)
            reusableView.setupViewModel(MovieDetailViewModel(detailMovie: MovieDetailEntity(poster: URLBases().imageUrlBase + viewModel.arrayUpcomingData[indexPath.row].moviewImage, title: viewModel.arrayUpcomingData[indexPath.row].movieName, description: viewModel.arrayUpcomingData[indexPath.row].movieDescription, date: viewModel.arrayUpcomingData[indexPath.row].date)))
            reusableView.modalTransitionStyle = .flipHorizontal
            reusableView.modalPresentationStyle = .formSheet
            self.navigationController?.present(reusableView, animated: true)
        } else {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            layout.currentpage = indexPath.item
            layout.previousOffset = layout.updateOffset(collectionView)
            setupScrollCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 145, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate {
            setupScrollCell()
        }
    }
    
    private func setupScrollCell() {
        let indexPath = IndexPath(item: layout.currentpage, section: 0)
        guard let cell = collectionViewUpcomingMovies.cellForItem(at: indexPath) else { return }
        tranformCell(cell)
    }
    
    private func tranformCell(_ cell: UICollectionViewCell, isEffect: Bool = true) {
        
        if !isEffect {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            return
        }
        UIView.animate(withDuration: 0.2) {
            cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        
        for notfocusedCell in collectionViewUpcomingMovies.visibleCells {
            if let indexPath = collectionViewUpcomingMovies.indexPath(for: notfocusedCell) {
                if indexPath.item != layout.currentpage {
                    UIView.animate(withDuration: 0.2) {
                        notfocusedCell.transform = .identity
                    }
                }
            }
        }
    }

}
