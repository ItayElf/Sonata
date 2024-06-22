import 'package:intl/intl.dart';

const _instruments = {
  "Piano": "🎹",
  "Guitar": "🎸",
  "Violin": "🎻",
  "Saxophone": "🎷",
  "Drums": "🥁",
  "Ukulele": "🎸",
  null: "🎵",
};

const _states = {0: "To Learn", 1: "Learning", 2: "Learned"};

String getInstrumentEmoji(String? instrument) {
  if (!_instruments.containsKey(instrument)) return _instruments[null]!;
  return _instruments[instrument]!;
}

String getStateString(int state) {
  return _states[state]!;
}

String getFormattedDate(DateTime date) {
  final DateFormat formatter = DateFormat('dd MMM yyyy');
  final String formatted = formatter.format(date);
  return formatted;
}
