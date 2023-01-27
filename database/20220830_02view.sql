
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220830_02view.sql
    
////////////////////////////////////////////////////////////////////////////////

● [뷰 View]

＃ 권한을 부여받아야만 사용할 수 있음

1) 정의
  - 테이블처럼 사용하는 뷰
  - 테이블에 대한 가상의 테이블로써 테이블처럼 직접 데이터를 소유하지 않고
    검색시에 이용할 수 있도록 정보를 담고 있는 객체 테이블 정보의 부분집합

   ※ 테이블처럼 사용할 수 있는 가상의 테이블 / 일시적인 테이블 (as 처럼)
   
   
2) 사용목적
  - 테이블에 대한 보안기능을 설정해야 하는 경우
  - 복잡하고, 자주 사용하는 질의 SQL문을 보다 쉽고 간단하게 사용해야 하는 경우


3) java202207 계정에 대해서 뷰 생성 권한 부여
  - grant create view to java202207


4) 뷰 생성 및 수정 형식
   create or replace view 뷰이름   -> replace : 이미 존재하는 뷰의 내요을 수정함
   as [SQL문]
    
    
   ※ 테이블이 없으면 create 가 되고, 이미 생성된 테이블이 있으면 replace 로 적용된다.

5) 뷰 삭제하기
   drop view 뷰이름


////////////////////////////////////////////////////////////////////////////////


-- 테이블, 뷰 목록 확인
select * from tab;                        --모든 객체 종류 확인
select * from tab where tabtype='TABLE';  -- 테이블 목록
select * from tab where tabtype='VIEW';   -- 뷰 목록


-- sungjuk 테이블 목록 확인
select * from sungjuk;


-- 주소가 서울, 제주지역의 이름, 국, 영, 수, 주소를 조회하시오
select uname, kor, eng, mat, addr
from sungjuk
where addr in ('Seoul', 'Jeju');

    ※ 논리적 형태의 테이블을 뷰를 이용해 저장해놓고 가져다 쓸 수 있다. 


-- 뷰생성 (두번째부터는 수정)
-- 형식) create or replace view 뷰이름 as 실제로실행할SQL문

create or replace view test1_view
as  
    select uname, kor, eng, mat, addr
    from sungjuk
    where addr in ('Seoul', 'Jeju');


-- 목록에서 뷰 조회
select * from tab where tabtype='VIEW';

-- 뷰 삭제
drop view test1_view;

-- 생성된 뷰는 테이블처럼 사용 가능하다
select * from test1_view;

-- 데이터사전(user_views테이블)에서 뷰의 세부 정보 확인
select * from user_views;
select text from user_views where view_name='TEST1_VIEW';


-- test2_view 생성 (alias별칭)
create or replace view test2_view
as  
    select uname as 이름, kor as 국어, eng as 영어, mat as 수학, addr as 주소
    from sungjuk
    where addr in ('Seoul', 'Jeju');


select * from test2_view;

////////////////////////////////////////////////////////////////////////////////

문) 수강신청한 학생들의 학번, 총학점을 뷰로 생성하시오 (test3_view)
    g1001   14학점
    g1002   8학점
    g1005   12학점
    g1006   3학점
    
    
create or replace view test3_view
as
    select SU.hakno as 학번, sum(GW.ghakjum) || '학점' as 총학점
    from tb_sugang SU join tb_gwamok GW
    on SU.gcode=GW.gcode
    group by SU.hakno 
    order by SU.hakno;
    
select * from test3_view;

drop view test3_view;


-- 3) 2)의 뷰와 학생테이블을 조인해서 학번, 이름, 총학점 출력하기
select tb_student.uname, test3_view.*
from tb_student join test3_view
on tb_student.hakno = test3_view.학번
order by tb_student.hakno;

////////////////////////////////////////////////////////////////////////////////



