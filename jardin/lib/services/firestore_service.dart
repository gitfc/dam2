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

  Future noticiasEliminar(String id) {
    return FirebaseFirestore.instance.collection('noticias').doc(id).delete();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getNoticia(String id) async {
    return await FirebaseFirestore.instance
        .collection('noticias')
        .doc(id)
        .get();
  }

  Future noticiasEditar(
      String id, String titulo, String contenido, DateTime fecha) {
    return FirebaseFirestore.instance.collection('noticias').doc(id).update(
      {
        'titulo': titulo,
        'contenido': contenido,
        'fecha': fecha,
      },
    );
  }
}
