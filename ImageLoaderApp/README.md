## ImageLoaderApp iOS Application

This iOS application displays a grid of images fetched from a remote API. It implements lazy loading and cancellation of previous page loading to optimize performance and resource utilization.

## Prerequisites

- Xcode installed on your macOS device
- Access to the internet to fetch images from the remote API

## Getting Started

1. Clone this repository to your local machine.



2. Open the Xcode project file (`ImageGrid.xcodeproj`) in Xcode.

3. Build and run the project using the iOS simulator or a connected iOS device.

## Usage

- Upon launching the app, you'll see a grid of images loaded from the remote API.
- Scroll through the grid to load more images. Images are loaded lazily, i.e., only when they are about to be displayed.
- If you quickly scroll through pages, the image loading for previous pages will be cancelled to prioritize loading images for the current page.

## Customization

- You can customize the appearance and behavior of the image grid and individual cells by modifying the code in `ImageCell.swift`, `ImageCache.swift`, and `LoadImagesViewController.swift`.

## Troubleshooting

If you encounter any issues while running the app, try the following:

- Check your internet connection to ensure it's working properly.
- Make sure you have the latest version of Xcode installed.
- Clean and rebuild the project in Xcode.



