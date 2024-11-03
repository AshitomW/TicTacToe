# Tic Tac Toe Multiplayer Game

A real-time, multiplayer Tic Tac Toe game developed with **Flutter**, **Riverpod**, **Node.js**, and **MongoDB**. This project uses Flutter to build the UI  with a Node.js backend to create multiplayer system.

## Table of Contents

1. [Technologies Used](#technologies-used)
2. [Getting Started](#getting-started)
3. [Configuration](#configuration)
4. [Running the Application](#running-the-application)
5. [Usage](#usage)
6. [Contributing](#contributing)

## Technologies Used

- **Flutter**: For building cross-platform user interfaces.
- **Riverpod**: A state management library that simplifies app architecture.
- **Dart**: The programming language for the Flutter frontend.
- **Node.js**: Backend server handling API requests and game sessions.
- **MongoDB**: Database for storing game and user data.
- **Socket.io**: Enables real-time communication between players.

## Getting Started

To set up this project, you’ll need to install Flutter, Node.js, and MongoDB.

### Prerequisites

- **Flutter SDK**: [Download Flutter](https://flutter.dev/docs/get-started/install)
- **Node.js**: [Download Node.js](https://nodejs.org/en/download/)
- **MongoDB**: [Download MongoDB](https://www.mongodb.com/try/download/community)

### Download Project Files

1. Clone the repository to your local machine:

   ```bash
   https://github.com/AshitomW/TicTacToe.git
   cd TicTacToe
   ```

## Configuration

### Setting Up the Backend

1. **Navigate to the server directory**:

   ```bash
   cd gameserver
   ```

2. **Install dependencies**:

   ```bash
   npm install
   ```

3. **Configure environment variables**: Create a `.env` file in the `server` directory and add your configuration details:

   ```plaintext
   DB_HOST=your_mongodb_connection_string
   serverAddress=your_server_address
   PORT=3000
   ```

   Replace `your_mongodb_connection_string` with your MongoDB URI.
   Replace `your_server_address` with your server address.

### Setting Up the Flutter Frontend

1. Go back to the main directory and **install Flutter dependencies**:

   ```bash
   flutter pub get
   ```

2. **Update API configuration**: In your Flutter code (e.g., `lib/network/socketclient.dart`), ensure the API endpoint matches the URL and port of your Node.js backend.

## Running the Application

### Start the Backend Server

To start the Node.js backend:

```bash
cd gameserver
npm start
```

The server should start on the specified port, ready to handle requests and manage real-time connections.

### Run the Flutter App

Go back to the root project directory and run:

```bash
flutter run
```

This command will start the Flutter application. Make sure a device or simulator is connected for Flutter to deploy the app.

### Mac Os Configuration

Make sure the following keys are present in DebugProfile.entitlements and Release.entitlements (in macos/Runner)

```
<key>com.apple.security.network.server</key>
<true/>
<key>com.apple.security.network.client</key>
<true/>
```

## Usage

- **Create or Join a Game**: Enter a unique room code or join an existing one to play with a friend.
- **Play Real-Time**: Interact with the game board and see your opponent’s moves in real time.
- **Track Scores**: Scores are updated after each game, stored in MongoDB for persistence.

## Contributing

We welcome contributions to improve the project!
