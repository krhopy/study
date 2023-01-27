
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220819_03where.sql
    
////////////////////////////////////////////////////////////////////////////////

● [where 조건절]
   - 조건을 만족하는 행들에 대해서 
   - 조건에 만족하는 레코드(행)만 대상으로 조회(select), 수정(update), 삭제(delete)하기 위해서
   - ex) 학생들 중 남여 구분

  - 연산자
   * 비교연산자 : >  >=  <  <= 
                 != <> 같지않다
                  = 같다
                  
   * 논리연산자 : 그리고 and,  또는 or, 부정연산자 not
     예)국어점수 50~59 : kor>=50 and  kor<=59

   * between A and B : A에서 부터 B사이
    kor between 50 and 59

   * in 연산자
     예)uname='홍길동' or uname='무궁화'
         uname in ('홍길동','무궁화')

   * like연산자 : 비슷한 유형 %
     예) '홍'씨성을 검색 : uname like '홍%'
          '홍'으로 끝나는 검색 : uname like '%홍'
          '홍'글자 있는것 검색 : uname like '%홍%'
     예) 반드시 두글자 중에서 홍으로 시작 : 홍_

   * NULL값
     예) aver=null(틀림)
         aver is null
         aver is not null

////////////////////////////////////////////////////////////////////////////////

select * from sungjuk;

--문1) 국어점수가 50점이상 행을 조회하시오
select uname, kor -- 3. 조회하고 싶은 칼럼을 출력해주세요.
from sungjuk    -- 1. 어느 테이블에서
where kor>=50;  -- 2. 원하는 것만 걸러내는 조건
-- 코딩해석순서: from 성적 테이블에서 → where 국어 평균 50이상인 값을 → select 이름과 국어점수를 조회해라.




--문2) 영어 점수가 50점미만 행을 조회하시오
select uname, eng
from sungjuk
where eng<50;




--문3) 이름이 '대한민국' 행을 조회(출력)하시오
select uname, kor, eng, mat
from sungjuk
where uname='대한민국'; -- 좌우가 서로 같다




--문4) 이름이 '대한민국' 아닌 행을 조회하시오
select uname, kor, eng, mat
from sungjuk
where uname != '대한민국'; -- != : 좌우가 서로 같지 않다

select uname, kor, eng, mat
from sungjuk
where uname <> '대한민국'; -- <> : 좌우가 서로 같지 않다





--문5) 국어, 영어, 수학 세과목의 점수가 모두 90이상 행을 조회하시오
select uname, kor, eng, mat -- 어떤 칼럼을 조회할 것인지 
from sungjuk
where kor>=90 and eng>=90 and mat>=90; -- 커서로 지정해준다고 생각하면 됨






--문6) 국어, 영어, 수학 중에서 한과목이라도 40미만 행을 조회하시오
select uname, kor, eng, mat
from sungjuk
where kor<40 or eng<40 or mat<40;






--문7) 국어점수가 80 ~ 89점 사이 행을 조회하시오
select uname, kor
from sungjuk
where kor>=80 and kor<=89;

select uname, kor
from sungjuk
where kor between 80 and 89;






--문8) 이름이 '무궁화', '봉선화'를 조회하시오
select uname, kor, eng, mat
from sungjuk
where uname='무궁화' or uname='봉선화';

////////////////////////////////////////////////////////////////////////////////

● [between A and B] : A에서 부터 B사이
   예)국어점수 50~59 : kor between 50 and 59

-- 국어점수가 80 ~ 89점 사이 행을 조회하시오
select uname, kor
from sungjuk
where kor between 80 and 89;

////////////////////////////////////////////////////////////////////////////////

● [in] 연산자 : 목록에서 찾기
   예)uname='홍길동' or uname='무궁화'
      uname in ('홍길동','무궁화')

-- 이름이 '무궁화','봉선화' 를 조회하시오
select uname
from sungjuk
where uname in ('무궁화','봉선화');


-- 국어점수 10, 30, 50점을 조회하시오
select uname, kor
from sungjuk
where kor in (10, 30, 50);


////////////////////////////////////////////////////////////////////////////////

-- 문9) 국, 영, 수 모두 100점 아닌 행을 조회하시오
select uname, kor, eng, mat
from sungjuk
where kor!=100 and eng!=100 and mat!=100;

select uname, kor, eng, mat
from sungjuk
where not (kor=100 and eng=100 and mat=100);

////////////////////////////////////////////////////////////////////////////////


● [like 연산자] : 비슷한 유형 %
    - 문자열 데이터에서 비슷한 유형을 검색할 때
    - % 글자갯수와 상관없음
    - _ 글자개수까지 일치해야함
    
   예) '홍'씨성을 검색 : uname like '홍%'
       '홍'으로 끝나는 검색 : uname like '%홍'
       '홍'글자 있는것 검색 : uname like '%홍%'
   예) 반드시 두글자 중에서 홍으로 시작 : 홍_
   
select uname
from sungjuk
where uname='대한민국';

-- [ = ] 똑같은 것
-- [ like ] 비슷한 것


--문1) 이름에서 '홍'으로 시작하는 이름을 조회하시오
select uname
from sungjuk
where uname like '홍%';


--문2) 이름에서 '화'로 끝나는 이름을 조회하시오
select uname
from sungjuk
where uname like '%화';


--문3) 이름에 '나'글자 있는 이름을 조회하시오
select uname
from sungjuk
where uname like '%나%';


--문4) 두글자 이름에서 '화'로 끝나는 이름을 조회하시오
select uname
from sungjuk
where uname like '_화';


--문5) 이름 세글자 중에서 가운데 글자가 '나' 있는 행을 조회하시오
select uname
from sungjuk
where uname like '_나_';


--문6) 제목+내용을 선택하고 검색어가 '파스타'일때
where subject like %파스타% or content like %파스타%;


--문7) 국어 점수가 50점 이상인 행에 대해서 총점(tot)과 평균(aver)을 구하시오
select * from sungjuk where kor>=50;

update sungjuk 
set tot=kor+eng+mat, aver=(kor+eng+mat)/3
where kor>=50;

select * from sungjuk;

////////////////////////////////////////////////////////////////////////////////


● [NULL] - 비어있는 값
-- 총점의 개수를 구하시오
select count(tot) from sungjuk; --null값은 카운트 되지 않음


-- 총점에 NULL이 있는 행의 개수를 구하시오
select count(*) 
from sungjuk 
where tot=null; -- null값 확인 못함. 오류!! 0

-- null 값 확인하려면 is 연산자 써야함
select count(*)
from sungjuk
where tot is null; --5
    
-- 평균에 비어있지 않은 행의 개수를 구하시오 (null이 아닌 값)
select count(*)
from sungjuk
where tot is not null;


--문8) 비어있는 총점과 평균을 모두 구하시오
update sungjuk 
set tot=kor+eng+mat, aver=(kor+eng+mat)/3
where tot is null or aver is null;

select * from sungjuk;







