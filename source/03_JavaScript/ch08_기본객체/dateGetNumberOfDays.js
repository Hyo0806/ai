// dateGetNumberOfDays.js
//now.getNumberOfDays(openday) => now는 this / openday는 that이 될거임

Date.prototype.getNumberOfDays = function(that){ // 이 함수를 작성할때는 뭐가 더 먼저인 시점인지 모름
    // let intervalMilisec = (this>that)? this.getTime() - that.getTime() : that.getTime() - this.getTime(); 삼항연산자 너무 길어서
    let intervalMilisec = Math.abs(this.getTime() - that.getTime()); // abs : 절대값을 리턴
    let day = Math.floor(intervalMilisec/(1000*60*60*24));
    return day;
};

// let now = new Date();
// let limitday = new Date(2026, 1, 12, 18, 0, 0); // 26년 2월 12일

// console.log(now.getNumberOfDays(limitday), '일 남음');
// console.log(limitday.getNumberOfDays(now), '일 남음');
// console.log(now.getNumberOfDays(now), '일 남음');