plugins {
    id("com.android.application")
    id("kotlin-android")
    id("com.google.gms.google-services") // Agregado aquí
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.tenangos"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" 

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.tenangos"
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Firebase BoM para gestionar versiones
    implementation(platform("com.google.firebase:firebase-bom:34.0.0"))

    // Firebase Analytics (opcional)
    implementation("com.google.firebase:firebase-analytics")

    // Firebase Authentication (necesario para Google Sign-In)
    implementation("com.google.firebase:firebase-auth")
}
