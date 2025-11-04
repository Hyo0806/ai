function sumAll(){
    // 매개변수가 없으면 -999 return / 매개변수가 있으면 매개변수 합 return
    let resultSum = 0;
    if(arguments.length==0){
        return -999;
    }else{
        for(let data of arguments){
            resultSum += data;
        }
    }
    return resultSum;
}

// console.log(sumAll());
// console.log(sumAll(1,2,3,4,5));
// test 주석처리 안하면 파이썬과 달리 다 나옴(f12키 할때 console탭에 다 나옴)