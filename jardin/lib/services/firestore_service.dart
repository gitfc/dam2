import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService {
  Stream<QuerySnapshot> noticias() {
    return FirebaseFirestore.instance
        .collection('noticias')
        .orderBy('fecha', descending: true)
        .snapshots();
  }

  Future noticiasAgregar(String titulo, String contenido, DateTime fecha) {
    return FirebaseFirestore.instance.collection('noticias').doc().set(
      {
        'titulo': titulo,
        'contenido': contenido,
        'fecha': fecha,
      },
    );
  }

  Future noticiasBorrar(String noticiaId) {
    return FirebaseFirestore.instance
        .collection('noticias')
        .doc(noticiaId)
        .delete();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getNoticia(
      String noticiaId) async {
    return await FirebaseFirestore.instance
        .collection('noticias')
        .doc(noticiaId)
        .get();
  }

  Future noticiasEditar(
      String noticiaId, String titulo, String contenido, DateTime fecha) {
    return FirebaseFirestore.instance
        .collection('noticias')
        .doc(noticiaId)
        .update(
      {
        'titulo': titulo,
        'contenido': contenido,
        'fecha': fecha,
      },
    );
  }
}
