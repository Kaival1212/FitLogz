# Fitlogz 🏋️‍♂️
> Track your fitness journey effortlessly with Fitlogz!

Fitlogz is a cutting-edge fitness tracking application that helps users monitor their workouts, track progress, and achieve their fitness goals. Built with SwiftUI for a seamless and intuitive iOS user experience and powered by a robust backend API developed in Laravel (see the apiFitlogz repository).

## Features ✨
- Workout Tracking: Log and monitor your exercises, sets, reps, and weights.
- Progress Insights: Visualize progress over time with engaging charts.
- Goal Setting: Define fitness goals and track milestones.
- User Profiles: Manage and personalize user data.
- Seamless Syncing: Powered by apiFitlogz for real-time data synchronization.
  
## Technology Stack 🛠️

### Frontend (Fitlogz)

- SwiftUI: Modern, declarative framework for building iOS apps.
- Combine: For managing asynchronous events and data binding.
- CoreData: Local storage for offline access.

### Backend (apiFitlogz)
- Laravel: PHP framework for backend API development.
- MySQL: Database for structured storage of fitness data.
- JWT Authentication: For secure user authentication and API access.
  
## Getting Started 🚀
### Prerequisites
- iOS Development: Requires Xcode 14+ and macOS Monterey or later.
- Backend Setup: Follow the setup guide in the [apiFitLogz](https://github.com/Kaival1212/apiFitLogz) repository.
- API URL: Ensure the API base URL is correctly configured in the iOS app (check Config.swift).
  
### Installation
1. Clone the repository:
```
git clone https://github.com/Kaival1212/FitLogz
cd fitlogz  
```
2. Open the project in Xcode:
```
open Fitlogz.xcodeproj
```  
3. Install required dependencies:
```
pod install
```
4. Configure the API base URL in Config.swift:
```
static let baseURL = "https://your-api-url.com/api"
```
5. Run the app:
`Select a simulator or a connected device.
Hit the Run button in Xcode.
Backend Setup
Refer to the apiFitlogz repository for instructions on setting up the Laravel backend.`

## Contact 📬
For queries or feedback:

- Email: kaival225@gmail.com
- Website: [Website](https://kaival.co.uk/)
