
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220829_01_rownum.sql
    
////////////////////////////////////////////////////////////////////////////////

● [모조칼럼]

   ＃ Oracle DBMS에서 제공해 준다.
   ＃ 오라클에서 제공하는 행 번호 하나씩 부여시켜주는 서비스임
   
   - rownum 행번호
     select uname, address, rownum from tb_student; --1,2,3,4 ...
     
   - rowid 행의 주소값
     select uname, address, rowid from tb_student;  --AAASVrAABAAAaBxAAA

   -- ＃ 댓글 공감순, 최신순(desc), 답글순, 과거순 = order by 로 정렬해주면 됨.
   -- ＃ 댓글 수가 많으면 페이징작업을 통해 정리해주는게 보편적이다.
    
////////////////////////////////////////////////////////////////////////////////


● [rownum]

-- 줄번호
select hakno, uname, rownum from tb_student;


-- 줄번호에 별칭 무여하기
select hakno, uname, rownum as rnum from tb_student;


-- 줄번호가 먼저 부여되고 정렬된다.
select hakno, uname, rownum as rnum from tb_student order by uname; -- 이전에 부여했던 행번호도 같이 바뀐다.


-- 줄번호 1~3사이 조회
select hakno, uname, rownum from tb_student where rownum>=1 and rownum<=3;


-- 줄번호 4~6사이 조회 (조회안됨)
select hakno, uname, rownum from tb_student where rownum>=4 and rownum<=6;
 
 
////////////////////////////////////////////////////////////////////////////////


● [rownum을 활용한 페이징]

   ＃ rownum은 모조칼럼이므로 조건절에 직접 사용하지 말고, 
      실제 칼럼으로 인식 후 사용할 것을 추천함.
   ＃ rownum 칼럼은 셀프조인 후에 줄번호 추가하고 조건절에 활용한다.
   
   
문) 줄번호(rownum)을 이용해서 줄번호 4~6 조회

-- 1) 이름순으로 조회 (줄번호까지 같이 정렬)
select uname, hakno, address, rownum 
from tb_student 
order by uname;

-- rownum 무시하고 select uname, hakno, address, 이부분을 먼저 정렬시킨다.
-- AA 테이블 만들고 그 후에 rownum을 추가한다.


-- 2) 1번의 결과를 셀프조인(AA테이블)하고 줄번호를 추가하시오.
select uname, hakno, address, rownum as rnum
from (
        select uname, hakno, address
        from tb_student 
        order by uname
       ) AA;

-- 이 논리적 테이블을 확실히 BB 테이블로 만들고 where 조건을 추가한다.


-- 3) 2번의 결과를 BB테이블로 만들고, 줄번호 4~6행 조회
select uname, hakno, address, rnum
from (
        select uname, hakno, address, rownum as rnum
        from (
                select uname, hakno, address
                from tb_student 
                order by uname
              ) AA
      )BB 
where rnum>=4 and rnum<=6;
-- where rnum between 4 and 6;


-- 4) 3번의 결과에서 테이블 별칭 (AA, BB) 생략하기
select *       -- 칼럼명 AA,BB에 노출이 되어있기 때문에 여기선 별표처리 가능
from (
        select uname, hakno, address, rownum as rnum    -- 여기에 칼럼명 노출
        from (
                select uname, hakno, address            -- 여기에 칼럼명 노출
                from tb_student 
                order by uname
              )
      )
where rnum>=4 and rnum<=6;




       

   
   
   
   
   
















