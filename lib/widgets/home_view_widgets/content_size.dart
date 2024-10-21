import '../../utils/screen_size.dart';

//[width, height]
List<double> contentSize() {
  if(screenSize.width > screenSize.height) {
    return [(screenSize.width / 7) * 0.75, screenSize.height / 10];
  } else {
    return [screenSize.width / 8.25, (screenSize.height / 8) * 0.5];
  }
}