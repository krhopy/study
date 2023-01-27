
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220819_02SQL기초.sql
    
//////////////////////////////////////////////////////////////////////////////

[sungjuk 테이블 삭제]
drop table sungjuk;


[sungjuk 테이블 생성]
create table sungjuk(
    uname varchar(50) not null     -- 오라클db는 varchar2 로 쓴다 
                                   -- not null: 빈 값 허용X, 반드시 값을 넣어야한다.
                                   -- 영문자 50글자 이내에서 입력
                                   -- 한글 16글자 이내 입력
    ,kor  int         not null
    ,eng  int         not null
    ,mat  int         not null
    ,tot  int         null         -- 빈값 허용
    ,aver int                      -- null 생략가능
);


[샘플 데이터 행추가]
insert into sungjuk(uname,kor,eng,mat) values ('홍길동',  70,85,100);
insert into sungjuk(uname,kor,eng,mat) values ('무궁화',  30,30,40);
insert into sungjuk(uname,kor,eng,mat) values ('진달래',  90,90,20);
insert into sungjuk(uname,kor,eng,mat) values ('개나리',  100,60,30);
insert into sungjuk(uname,kor,eng,mat) values ('라일락',  30,80,40);
insert into sungjuk(uname,kor,eng,mat) values ('봉선화',  80,80,20);
insert into sungjuk(uname,kor,eng,mat) values ('대한민국',10,65,35);
insert into sungjuk(uname,kor,eng,mat) values ('해바라기',30,80,40);
insert into sungjuk(uname,kor,eng,mat) values ('나팔꽃',  30,80,20);
insert into sungjuk(uname,kor,eng,mat) values ('대한민국',100,100,100);

//////////////////////////////////////////////////////////////////////////////


[전체 레코드(행) 조회]
select uname, kor, eng, mat, tot, aver from sungjuk;

-- 행 조회에서 순서는 전혀 관계없다. 중간에 값을 지우고 insert하면 그 공간안에 들어갈 수 있다.
-- 정렬한다고 생각하기.


[전체 행개수 조회]
select count(*) from sungjuk;
-- 10개의 행이 있다고 출력됨.


[select 조회 및 검색]
select kor, eng, mat from sungjuk;
select tot, aver from sungjuk;
select * from sungjuk;  --전체 모든 칼럼 조회
                        -- * 만능문자
         

[as]  -- 칼럼명 일시적으로 변경 가능하다.(한글은 실무에서 절대 불가능)
select kor as korea, eng as english, mat as mate 
from sungjuk;

-- as는 생략가능
select kor korea, eng english, mat mate 
from sungjuk;

select uname as 이름, kor as 국어, eng as 영어, mat as 수학, tot 총점, aver 평균 
from sungjuk; --임시 한글 칼럼명은 일시적으로 분석해야 하는 경우만 추천!!



[count 함수] - 행 개수 조회
select count(uname) from sungjuk;
-- sungjuk 테이블에 있는 uname이 몇 개인지? 조회

select count(kor) from sungjuk;
-- sungjuk 테이블에 있는 국어점수 몇 개인지? 조회
-- 이것도 테이블임.

select count(eng) as cnt_eng from sungjuk;
-- create table은 물리적형태의 테이블이지만 이렇게 조회할 때도 테이블이 생성된다. 이런건 논리적형태의 테이블이라고 한다.

select count(mat) 수학갯수 from sungjuk; --임시 칼럼명으로 한글 가능

--null 값은 카운트하지 않는다
select count(tot) from sungjuk;  --0
select count(aver) from sungjuk; --0


-- sungjuk 테이블의 전체 행의 갯수
select count(*) from sungjuk;
select count(*) as 전체행갯수 from sungjuk;
select count(*) 전체행갯수 from sungjuk;
//////////////////////////////////////////////////////////////////////////////



[명령어 완료와 취소]
- insert, update, delete 명령어를 사용하는 경우, 명령어 취소와 명령어 완료를 선택할 수 있다.
- commit     : 명령어 완료
- rollback   : 명령어 취소   --다시 되돌리는 것

--※ SQL Developer툴에서 자동커밋 설정해 놓을 수 있다
   --[도구 → 환경설정 → 데이터베이스 → 객체뷰어 → 자동커밋설정]
   
-- ※ 행 번호 자동 표시
   -- 도구 - 환경설정 - 코드편집기 - 행여백 - 행번호표시


delete from sungjuk;   -- 전체 레코드 삭제
select * from sungjuk; -- 성적 테이블 전체 조회

rollback; -- 명령어 취소
commit;   -- 명령어 완료




