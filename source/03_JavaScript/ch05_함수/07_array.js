// array함수 : 가변인자함수(파이썬 튜플 매개변수로 구현)
// 매개변수가 0개 : length가 0인 배열 return
// 매개변수가 1개 : length가 매개변수인만큼의 크기인 배열 return
// 매개변수가 2개 이상 : 매개변수로 배열을 생성 return

function array(){ // arguments(매개변수 배열) : 매개변수의 내용
    let result = [];
    if(arguments.length==1){
        // result를 arguments[0] 만큼의 크기인 배열로 : result.push(null)를 arguments[0]번
        // for(let cnt=1 ; cnt<=arguments[0] ; cnt++){
        //     result.push(null);
        // } 이건 강사님이 교안을 그대로 따라한건데 Array함수와는 조금 다르다보니 아래로 변경한것

        result.length = arguments[0];
    }else if(arguments.length >= 2){
        // result를 arguments 내용의 배열로 : result.push(arguments[0~끝까지])
        // for(let idx=0 ; idx<arguments.length ; idx++){
        //     result.push(arguments[idx]);
        // } 기본 for문

        // for(let idx in arguments){
        //     result.push(arguments[idx]);
        // } for-in문

        for(let data of arguments){
            result.push(data);
        } // for-of문

        // argument.forEach는 불가
    }
    return result;
}

var arr1 = array(5);
var arr2 = array();
var arr3 = Array(5);
console.log(arr1);
console.log(arr2);
console.log(arr3);

var arr4 = array(1,2,3,4,55);
console.log(arr4);