import 'package:uuid/uuid.dart' show Uuid;
import 'package:uuid/uuid_util.dart' show UuidUtil;

const _uuid = Uuid();

// TODO learn to use the newer version of the package

String generateUuid() => _uuid.v4(
      options: {
        'rng': UuidUtil.cryptoRNG,
      },
    );
