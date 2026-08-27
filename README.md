# Omkar Mhatre — Portfolio

A Flutter Web portfolio for Omkar Mhatre, Senior Flutter Developer. Deployed automatically to GitHub Pages on every push to `main`.

## Editing content

All real-world content — bio, contact details, skills, experience, projects, achievements, education — lives in one file:

```
assets/content/portfolio_data.json
```

Edit that file and nothing else to update the site. No Dart code needs to change; every section widget reads from this JSON at runtime through `lib/data/portfolio_repository.dart`. To swap the résumé PDF, replace `assets/resume/Omkar_Mhatre_Resume.pdf` (keep the same filename, or update `profile.resumeAssetPath` / `profile.resumeFileName` in the JSON to match).

## Running locally

```
flutter pub get
flutter run -d chrome
```

## Building for production

```
flutter build web --release --base-href /omkar_mhatre/
```

## Deployment

Pushing to `main` triggers `.github/workflows/deploy.yml`, which runs `flutter analyze` and `flutter test`, builds the release web bundle, and publishes it to GitHub Pages via the official Pages Actions.

**One-time setup**: in the repo's Settings → Pages, set **Source** to **GitHub Actions**. After that, every push to `main` deploys automatically to `https://<your-username>.github.io/omkar_mhatre/`.
