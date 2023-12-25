import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_example/pages/scale_layer_plugin_option.dart';
import 'package:flutter_map_example/widgets/drawer.dart';

class PluginScaleBar extends StatelessWidget {
  static const String route = '/plugin_scalebar';

  const PluginScaleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ScaleBarPlugins')),
      drawer: buildDrawer(context, PluginScaleBar.route),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(51.5, -0.09),
                  initialZoom: 5,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  ScaleLayerWidget(
                    options: ScaleLayerPluginOption(
                      lineColor: Colors.blue,
                      lineWidth: 2,
                      textStyle:
                          const TextStyle(color: Colors.blue, fontSize: 12),
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
