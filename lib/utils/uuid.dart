import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

const _uuid = Uuid();

String generateUuid() => _uuid.v4(
      options: {
        "rng": UuidUtil.cryptoRNG,
      },
    );
