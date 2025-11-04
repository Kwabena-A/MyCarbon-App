import 'package:flutter/cupertino.dart';

import '../Widgets/conversation_widget.dart';
import '../Widgets/speech_widget.dart';

ValueNotifier currentPage = ValueNotifier(0);
ValueNotifier isScrolled = ValueNotifier(false);

ValueNotifier<List<SpeechInfo>> conversation = ValueNotifier([
  SpeechInfo(SpeechSide.bot, "good to here!"),
]);

ValueNotifier<int> currentQuestion = ValueNotifier(0);