# Task Management Architecture with Riverpod

### Features

- Pin Code
- Edit Pin Code
- Fetch Task
- Pagination

### What is used in this project?

- **Riverpod**
  Used for state management
- **Freezed**
  Code generation

- **Dartz**
  Functional Programming `Either<Left,Right>`
- **Auto Route**
  Navigation package that uses code generation to simplify route setup
- **Dio**
  Http client for dart. Supports interceptors and global configurations
- **Shared Preferences**
  Persistent storage for simple data

### Project Description

#### Data

The data layer is the outermost layer of the application and is responsible for communicating with the server-side or a local database and data management logic. It also contains repository implementations.

##### a. Data Source

Describes the process of acquiring and updating the data.
Consist of remote and local Data Sources. Remote Data Source will perform HTTP requests on the API. At the same time, local Data sources will cache or persist data.

##### b. Repository

The bridge between the Data layer and the Domain layer.
Actual implementations of the repositories in the Domain layer. Repositories are responsible for coordinating data from the different Data Sources.

#### Domain

The domain layer is responsible for all the business logic. It is written purely in Dart without flutter elements because the domain should only be concerned with the business logic of the application, not with the implementation details.

##### a. Providers

Describes the logic processing required for the application.
Communicates directly with the repositories.

##### b. Repositories

Abstract classes that define the expected functionality of outer layers.

#### Presentation

The presentation layer is the most framework-dependent layer. It is responsible for all the UI and handling the events in the UI. It does not contain any business logic.

##### a. Widget (Screens/Views)

Widgets notify the events and listen to the states emitted from the `StateNotifierProvider`.

##### b. Providers

Describes the logic processing required for the presentation.
Communicates directly with the `Providers` from the domain layer.

### Testing

The `test` folder mirrors the `lib` folder in addition to some test utilities.

[`state_notifier_test`](https://pub.dev/packages/state_notifier_test) is used to test the `StateNotifier` and mock `Notifier`.

[`mocktail`](https://pub.dev/packages/mocktail) is used to mock dependecies.

### Run this project

##### Clone this repository

` git clone https://github.com/SumalHarry/task-management`

##### Go to the project directory

` cd task-management`

##### Get all the packages

`flutter pub get`

##### Run the build runner command

`flutter pub run build_runner build `

##### Run the project

`flutter run` or simply press ` F5 key` if you are using VSCode

### To explore test coverage
run  `bash gencov.sh` or `flutter test`

### About Me

Supawat Yongkasemkul
