//
//  DetailsViewController.swift
//  Asteroid
//
//  Created by Nitin Bhatia on 09/02/23.
//

import UIKit
import SwiftUI
import Alamofire

class DetailsViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var lblAverage: UILabel!
    @IBOutlet weak var lblClosest: UILabel!
    @IBOutlet weak var lblFastest: UILabel!
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet var chartContainerView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //variables
    private var model : ChartData!
    var startDate : String!
    var endDate : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: this function helps to setup view with all data
    private func setupView() -> Task<(), Never> {
        return Task {
            guard let data = await getData(), let _ = data.elementCount else {
                let _ = self.showAlert(title: "No Data", message: "No data found for given date range", btnTitle: "Ok", completion: {_ in})
                return
            }
            
            var chartData: [AestroidData] = [AestroidData]()
            
            data.nearEarthObjects?.keys.forEach({
                let tempChartData = AestroidData(type: $0, count: Double(data.nearEarthObjects?[$0]?.count ?? 0))
                chartData.append(tempChartData)
            })
            
            model = ChartData(chartData: chartData)
            addChartView()
            getFastestAestroidsData(data)
        }
    }
    
    //MARK: this function helps to create and add chart view
    func addChartView() {
        let chartView = ChartView(model: model)
        let controller = UIHostingController(rootView: chartView)
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        chartContainerView.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalTo: chartContainerView.widthAnchor,multiplier: 1),
            controller.view.heightAnchor.constraint(equalTo: chartContainerView.heightAnchor, multiplier: 1),
            controller.view.leadingAnchor.constraint(equalTo: chartContainerView.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: chartContainerView.trailingAnchor)
        ])
    }
    
    
    //MARK: this method helps to fetch data from api
    private func getData() async -> AestroidModel? {
        await withCheckedContinuation({continuation in
            let endPoint = "https://api.nasa.gov/neo/rest/v1/feed"
            
            let params = [
                "start_date" : startDate!,
                "end_date" : endDate!,
                "api_key" : "DEMO_KEY"
            ]
            
            
            AF.request(endPoint, method: .get, parameters: params, encoding: URLEncoding(destination: .queryString), headers: nil).response{ AFData in
                self.activityIndicator.stopAnimating()
                let aestroidObj = try? JSONDecoder().decode(AestroidModel.self, from: AFData.data!)
                continuation.resume(returning: aestroidObj)
            }
        })
        
    }
    
    
    //MARK: this function helps to calculate the data
    private func getFastestAestroidsData(_ aestroidData : AestroidModel) {
        var datas = [ObjectDateData]()
        
        let _ = aestroidData.nearEarthObjects?.keys.map({
            if let x = aestroidData.nearEarthObjects?[$0] {
                datas.append(contentsOf: x)
            }
            
        })
        
        //fastest calculation
        let _ = datas.sorted(by: {
            ($0.closeApproachData?.first?.relativeVelocity?.kilometersPerHour)! > ($1.closeApproachData?.first?.relativeVelocity?.kilometersPerHour)!
        })
        lblFastest.text = "Fastest Aestoroid's id is \(datas.first?.id ?? "") with speed of \(datas.first?.closeApproachData?.first?.relativeVelocity?.kilometersPerHour ?? "") km"
        
        //closest calculation
        let _ = datas.sorted(by: {
            ($0.closeApproachData?.first?.missDistance?.kilometers)! < ($1.closeApproachData?.first?.missDistance?.kilometers)!
        })
        lblClosest.text = "Closest Aestroid's id is \(datas.first?.id ?? "") with distance \(datas.first?.closeApproachData?.first?.missDistance?.kilometers ?? "") km"
        
        //average calculation
        var total = 0.0
        
        let _ = datas.map({
            total += ($0.estimatedDiameter?.kilometers?.estimatedDiameterMax)!
        })
        lblAverage.text = "Average Size of Aestroid is \(total / Double(datas.count))"
        
        infoStackView.isHidden = false
    }
    
    
    
}

