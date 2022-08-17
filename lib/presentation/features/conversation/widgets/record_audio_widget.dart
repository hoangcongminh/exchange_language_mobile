import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../routes/app_pages.dart';
import '../../../theme/chat_style.dart';
import '../../../theme/colors.dart';

class RecordAudioWidet extends StatefulWidget {
  final Function(File) onSendAudio;
  const RecordAudioWidet({
    Key? key,
    required this.onSendAudio,
  }) : super(key: key);

  @override
  State<RecordAudioWidet> createState() => _RecordAudioWidetState();
}

class _RecordAudioWidetState extends State<RecordAudioWidet> {
  // final recorder = FlutterSoundRecorder();
  late final RecorderController recorderController;
  File? recoredFile;

  @override
  void initState() {
    super.initState();

    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..sampleRate = 16000;

    record();
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }

  Future record() async {
    await recorderController.record();
    setState(() {});
  }

  Future pause() async {
    await recorderController.pause();
  }

  Future<File> stop() async {
    final path = await recorderController.stop();
    final audioFile = File(path!.split('//').last);
    return audioFile;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorConversationInput,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp, horizontal: 16.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () async {
                  if (recorderController.isRecording) {
                    final recordedFile = await stop();
                    recordedFile.delete();
                    setState(() {});
                    AppNavigator().pop();
                  }
                },
                icon: const Icon(
                  Icons.delete,
                ),
              ),
              Expanded(
                child: AudioWaveforms(
                  size: Size(MediaQuery.of(context).size.width / 5 * 3, 50),
                  recorderController: recorderController,
                  waveStyle: const WaveStyle(
                    waveColor: AppColors.primaryColor,
                    extendWaveform: true,
                    showMiddleLine: false,
                  ),
                  padding: const EdgeInsets.only(left: 18),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                ),
              ),
              IconButton(
                onPressed: () async {
                  if (recorderController.isRecording) {
                    final recordedFile = await stop();
                    setState(() {});
                    widget.onSendAudio(recordedFile);
                    AppNavigator().pop();
                  }
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
