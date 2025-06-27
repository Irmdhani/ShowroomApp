# Luxury Cars Showroom - Flutter Application

A cross-platform mobile application built with Flutter that serves as a digital showroom for buying and selling used luxury cars. This project demonstrates a complete CRUD (Create, Read, Update, Delete) functionality with local data persistence using SQLite.

| Car List | Car Detail | Add/Edit Form |
| :---: | :---: | :---: |
| *(Tambahkan screenshot halaman utama Anda di sini)* | *(Tambahkan screenshot halaman detail Anda di sini)* | *(Tambahkan screenshot halaman jual/edit Anda di sini)* |

## Features

-   **Browse Cars:** View a list of available cars with their primary image and price.
-   **Detailed View:** Tap on a car to see a detailed page with multiple images (swipeable), a full description, and seller information.
-   **List a Car for Sale:** A user-friendly form to add a new car listing, including uploading multiple photos from the device gallery.
-   **Edit & Delete:** Users can edit the details of their listings or delete them entirely.
-   **Contact Seller:** A "Contact Seller" button that directly opens a pre-filled WhatsApp chat with the seller.
-   **Local Persistence:** All car data is stored locally on the device using an SQLite database, ensuring data is available offline.
-   **User Authentication:** A simple login and profile page to manage user sessions.
-   **Cross-Platform:** Developed to be compatible with both mobile (iOS) and Web platforms.

## Technology Stack

-   **Framework:** Flutter
-   **Language:** Dart
-   **Database:** `sqflite` for local storage on mobile, with `sqflite_common_ffi_web` for web compatibility (using IndexedDB).
-   **Key Packages:**
    -   `image_picker`: For selecting single or multiple images from the device gallery.
    -   `url_launcher`: To open external links, specifically for the WhatsApp integration.
    -   `shared_preferences`: For simple user session management.
    -   `path`: For handling database paths on mobile platforms.
-   **State Management:** `StatefulWidget` with `setState` for managing UI state.

## Getting Started

To run this project locally, follow these steps:

1.  **Clone the repository:**
    ```sh
    git clone [your-repository-url]
    ```

2.  **Navigate to the project directory:**
    ```sh
    cd ShowroomApp-7064bab81e3ae6941ccabf16723d508a256f0e18
    ```

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

4.  **Run the application:**
    ```sh
    flutter run
    ```

## Author

**Mohamad Ilham Ramadhani** - A11.2022.14587
