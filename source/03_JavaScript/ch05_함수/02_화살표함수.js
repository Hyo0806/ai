let funVar = function(){
    console.log('1. 일반 함수(함수표현식 문법 format)');
    console.log('여러줄이 있어도 문법이 하나');
};
funVar();

// 명령어 블록에 명령어가 1줄 / 여러줄 있을 때/ return한줄짜리는 return을 생략 
// 매개변수 1개 / 그외
funVar = () => {
    console.log('2. 매개변수 없는 2줄짜리 화살표 함수');
    console.log('여러줄이 있어도 문법이 하나');
};
funVar();

funVar = a => {
    console.log('3. 매개변수가 1개인(매개변수 1개일때는 괄호생략) 2줄짜리 화살표 함수');
    console.log('a='+a);    
};
funVar(10);

funVar = a => console.log('4. 매개변수가 1개인(매개변수 1개일때는 괄호생략) 1줄짜리 화살표 함수 a=', a);
funVar(20);

funVar = function(a){
    return a*a;
}

funVar = a => a*a;
console.log('5. 매개변수가 1개인, return문 1줄 있는 화살표 함수 호출결과 :', funVar(5));

funVar = function(a, b){
    return a*10 + b;
};
funVar = (a,b) => a*10 + b;
console.log('6. 매개변수가 2개인, return문 1줄 있는 화살표 함수 호출결과 :', funVar(5,4));

