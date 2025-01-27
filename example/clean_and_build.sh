#!/bin/bash

echo "🚀 Starting cleanup for the current Flutter project..."

# Step 1: Run Flutter clean
echo "🧹 Running flutter clean..."
flutter clean

# Step 2: Remove Flutter's build folder (this is typically the root "build/" directory)
echo "🧹 Removing Flutter's build folder..."
rm -rf build/
if [ $? -eq 0 ]; then
    echo "✅ Flutter build folder removed successfully."
else
    echo "⚠️ Failed to remove Flutter build folder."
fi

# Step 3: Clean iOS-specific build folder inside the "ios" directory
if [ -d "ios" ]; then
    echo "🧹 Cleaning iOS build folder inside the project directory..."

    # Remove the iOS build folder
    rm -rf ios/build/
    if [ $? -eq 0 ]; then
        echo "✅ iOS build folder removed successfully."
    else
        echo "⚠️ Failed to remove iOS build folder."
    fi

    # Remove the DerivedData folder inside ios (if it exists)
    echo "🧹 Cleaning iOS DerivedData folder inside the project directory..."

    if [ -d "ios/DerivedData" ]; then
        rm -rf ios/DerivedData/
        if [ $? -eq 0 ]; then
            echo "✅ iOS DerivedData folder removed successfully."
        else
            echo "⚠️ Failed to remove iOS DerivedData folder."
        fi
    else
        echo "⚠️ No DerivedData folder found inside the iOS directory."
    fi

    # Remove the Pods folder inside ios (if it exists)
    echo "🧹 Cleaning iOS Pods folder inside the project directory..."

    if [ -d "ios/Pods" ]; then
        rm -rf ios/Pods/
        if [ $? -eq 0 ]; then
            echo "✅ iOS Pods folder removed successfully."
        else
            echo "⚠️ Failed to remove iOS Pods folder."
        fi
    else
        echo "⚠️ No Pods folder found inside the iOS directory."
    fi

    # Remove the .symlinks folder inside ios (if it exists)
    echo "🧹 Cleaning iOS .symlinks folder inside the project directory..."

    if [ -d "ios/.symlinks" ]; then
        rm -rf ios/.symlinks/
        if [ $? -eq 0 ]; then
            echo "✅ iOS .symlinks folder removed successfully."
        else
            echo "⚠️ Failed to remove iOS .symlinks folder."
        fi
    else
        echo "⚠️ No .symlinks folder found inside the iOS directory."
    fi
else
    echo "⚠️ No iOS directory found in this project. Skipping iOS cleanup."
fi

# Step 4: Clean Android-specific build artifacts
if [ -d "android" ]; then
    echo "🧹 Cleaning Android build folder..."
    rm -rf android/app/build/
    if [ $? -eq 0 ]; then
        echo "✅ Android build folder removed successfully."
    else
        echo "⚠️ Failed to remove Android build folder."
    fi

    echo "🧹 Cleaning Gradle cache for the current project..."
    rm -rf android/.gradle/
    if [ $? -eq 0 ]; then
        echo "✅ Gradle cache removed successfully."
    else
        echo "⚠️ Failed to remove Gradle cache."
    fi
else
    echo "⚠️ No Android directory found in this project. Skipping Android cleanup."
fi

# Step 5: Run flutter pub get to fetch dependencies
echo "📦 Running flutter pub get to fetch dependencies..."
flutter pub get
if [ $? -eq 0 ]; then
    echo "✅ Dependencies fetched successfully."
else
    echo "⚠️ Failed to fetch dependencies."
fi

# Final message
echo "🎉 Cleanup completed successfully for the current Flutter project!"
