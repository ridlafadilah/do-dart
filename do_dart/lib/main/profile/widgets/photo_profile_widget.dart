import 'dart:io';

import 'package:do_common/common.dart';
import 'package:do_core/bloc.dart';
import 'package:do_dart/main/profile/bloc/photo_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoProfileBloc, CommonState>(
      builder: (context, state) {
        if (state is RequestInProgressState) {
          return const SkeletonRound();
        } else {
          if (state is RequestSuccessState<String>) {
            if (state.data != null) {
              return CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(File(state.data)),
              );
            }
          }
          return const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/avatars/default.png'),
          );
        }
      },
    );
  }
}
