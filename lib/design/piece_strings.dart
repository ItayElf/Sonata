import 'package:intl/intl.dart';

const pieceInstruments = {
  "Piano": "🎹",
  "Guitar": "🎸",
  "Violin": "🎻",
  "Saxophone": "🎷",
  "Drums": "🥁",
  "Ukulele": "🎸",
  null: "🎵",
};

const pieceStates = {0: "To Learn", 1: "Learning", 2: "Learned"};

String getInstrumentEmoji(String? instrument) {
  if (!pieceInstruments.containsKey(instrument)) return pieceInstruments[null]!;
  return pieceInstruments[instrument]!;
}

String getStateString(int state) {
  return pieceStates[state]!;
}

String getFormattedDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd MMM yyyy');
  final String formatted = formatter.format(date);
  return formatted;
}
