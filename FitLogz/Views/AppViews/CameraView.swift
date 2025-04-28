import Foundation
import AVFoundation
import SwiftUI
import CreateMLComponents
import Vision

struct CameraView: View {
    @State private var counts: Float = 0.0

    var body: some View {
        ZStack {
            CameraCounter(counts: $counts)
                .edgesIgnoringSafeArea(.all)

            VStack {


                Spacer()

                Text("Count your jumping jacks!")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                    .padding(.bottom, 20)

                Text("\(Int(counts))")
                    .font(.system(size: 72, weight: .heavy))
                    .foregroundColor(.yellow)
                    .padding(20)
                    .background(Color.black.opacity(0.7))
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.bottom, 20)


                Spacer()
            }
        }
    }
}

struct CameraCounter: UIViewRepresentable {
    @Binding var counts: Float

    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.startSession(updating: $counts)
        return view
    }

    func updateUIView(_ uiView: PreviewView, context: Context) {
        uiView.previewLayer.frame = uiView.bounds
    }

    class PreviewView: UIView {
        override class var layerClass: AnyClass { AVCaptureVideoPreviewLayer.self }
        var previewLayer: AVCaptureVideoPreviewLayer { layer as! AVCaptureVideoPreviewLayer }

        private var session: AVCaptureSession?

        func startSession(updating countsBinding: Binding<Float>) {
            Task {

                let configuration = VideoReader.CameraConfiguration(position: .back)
                let frameSequence = try await VideoReader.readCamera(configuration: configuration)
                let captureSession = frameSequence.captureSession
                self.session = captureSession

                previewLayer.session = captureSession
                previewLayer.videoGravity = .resizeAspectFill

                let countExtractor = HumanBodyPoseExtractor()
                    .appending(PoseSelector(strategy: .rightmostJointLocation))
                    .appending(SlidingWindowTransformer<Pose>(stride: 15, length: 90))
                    .appending(HumanBodyActionCounter())

                let countsSequence = try await countExtractor.applied(to: frameSequence)

                var iterator = countsSequence.makeAsyncIterator()
                while let count = try await iterator.next() {
                    await MainActor.run {
                        countsBinding.wrappedValue = count.feature
                    }
                }
            }
        }
    }
}

#Preview {
    CameraView()
}
