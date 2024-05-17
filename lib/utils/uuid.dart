import 'package:uuid/uuid.dart' show Uuid;
import 'package:uuid/uuid_util.dart' show UuidUtil;

const _uuid = Uuid();

String generateUuid() => _uuid.v4(
      options: {
        'rng': UuidUtil.cryptoRNG,
      },
    );
