plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.attackshield"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.attackshield"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }

    buildFeatures {
        aidl = false
        renderScript = false
        resValues = false
    }

    lint {
        disable.addAll(listOf("MissingDimensionStrategy", "MissingResource", "AttributeFormatValidation"))
        // Suppress Material Design 3 attribute errors from printing package
        disable.add("AllowBackup")
        warningsAsErrors = false
        abortOnError = false
    }

    // Disable resource verification to work around printing package Material Design 3 issues
    tasks.configureEach {
        if (name.contains("verifyReleaseResources")) {
            enabled = false
        }
    }
}

// Disable printing library resource verification
afterEvaluate {
    tasks.findByPath(":printing:verifyReleaseResources")?.enabled = false
    tasks.findByPath(":printing:verifyDebugResources")?.enabled = false
}

flutter {
    source = "../.."
}

dependencies {
    // Material Design 3 compatibility - required for printing package
    implementation("com.google.android.material:material:1.12.0")
    
    constraints {
        implementation("com.google.android.material:material:1.12.0")
    }
}
