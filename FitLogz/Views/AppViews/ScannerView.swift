import SwiftUI
import VisionKit

struct ScannerView: View {
    @State private var isPresentingScanner = false
    @State var scannedCode: String = ""
    private var openfoodfactsApi : OpenFoodFactsApi = OpenFoodFactsApi()
    @State var scannedFood: Product? = nil
    
    var body: some View {
        ZStack() {
            Color.backGround
                .ignoresSafeArea(.all)
            ScrollView {
                HeaderView()
                
                VStack {
                    Button(action: {
                        isPresentingScanner = true
                    }) {
                        HStack {
                            Image(systemName: "barcode.viewfinder")
                                .resizable()
                                .foregroundStyle(Color.defPrimary)
                                .frame(width: 30, height: 30)
                                .padding(.vertical)
                            Text("Scan")
                                .foregroundStyle(Color.defPrimary)
                                .font(.headline)
                                .padding(.vertical)
                        }
                        .padding(.horizontal,80)
                        .background(Color.defSecondary)
                        .cornerRadius(30)


                    }
                    .sheet(isPresented: $isPresentingScanner){
                        DocumentScannerView(scannedCode: $scannedCode, isPresented: $isPresentingScanner)
                    }
                    
                    if !scannedCode.isEmpty && (scannedFood != nil) {
                        NutrimentsView(product: scannedFood!)
                    }
                }
            }
        }.onChange(of: scannedCode){
            Task {
                do {
                    scannedFood = try await openfoodfactsApi.getProductDetails(productId: scannedCode)
                    print(scannedFood ?? "No product found")
                } catch {
                    print("Error fetching product details: \(error)")
                }
            }
        }
    }
}

struct DocumentScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode: String
    @Binding var isPresented: Bool
    @State var showScanButton: Bool = false
    var tempScannedCode: String = ""
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        if let button = uiViewController.view.subviews.first(where: { $0 is UIButton }) as? UIButton {
            button.isEnabled = showScanButton
            button.alpha = showScanButton ? 1.0 : 0.5
        }
    }
    
    var scannerViewController: DataScannerViewController = DataScannerViewController(
        recognizedDataTypes: [.barcode()],
        qualityLevel: .accurate,
        recognizesMultipleItems: false,
        isHighFrameRateTrackingEnabled: false,
        isHighlightingEnabled: true
    )
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        scannerViewController.delegate = context.coordinator
        try? scannerViewController.startScanning()
        
        let scanButton = UIButton(type: .system)
        scanButton.backgroundColor = UIColor(named: "defPrimary")
        scanButton.setTitle("Select Barcode", for: .normal)
        scanButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        scanButton.setTitleColor(.white, for: .normal)
        scanButton.setTitleColor(.gray, for: .disabled)
        scanButton.layer.cornerRadius = 25
        scanButton.isEnabled = showScanButton
        scanButton.alpha = 0.5
        scanButton.addTarget(context.coordinator, action: #selector(Coordinator.save), for: .touchUpInside)
        
        // Add shadow
        scanButton.layer.shadowColor = UIColor.black.cgColor
        scanButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        scanButton.layer.shadowRadius = 4
        scanButton.layer.shadowOpacity = 0.2
        
        scannerViewController.view.addSubview(scanButton)
        
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scanButton.centerXAnchor.constraint(equalTo: scannerViewController.view.centerXAnchor),
            scanButton.bottomAnchor.constraint(equalTo: scannerViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            scanButton.widthAnchor.constraint(equalToConstant: 200),
            scanButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return scannerViewController
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        var parent: DocumentScannerView
        
        init(_ parent: DocumentScannerView) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            for item in addedItems {
                if case let .barcode(barcode) = item, let payload = barcode.payloadStringValue {
                    self.parent.showScanButton = true
                    self.parent.tempScannedCode = payload
                }
            }
        }
        
        @objc func save() {
            self.parent.scannerViewController.stopScanning()
            self.parent.isPresented = false
            self.parent.scannedCode = self.parent.tempScannedCode
        }
    }
}

#Preview {
    ScannerView()
}
