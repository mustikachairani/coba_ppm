import 'package:flutter_map/src/geo/crs.dart';
import 'package:flutter_map/src/geo/latlng_bounds.dart';
import 'package:flutter_map/src/layer/tile_layer/tile_bounds/tile_bounds_at_zoom.dart';
import 'package:flutter_map/src/layer/tile_layer/tile_range.dart';
import 'package:flutter_map/src/misc/bounds.dart';
import 'package:latlong2/latlong.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TileBounds {
  final Crs crs;
  final double _tileSize;
  final LatLngBounds? _latLngBounds;

  factory TileBounds({
    required Crs crs,
    required double tileSize,
    LatLngBounds? latLngBounds,
  }) {
    if (crs.infinite && latLngBounds == null) {
      return InfiniteTileBounds._(crs, tileSize, latLngBounds);
    } else if (crs.wrapLat == null && crs.wrapLng == null) {
      return DiscreteTileBounds._(crs, tileSize, latLngBounds);
    } else {
      return WrappedTileBounds._(crs, tileSize, latLngBounds);
    }
  }

  const TileBounds._(
    this.crs,
    this._tileSize,
    this._latLngBounds,
  );

  TileBoundsAtZoom atZoom(int zoom);

  // Returns true if these bounds may no longer be valid for the given
  // parameters.
  bool shouldReplace(
    Crs crs,
    double tileSize,
    LatLngBounds? latLngBounds,
  ) =>
      crs != this.crs || tileSize != _tileSize || latLngBounds != _latLngBounds;
}

@immutable
class InfiniteTileBounds extends TileBounds {
  const InfiniteTileBounds._(
    super.crs,
    super._tileSize,
    super._latLngBounds,
  ) : super._();

  @override
  TileBoundsAtZoom atZoom(int zoom) => const InfiniteTileBoundsAtZoom();
}

@immutable
class DiscreteTileBounds extends TileBounds {
  final Map<int, TileBoundsAtZoom> _tileBoundsAtZoomCache = {};

  DiscreteTileBounds._(
    super.crs,
    super._tileSize,
    super._latLngBounds,
  ) : super._();

  @override
  TileBoundsAtZoom atZoom(int zoom) {
    return _tileBoundsAtZoomCache.putIfAbsent(
        zoom, () => _tileBoundsAtZoomImpl(zoom));
  }

  TileBoundsAtZoom _tileBoundsAtZoomImpl(int zoom) {
    final zoomDouble = zoom.toDouble();

    final Bounds<double> pixelBounds;
    if (_latLngBounds == null) {
      pixelBounds = crs.getProjectedBounds(zoomDouble)!;
    } else {
      pixelBounds = Bounds<double>(
        crs.latLngToPoint(_latLngBounds!.southWest, zoomDouble),
        crs.latLngToPoint(_latLngBounds!.northEast, zoomDouble),
      );
    }

    return DiscreteTileBoundsAtZoom(
      DiscreteTileRange.fromPixelBounds(
        zoom: zoom,
        tileSize: _tileSize,
        pixelBounds: pixelBounds,
      ),
    );
  }
}

@immutable
class WrappedTileBounds extends TileBounds {
  final Map<int, WrappedTileBoundsAtZoom> _tileBoundsAtZoomCache = {};

  WrappedTileBounds._(
    super.crs,
    super._tileSize,
    super._latLngBounds,
  ) : super._();

  @override
  TileBoundsAtZoom atZoom(int zoom) {
    return _tileBoundsAtZoomCache.putIfAbsent(
        zoom, () => _tileBoundsAtZoomImpl(zoom));
  }

  WrappedTileBoundsAtZoom _tileBoundsAtZoomImpl(int zoom) {
    final zoomDouble = zoom.toDouble();

    final Bounds<double> pixelBounds;
    if (_latLngBounds == null) {
      pixelBounds = crs.getProjectedBounds(zoomDouble)!;
    } else {
      pixelBounds = Bounds<double>(
        crs.latLngToPoint(_latLngBounds!.southWest, zoomDouble),
        crs.latLngToPoint(_latLngBounds!.northEast, zoomDouble),
      );
    }

    (int, int)? wrapX;
    if (crs.wrapLng case final wrapLng?) {
      final wrapXMin =
          (crs.latLngToPoint(LatLng(0, wrapLng.$1), zoomDouble).x / _tileSize)
              .floor();
      final wrapXMax =
          (crs.latLngToPoint(LatLng(0, wrapLng.$2), zoomDouble).x / _tileSize)
              .ceil();
      wrapX = (wrapXMin, wrapXMax - 1);
    }

    (int, int)? wrapY;
    if (crs.wrapLat case final wrapLat?) {
      final wrapYMin =
          (crs.latLngToPoint(LatLng(wrapLat.$1, 0), zoomDouble).y / _tileSize)
              .floor();
      final wrapYMax =
          (crs.latLngToPoint(LatLng(wrapLat.$2, 0), zoomDouble).y / _tileSize)
              .ceil();
      wrapY = (wrapYMin, wrapYMax - 1);
    }

    return WrappedTileBoundsAtZoom(
      tileRange: DiscreteTileRange.fromPixelBounds(
        zoom: zoom,
        tileSize: _tileSize,
        pixelBounds: pixelBounds,
      ),
      wrappedAxisIsAlwaysInBounds: _latLngBounds == null,
      wrapX: wrapX,
      wrapY: wrapY,
    );
  }
}
