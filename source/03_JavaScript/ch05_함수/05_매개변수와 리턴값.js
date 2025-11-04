function pow(x,y){
    let result = 1;
    for(let cnt=1 ; cnt<=y ; cnt++){
        result *= x; // result = result*x
    }
    return result; // return이 없으면 undefinded로 받음
}

// 매개변수가 선언된 것과 같은 경우 : 기본
console.log(pow(5,3));

// 매개변수가 선언된 것보다 많을 경우 : 뒷부분 무시
console.log(pow(5,2,1,10));

// 매개변수가 선언된것보다 적을 경우 : 전달되지 않은 매개변수는 undefinded
// 아래 부분을 실행하지 않고 첫줄 result만 나온것
console.log(pow(5));
console.log(pow());