// 자바스크립트에 클래스가 없을때 생성자함수로 만들었다. 
class Student{
    constructor(name, kor, mat, eng, sci){
        this.name = name;
        this.kor = kor;
        this.mat = mat;
        this.eng = eng;
        this.sci = sci;
    }
    // class안에는 function쓰면 안됨
    getSum(){return this.kor + this.mat + this.eng + this.sci;}
    getAvg(){return this.getSum()/4;}
    toString(){
        return 'name : ' + this.name + 
            'kor : ' + this.kor +
            'mat : ' + this.mat +
            'eng : ' + this.eng +
            'sci : ' + this.sci +
            'sum : ' + this.getSum() +
            'avg : ' + this.getAvg();
    }
}

let hong = new Student('홍길동', 99, 90, 94, 98);
console.log(`hong = ${hong}`);
console.log(hong);