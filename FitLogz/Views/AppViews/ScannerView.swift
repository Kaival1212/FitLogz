import SwiftUI
import VisionKit

struct ScannerView: View {
    @State private var isPresentingScanner = false
    @State private var isPresentingManualAdd = false
    @State var scannedCode: String = ""
    @State var scannedFood: ProductNutriments? = nil
    @State var userFoods: [UserFood]? = nil
    @State var error: String? = nil
    @State var dailyNutrients:UserNutrients? = nil
    @State var textCode: String = ""
    var user : User? = AuthConnect.Singleton.user
    
    var body: some View {
        ZStack() {
            Color.backGround
                .ignoresSafeArea(.all)
            
            ScrollView {
                HeaderView()
    
                VStack {
                    NurtitionGoals(dailyNutrients:$dailyNutrients)
                        .padding(.top , 15)

                    HStack {
                        Button(action: {
                            isPresentingScanner = true
                        }) {
                            HStack {
                                Image(systemName: "barcode.viewfinder")
                                    .resizable()
                                    .foregroundStyle(Color.defPrimary)
                                    .frame(width: 25, height: 25)
                                Text("Scan Barcode")
                                    .foregroundStyle(Color.defPrimary)
                                    .font(.headline)
                            }
                            .padding(.horizontal)
                            .padding(.vertical, 10)
                            .background(Color.defSecondary)
                            .cornerRadius(30)
                        }

                    }.padding()
                    
                    if userFoods != nil {
                            ForEach(userFoods!, id: \.id) { food in
                                UserFoodComponent(food: food)
                                    .padding(.horizontal)
                                    .padding(.vertical,5)
                            }
                    }
                    
                }.sheet(isPresented: $isPresentingScanner){
                    BarcodeScannerView(scannedCode: $scannedCode, isPresented: $isPresentingScanner)
                }
                .sheet(isPresented: $isPresentingManualAdd){
                    
                }

            }
        }
        .onChange(of: isPresentingScanner){
            error=nil
            UpdateDailyFoodIntake()
        }
        .refreshable {
            UpdateDailyFoodIntake()
        }
        .onAppear(perform: {
            UpdateDailyFoodIntake()
        })
    }
    
    func UpdateDailyFoodIntake(){
        UserFoodApi.getDailyFood(){ data in
            switch data {
                case .success(let foods):
                    print("done")
                    userFoods=foods
                case .failure(let error):
                    print(error)
            }
        }
        
        UserFoodApi.getDailyNutrients(){ data in
            switch data {
                case .success(let nutrients):
                    dailyNutrients=nutrients
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}


#Preview {
    
    let test = ProductNutriments(
        id: "cookie_001",
        name: "Biscuit",
        name_en: "Cookie",
//        quantity: "1 pack",
//        quantity_unit: "g",
        image_front_small_url: "https://images.openfoodfacts.org/images/products/000/000/039/6134/front_fr.13.200.jpg",
        carbohydrates: 61.7,
        carbohydrates_100g: 61.7,
        carbohydrates_serving: 61.7,
        carbohydrates_unit: "g",
        energy: 2155,
        energy_kcal: 515,
        energy_kcal_100g: 515,
        energy_kcal_serving: 515,
        energy_kcal_unit: "kcal",
        fat: 27,
        fat_100g: 27,
        fat_serving: 27,
        fat_unit: "g",
        proteins: 5.6,
        proteins_100g: 5.6,
        proteins_serving: 5.6,
        proteins_unit: "g"
    )
    
    let testfood = UserFood(id: 1, name: "IDK", calories: 21123, protein: 342, carbs: 344, fat: 434)
    let foods = [testfood, testfood, testfood,testfood, testfood, testfood]
    
    ScannerView(scannedFood: test , userFoods: foods)
}
