import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'models/portfolio_data.dart';

/// Loads and parses the single hand-editable content file
/// (`assets/content/portfolio_data.json`) that drives every section of the
/// portfolio. Update that JSON file to change what's shown on the site —
/// no widget code needs to change.
class PortfolioRepository {
  const PortfolioRepository();

  static const String _assetPath = 'assets/content/portfolio_data.json';

  Future<PortfolioData> load() async {
    final raw = await rootBundle.loadString(_assetPath);
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return PortfolioData.fromJson(json);
  }
}
