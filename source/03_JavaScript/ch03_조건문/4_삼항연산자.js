// 조건식이 간단할때는 삼항연산자가 보기 편하고 길어지면 if문이 가독성이 좋음
let num1 = 25;
let num2 = 21;

let difference = (num1>num2) ? num1-num2 : num2-num1;
// let difference; // 차이값 저장할 예정
// if (num1>num2){
//    difference = num1 - num2;
// }else{
//    difference = num2 - num1;
// }
// console.log('두수의 차이는', difference);

msg = (num1>num2) ? '첫번째 수가' + difference + '만큼 더 크다' : (num2>num1) ? '두번째 수가' + difference + '만큼 더 크다' :  '두 수는 같다'
// if(num1>num2){
//     msg = '첫번째 수가' + difference + '만큼 더 크다';
// }else if(num2>num1){
//     msg = '두번째 수가' + difference + '만큼 더 크다';
// }else{
//     msg = '두 수는 같다';
// }
console.log(msg);