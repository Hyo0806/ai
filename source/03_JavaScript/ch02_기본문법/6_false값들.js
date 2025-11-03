// false로 해석되는 값 : 0, '', NaN, null, undefined
// []빈배열은 true. 파이썬에서 빈배열,빈리스트는 False였음
// ctrl + j (터미널창) node 파일명

var i; // 파이썬은 변수만 선언할 수 없음. var같은 것이 없기때문에. 그러나 자바스크립트는 변수선언이 있어서 가능
console.log(Boolean(i));
console.log(Boolean(0));
console.log(Boolean(NaN));
console.log(Boolean(Number('a')));
console.log(Boolean(''));
console.log(Boolean(null));
console.log();
console.log('0==false의 결과 :', 0==false);
console.log('0===false의 결과 :', 0===false);