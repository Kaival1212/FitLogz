import SwiftUI
import VisionKit
import AVFoundation

struct BarcodeScannerView: View {
    @Binding var scannedCode: String
    @Binding var isPresented: Bool
    @State private var tempScannedCode: String = ""
    @State var error: String? = nil
    @State var isScannedCodeSelected: Bool = false
    @State var scannedFood:ProductNutriments? = nil
    
    var body: some View {
            ZStack {
                Color.backGround
                    .ignoresSafeArea()
                
                if !isScannedCodeSelected {
                    VStack {
                        BarcodeScanner(tempScannedCode: $tempScannedCode, isPresented: $isPresented, scannedCode: $scannedCode)
                            .edgesIgnoringSafeArea(.all)
                        
                        VStack(spacing: 15) {
                            Text("Scanned Barcode: \(tempScannedCode.isEmpty ? "None" : tempScannedCode)")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top, 20)
                            
                            Button(action: saveScannedCode) {
                                Text("Select Barcode")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(width: 200, height: 50)
                                    .background(Color.blue)
                                    .cornerRadius(25)
                                    .shadow(radius: 4)
                                    .opacity(tempScannedCode.isEmpty ? 0.5 : 1)
                            }
                            .padding(.bottom, 20)
                            .disabled(tempScannedCode.isEmpty)

                        }
                        .cornerRadius(12)
                        .padding()
                    }
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 0.3), value: isScannedCodeSelected)
                } else {
                    VStack {
                        if let food = scannedFood {
                            NutrimentsView(product: food)
                        } else if let error = error {
                            ProductNotFoundError(scannedCode: scannedCode, error: error)
                        }
                    }
                    .transition(.slide)
                    .animation(.easeInOut(duration: 0.3), value: isScannedCodeSelected)
                }
            }
        }
    
    private func saveScannedCode()  {
        scannedCode = tempScannedCode
        isScannedCodeSelected = true
        FoodNutriments.getData(id: scannedCode){ product in
            switch product {
                case .success(let food):
                    self.scannedFood = food
                case .failure(let error):
                    self.error = error.error
            }
        }
    }
}

struct BarcodeScanner: UIViewControllerRepresentable {
    @Binding var tempScannedCode: String
    @Binding var isPresented: Bool
    @Binding var scannedCode: String
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let viewController = DataScannerViewController(
            recognizedDataTypes: [.barcode()],
            qualityLevel: .accurate,
            recognizesMultipleItems: false,
            isPinchToZoomEnabled: true,
            isHighlightingEnabled: true
        )
        viewController.delegate = context.coordinator
        try? viewController.startScanning()
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        let parent: BarcodeScanner
        
        init(parent: BarcodeScanner) {
            self.parent = parent
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            if let item = addedItems.first, case let .barcode(barcode) = item, let payload = barcode.payloadStringValue {
                DispatchQueue.main.async {
                    self.parent.tempScannedCode = payload
                }
            }
        }
    }
}

#Preview {
    BarcodeScannerView(
        scannedCode: .constant(""), isPresented: .constant(true)
    )
}
