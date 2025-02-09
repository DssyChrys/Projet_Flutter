class ImageData {
  static const List<String> randomImages = [
    'https://images.unsplash.com/photo-1467810563316-b5476525c0f9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8JUMzJUE5diVDMyVBOW5lbWVudHN8ZW58MHx8MHx8fDA%3D',
    'https://images.unsplash.com/photo-1478145787956-f6f12c59624d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fCVDMyVBOXYlQzMlQTluZW1lbnRzfGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dm95YWdlfGVufDB8fDB8fHww',
    'https://images.unsplash.com/photo-1564349683136-77e08dba1ef7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8YW5pbWF1eHxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1591824438708-ce405f36ba3d?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8YW5pbWF1eHxlbnwwfHwwfHx8MA%3D%3D',
    'https://plus.unsplash.com/premium_photo-1673108852141-e8c3c22a4a22?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bm91cnJpdHVyZXxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8bm91cnJpdHVyZXxlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1565958011703-44f9829ba187?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fG5vdXJyaXR1cmV8ZW58MHx8MHx8fDA%3D',
    'https://plus.unsplash.com/premium_photo-1684820878202-52781d8e0ea9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTN8fHNwb3J0c3xlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1535131749006-b7f58c99034b?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fHNwb3J0c3xlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1474511320723-9a56873867b5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fGFuaW1hdXh8ZW58MHx8MHx8fDA%3D',
    'https://images.unsplash.com/photo-1734253870682-a7d36c2949df?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTR8fHxlbnwwfHx8fHw%3D',
    'https://plus.unsplash.com/premium_photo-1661347826507-5cd1020f9442?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTN8fHxlbnwwfHx8fHw%3D',
    'https://images.unsplash.com/photo-1617440168937-c6497eaa8db5?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8JUMzJUE5bW90aW9uc3xlbnwwfHwwfHx8MA%3D%3D',
    'https://images.unsplash.com/photo-1613714034024-48ccb087174c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fCVDMyVBOW1vdGlvbnN8ZW58MHx8MHx8fDA%3D',
    'https://images.unsplash.com/photo-1583847323635-7ad5b93640ad?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fCVDMyVBOW1vdGlvbnN8ZW58MHx8MHx8fDA%3D',
  ];

  static String getRandomImage() {
    return randomImages[DateTime.now().millisecondsSinceEpoch % randomImages.length];
  }
}