import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'image_event.dart';
import 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  final ImagePicker _imagePicker = ImagePicker();

  ImageBloc() : super(ImageInitial()){
    on<ImageEvent>((event, emit) async {
      if (event is ImagePicked) {
        ImageLoadInProgress();
        try {
          final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
          if (pickedFile != null) {
            ImageLoadSuccess(pickedFile.path);
          } else {
            ImageLoadFailure();
          }
        } catch (e) {
          ImageLoadFailure();
        }
      }
    });
  }



  @override
  Stream<ImageState> mapEventToState(ImageEvent event) async* {
    if (event is ImagePicked) {
      yield ImageLoadInProgress();
      try {
        final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          yield ImageLoadSuccess(pickedFile.path);
        } else {
          yield ImageLoadFailure();
        }
      } catch (e) {
        yield ImageLoadFailure();
      }
    }
  }
}
