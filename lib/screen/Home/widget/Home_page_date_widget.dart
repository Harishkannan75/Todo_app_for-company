// import 'package:flutter/material.dart';

// class DateItem extends StatelessWidget {
//   final String dayInitial;
//   final String dayNumber;
//   final bool isSelected;

//   DateItem(
//       {required this.dayInitial,
//       required this.dayNumber,
//       required this.isSelected});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           height: 42.0,
//           width: 42.0,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             color: isSelected ? Colors.orange : Colors.transparent,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Text(
//             dayInitial,
//             style: TextStyle(
//               fontSize: 24.0,
//               color: isSelected ? Colors.white : Colors.black54,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         const SizedBox(height: 8.0),
//         Text(
//           dayNumber,
//           style: const TextStyle(
//             fontSize: 16.0,
//             color: Colors.black54,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8.0),
//         Container(
//           height: 2.0,
//           width: 28.0,
//           color: isSelected ? Colors.orange : Colors.transparent,
//         ),
//       ],
//     );
//   }
// }
