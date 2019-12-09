part of '../project_detail_page.dart';

// class _IconField extends StatelessWidget {
//   /// Create a _IconField widget.
//   _IconField({
//     Key key,
//     @required this.onChanged,
//   }): super(key: key);

//   final ValueChanged<Icons

//   /// Build the _IconField widget.
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       child: Container(
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white.withOpacity(0.5),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//         child: Icon(Icons.folder, color: Colors.white),
//       ),
//       onTap: () {
//         showModalBottomSheet(
//           context: context,
//           builder: (BuildContext context) {
//             return Container(
//               child: IconPicker(
//                 icons: DataSupport.icons.values.toList(),
//                 current: Icons.folder,
//                 onChanged: (IconData newIcon) {
//                   print(newIcon);
//                 },
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
