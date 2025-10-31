//자료형 : string, number, boolean, function, object(array), undefined

var variable;
console.log('1. variable 타입 :', typeof(variable), ' - 값 :', variable);
variable = '이름은 "홍길동"입니다';
console.log('2. variable 타입 :', typeof(variable), ' - 값 :', variable);
variable = -31515515144511.6151;
console.log('3. variable 타입 :', typeof(variable), ' - 값 :', variable);
variable = false;
console.log('4. variable 타입 :', typeof(variable), ' - 값 :', variable);
variable = function(){
    alert('함수 속');
};
console.log('5. variable 타입 :', typeof(variable), ' - 값 :', variable);
variable = {'name':'홍길동', 'age':20}; // 객체
console.log('6. variable 타입 :', typeof(variable), ' - 값 :', variable.name, variable.age);
variable = ['홍길동', 10, function(){}, true, {'name':'홍길동'}, [1,2,3]]; // 배열
//          {0:'홍길동', 1:10 ~} 이런식으로 해석함
console.log('7. variable 타입 :', typeof(variable), ' - 값 :', variable);