import 'dart:io';
import 'package:timely/features/tab_one/models/db_files.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final dbFilesProvider = FutureProvider<DBFiles>((ref) async {
  Directory docDir = await getApplicationDocumentsDirectory();
  File tabOneFile = File('${docDir.path}/tab_one.json');
  File tabFiveFile = File('${docDir.path}/tab_five.json');

  if (!await tabOneFile.exists()) {
    await tabOneFile.writeAsString('''
      {
    "02-10-2023": {
        "text_1": "asdg",
        "data": {
            "09:00": {
                "time_2": "",
                "type_a": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "Some comment"
                },
                "type_b": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "Some comment"
                },
                "type_c": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "Some comment"
                }
            },
            "10:00": {
                "time_2": "",
                "type_a": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "Some comment"
                },
                "type_b": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "Some comment"
                },
                "type_c": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "Some comment"
                }
            },
            "14:44": {
                "time_2": "",
                "type_a": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "asgd"
                },
                "type_b": {
                    "rating": [
                        0,
                        1,
                        0
                    ],
                    "comment": "ads"
                },
                "type_c": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "cads"
                }
            }
        }
    },
    "03-10-2023": {
        "text_1": "Some top-level text",
        "data": {
            "9:30": {
                "time_2": "",
                "type_a": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "Some comment"
                },
                "type_b": {
                    "rating": [
                        0,
                        1,
                        0
                    ],
                    "comment": "Some comment"
                },
                "type_c": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "Some comment"
                }
            },
            "11:00": {
                "time_2": "",
                "type_a": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "Some comment"
                },
                "type_b": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "Some comment"
                },
                "type_c": {
                    "rating": [
                        0,
                        1,
                        0
                    ],
                    "comment": "Some comment"
                }
            }
        }
    },
    "2023-10-08": {
        "text_1": "sdfsaaf",
        "data": {
            "07:33": {
                "time_2": "",
                "type_a": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "adsaf"
                },
                "type_b": {
                    "rating": [
                        0,
                        1,
                        0
                    ],
                    "comment": "q23e"
                },
                "type_c": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "dasfasf"
                }
            },
            "07:54": {
                "time_2": "",
                "type_a": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "bla bla bla"
                },
                "type_b": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "bla bla bla bla bla bla"
                },
                "type_c": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "bla bla bla bla bla bla bla bla bla bla bla bla"
                }
            },
            "08:17": {
                "time_2": "",
                "type_a": {
                    "rating": [
                        0,
                        1,
                        0
                    ],
                    "comment": "sda"
                },
                "type_b": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "gagsasgsag"
                },
                "type_c": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "adsgaddaasga"
                }
            },
            "08:47": {
                "time_2": "",
                "type_a": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "agdsaga"
                },
                "type_b": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "sag"
                },
                "type_c": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "adf"
                }
            }
        }
    },
    "2023-10-10": {
        "text_1": "a",
        "data": {
            "5:55": {
                "time_2": "23:5",
                "type_a": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "v"
                },
                "type_b": {
                    "rating": [
                        0,
                        1,
                        0
                    ],
                    "comment": "c"
                },
                "type_c": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "d"
                }
            }
        }
    },
    "2023-10-19": {
        "text_1": "jasdlkfj;dask",
        "data": {
            " 05:25": {
                "time_2": " 05:25",
                "type_a": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "Quran"
                },
                "type_b": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "Salah"
                },
                "type_c": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "VCCSCCRW"
                }
            },
            "05:30": {
                "time_2": "05:30",
                "type_a": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "jkasdfj;as"
                },
                "type_b": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "Askajfs"
                },
                "type_c": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "WkaKJkla"
                }
            }
        }
    },
    "2023-10-21": {
        "text_1": "hhello",
        "data": {
            "9:25": {
                "time_2": "07:25",
                "type_a": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "kjll;sa"
                },
                "type_b": {
                    "rating": [
                        1,
                        0,
                        0
                    ],
                    "comment": "asfd;jsad"
                },
                "type_c": {
                    "rating": [
                        0,
                        0,
                        1
                    ],
                    "comment": "askldfj"
                }
            }
        }
    }
}
    
''');
  }

  if (!await tabFiveFile.exists()) {
    await tabFiveFile.writeAsString("{}");
  }

  return DBFiles(tabOneFile: tabOneFile, tabFiveFile: tabFiveFile);
});
