import 'dart:io';

// void main() {
//   performTask();
// }
//
// Future<void> performTask() async {
//   task1();
//   String task2Result = await task2();
//   task3(task2Result);
// }
//
// void task1() {
//   String result = "task 1 data";
//   print("Task 1 complete");
// }
//
// Future<String> task2()  async{
//   Duration threeSeconds =  const Duration(seconds: 11);
//   String? result ;
//   await Future.delayed(threeSeconds, () {
//     result = "2";
//     print("Task 2 complete");
//   });
//
// return result!;
// }
//
// void task3(String t2) {
//   // String result = "task 3 data";
//   print("Task 3 complete with $t2");
//   print("t1");
//   print('t2');
// }

main() {
  String myString = 'abc';
  double? result;
  try{
    double myStringAsDouble = double.parse(myString);

    result = myStringAsDouble+ 10;
  }catch(e){
    print(e);
  }

  print(result);
}
