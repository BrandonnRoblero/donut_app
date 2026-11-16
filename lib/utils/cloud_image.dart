import 'package:cached_network_image/cached_network_image.dart';
import 'package:donut_app/utils/supabase_config.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//Imagen de producto que se descarga de Supabase Storage.
//Recibe la misma ruta de siempre ("assets/images/chocolate_donut.png")
//y usa solo el nombre del archivo para buscarlo en el bucket.
class CloudImage extends StatelessWidget {
  final String imagePath;

  const CloudImage(this.imagePath, {super.key});

  //Imagen por defecto cuando no hay internet o falla la descarga
  static const String placeholder = 'assets/images/placeholder.png';

  @override
  Widget build(BuildContext context) {
    final String fileName = imagePath.split('/').last;
    final String url = Supabase.instance.client.storage
        .from(SupabaseConfig.bucket)
        .getPublicUrl(fileName);

    return CachedNetworkImage(
      imageUrl: url,
      //Mientras descarga
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          strokeWidth: 3,
          color: Colors.pink[300],
        ),
      ),
      //Sin internet o error: imagen por defecto
      errorWidget: (context, url, error) => Image.asset(placeholder),
    );
  }
}
