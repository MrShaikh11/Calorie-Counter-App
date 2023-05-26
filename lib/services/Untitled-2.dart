//  child: FutureBuilder(
//                 future: obj.getAddedData(),
//                 builder: (context, snapshot) {
//             logu.log('message');
//             var myList = snapshot.data;
//             logu.log(myList.toString());
//             int total = 0;
//             total += int.parse(item.cal)
//             print(total.runtimeType);
//             myList?.forEach(
//                 (item) => total += int.parse(item.cal.toString()));
//             var tot = obj.getTotalPrice();
//             logu.log(tot.toString());
//                     if (snapshot.hasData) {
//                       return Center(child: Text('Calories Consumed: $tot'));
//                     } else {
//                       return const Center(
//                         child:
//                             // Text('Hello')
//                             CircularProgressIndicator(),
//                       );
//                     }
//                   }),
//             ),
//             Container(
//               color: const Color(0xFF674AEF),
//               height: 400,
//               width: MediaQuery.of(context).size.width,
//               margin: const EdgeInsets.all(10),

//             child: Text('${obj.getTotalPrice}'),

//             child: FutureBuilder(
//                 future: obj.getAddedData(),
//                 builder: (context, snapshot) {
//                   logu.log('message');
//                   var myList = snapshot.data;
//                   logu.log(myList.toString());
//                   int total = 0;
//                   // total += int.parse(item.cal)
//                   // print(total.runtimeType);
//                   myList?.forEach(
//                       (item) => total += int.parse(item.cal.toString()));
//                   if (snapshot.hasData) {
//                     return Text(total.toString());
//                   } else {
//                     return const Center(
//                       child:
//                           // Text('Hello')
//                           CircularProgressIndicator(),
//                     );
//                   }
//                 }),