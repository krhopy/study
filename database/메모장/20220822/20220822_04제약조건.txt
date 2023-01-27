
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220822_04제약조건.sql
    
////////////////////////////////////////////////////////////////////////////////

● [자료형]
   - 데이터베이스는 비싸기 때문에 null값을 많이 두지않고 유용하게 사용하는 것이 중요하다.
   
   1) 문자형 (표준)
      - 가변형(쓰고싶은 만큼만)
        varchar(5)  : 'SKY'   (3) 나머지(2)칸 버리는 것.
        ex) 로그인, 비밀번호, 이름, 주소, ~~~
        
      - 고정형(정해져있음)
        char(5)     : 'SKY  ' (5) 나머지(2)칸도 합쳐진다.
        --> 검색 속도는 고정형이 빠름 
        ex) 주민등록번호, 우편번호, 계좌번호, ~~~
      
   2) 숫자형
      - int 정수형 
   
   
   3) 날짜형
      - 년월일시분초
      - 구분기호 - 와 /  기호를 사용한다.
      - 수동 입력시 문자열타입으로 작성해야한다.
      - date
      
////////////////////////////////////////////////////////////////////////////////

● [테이블 제약조건]

   1) primary key
      - 기본키, 유일성 (오로지 하나)
      - 많은 데이터양 속에서 원하는 데이터 하나를 콕 찝어서 조회할 수 있다.
      - 테이블당 primary key가 반드시 1개는 존재해야한다.
      - 보통 번호로 지정
      - 중복을 허용하지 않는다.
      - 기본 not null
      - null값 허용하지 않음. (빈 값을 허용하지 않음, 반드시 입력해야 함)
      
      where 조건절에 걸릴 수 있는 대표적인 칼럼을 강제할 수 있다.
      예) 주민번호, 핸드폰번호, 계좌번호, 아이디, 이메일, ~~~
      
      
   2) not null
      - 빈값을 허용하지 않음.
      

   3) check
      - 입력할 값을 특정 범위로 제한하는 조건
      

   4) default
      - 사용자가 값을 입력하지 않으면 해당 칼럼이 정의한 기본값을 자동으로 입력해준다.
      

   5) unique
      - 중복을 허용하지 않음
      - null 값을 한 번 허용
      

   6) foreign key
      - 외래키
      - 테이블 조인하는 경우 부모와 자식 관계를 설정
      - 부모 테이블에 없는 것은 자식테이블에도 없어야함.
      - 테이블 여러개가 있을 때 조인하는 것. 합치는 것.


////////////////////////////////////////////////////////////////////////////////

-- sungjuk테이블 삭제
drop table sungjuk;

-- sungjuk 테이블 생성
create table sungjuk(
     sno    int        primary key                      --기본키(유일성)
    ,uname varchar(50) not null     
    ,kor   int         check(kor between 0 and 100)     -- check: 0에서 100점까지만 범위를 주고싶을 때
    ,eng   int         check(eng between 0 and 100)     -- 영어점수 0~100사이만 입력가능
    ,mat   int         check(mat between 0 and 100)     -- 수학점수 0~100사이만 입력가능
    ,addr  varchar(20) check(addr in('Seoul', 'Jeju', 'Busan', 'Suwon')) 
                       --서울, 제주, 부산, 수원만 입력할 수 있도록 제한한 것.
    ,tot   int         default 0
    ,aver  int         default 0                        -- 합계, 평균 값을 넣지 않으면 기본값 0으로 준다.
    ,wdate date        default sysdate                  -- 날짜에 값을 넣지 않으면 함수로 현재날짜를 입력한다.
);

////////////////////////////////////////////////////////////////////////////////

● [테이블 제약조건 에러 메세지]

-- primary key 제약조건
insert into sungjuk(sno, uname) 
values(1, '홍길동'); 
    -- 2번 실행하면 에러. ORA-00001: 무결성 제약 조건. 결점이 없다.
    -- sno 칼럼은 primary key인데 1이라는 값이 또 들어가서 에러가 남.


-- not null 제약조건
insert into sungjuk(sno) 
values(1); 
    -- ORA-01400: NULL을 ("SYSTEM"."SUNGJUK"."UNAME") 안에 삽입할 수 없습니다
    -- uname 칼럼에 반드시 값을 입력해야 함.


-- check 제약조건 (1) kor, eng, mat
insert into sungjuk(sno, uname, kor, eng, mat)
values(1,'홍길동', -10, 20, 300);
    -- ORA-02290: 체크 제약조건(SYSTEM.SYS_C008312)이 위배되었습니다
    -- 국영수 점수는 0~100 사이만 가능 / check(kor between 0 and 100)


-- check 제약조건 (2) addr
insert into sungjuk(sno, uname, kor, eng, mat, addr)
values(1,'홍길동', 10, 20, 30, 'Incheon');
    -- ORA-02290: 체크 제약조건(SYSTEM.SYS_C008313)이 위배되었습니다
    -- check(addr in('Seoul', 'Jeju', 'Busan', 'Suwon')) : 목록에 인천 없음


-- default 제약조건
insert into sungjuk(sno, uname, kor, eng, mat, addr)
values(2,'무궁화', 10, 20, 30, 'Seoul');
    -- tot과 aver는 0입력, wdate는 현재날짜가 입력됨.

select * from sungjuk;



-- 칼럼과 값 개수 오류 (일치해야함.)
insert into sungjuk(sno, uname, kor, eng, mat) -- 칼럼 5개
values(2,'무궁화', 10, 20, 30, 'Seoul');        -- 값 6개
    -- SQL 오류: ORA-00913: 값의 수가 너무 많습니다





















