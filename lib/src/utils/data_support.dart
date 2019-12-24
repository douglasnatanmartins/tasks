import 'package:flutter/material.dart';

class DataSupport {
  static const Map<String, IconData> icons = {
    // Action
    'account_balance': Icons.account_balance,
    'account_balance_wallet': Icons.account_balance_wallet,
    'android': Icons.android,
    'announcement': Icons.announcement,
    'book': Icons.book,
    'bookmark': Icons.bookmark,
    'build': Icons.build,
    'bug_report': Icons.bug_report,
    'code': Icons.code,
    'credit_card': Icons.credit_card,
    'dashboard': Icons.dashboard,
    'date_range': Icons.date_range,
    'delete': Icons.delete,
    'done': Icons.done,
    'event': Icons.event,
    'explore': Icons.explore,
    'extension': Icons.extension,
    'face': Icons.face,
    'favorite': Icons.favorite,
    'feedback': Icons.feedback,
    'fingerprint': Icons.fingerprint,
    'help': Icons.help,
    'home': Icons.home,
    'info': Icons.info,
    'label': Icons.label,
    'language': Icons.language,
    'list': Icons.list,
    'pets': Icons.pets,
    'print': Icons.print,
    'room': Icons.room,
    'shopping_basket': Icons.shopping_basket,
    'shopping_cart': Icons.shopping_cart,
    'stars': Icons.stars,
    'store': Icons.store,
    'thumb_down': Icons.thumb_down,
    'thumb_up': Icons.thumb_up,
    'timeline': Icons.timeline,
    'work': Icons.work,

    // Communication
    'business': Icons.business,
    'email': Icons.email,
    'phone': Icons.phone,

    // Content
    'add_box': Icons.add_box,
    'archive': Icons.archive,
    'flag': Icons.flag,
    'report': Icons.report,

    // File
    'attachment': Icons.attachment,
    'cloud': Icons.cloud,
    'folder': Icons.folder,
    'folder_shared': Icons.folder_shared,

    // Hardware
    'computer': Icons.computer,
    'smartphone': Icons.smartphone,
    'toys': Icons.toys,

    // Image
    'audiotrack': Icons.audiotrack,
    'camera': Icons.camera,
    'collections': Icons.collections,
    'color_lens': Icons.color_lens,
    'landscape': Icons.landscape,
    'photo': Icons.photo,
    'style': Icons.style,

    // Places
    'ac_unit': Icons.ac_unit,
    'casino': Icons.casino,
    'fitness_center': Icons.fitness_center,

    // Social
    'cake': Icons.cake,
    'group': Icons.group,
    'notifications': Icons.notifications,
    'person': Icons.person,
    'public': Icons.public,
    'school': Icons.school,
    'share': Icons.share,
  };

  static const Map<String, Color> colors = {
    'grey': Color.fromRGBO(118, 118, 118, 1),
    'brown': Color.fromRGBO(165, 103, 63, 1),
    'blue': Color.fromRGBO(33, 133, 208, 1),
    'green': Color.fromRGBO(33, 186, 69, 1),
    'orange': Color.fromRGBO(242, 113, 28, 1),
    'pink': Color.fromRGBO(224, 57, 151, 1),
    'purple': Color.fromRGBO(163, 51, 200, 1),
    'violet': Color.fromRGBO(88, 41, 187, 1),
    'red': Color.fromRGBO(219, 40, 40, 1),
  };

  static bool hasIcon(IconData icon) {
    return icons.containsValue(icon);
  }

  static String getIconKey(IconData icon) {
    String result;
    result = icons.keys.firstWhere((String key) {
      return icons[key] == icon;
    });

    return result;
  }

  static bool hasColor(Color color) {
    return colors.containsValue(colors);
  }

  static getColorKey(Color color) {
    String result;
    result = colors.keys.firstWhere((String key) {
      return colors[key] == color;
    });

    return result;
  }
}
