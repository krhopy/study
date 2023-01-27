
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220823_03자료형.sql
    
////////////////////////////////////////////////////////////////////////////////

● [오라클 DB 자료형]

   1. 숫자형
   - number      전체자릿수(38)까지 표현. 표준SQL문의 int형과 동일하지만, 소수점 표현도 가능함
   - number(3)   전체자릿수(3) 최소값 -999 ~ 최대값 999
                 -- 세칸 허용
   - number(6,2) 전체 자릿수(6)이고, 6칸내에서 소수점 자릿수(2)
                 -- 실수값 표현할 때
   
   2. 문자형
   - char        고정형 / 최대길이 2000바이트
   - varchar2    가변형 / 최대길이 4000바이트 
   - long        최대 2GB까지
   
   3. 이진파일 (할 수는 있지만 하면 안된다, 파일명만 기억하고 파일은 하드디스크에 지정.)
   - blob
   - 주의사항 : 파일을 데이터베이스에 저장하지 않음
   
   4. 날짜형
   - date       년월일시분초
   - timestamp  기본날짜형을 확장한 자료형

////////////////////////////////////////////////////////////////////////////////

● [Maria DB 자료형]

   1. 숫자형 : tinyint, smallint, mediumint, int, bigint, float, double, boolean
   
              TINYINT(자리수) 
              SMALLINT(자리수)
              MEDIUMINT(자리수)
              INT(자리수)
              BIGINT(자리수)
              FLOAT(전체자리수, 소수점이하자리수)
              DOUBLE(전체자리수, 소수점이하자리수)
              
       -- int형을 기준으로 크기가 나누어짐
       
    
   2. 문자형 :  char, varchar, tinytext, text, mediumtext, longtext
   
               CHAR(글자수)    => 255자까지
               VARCHAR(글자수) => 255자까지
               TINYTEXT       => 255자까지
            ★ TEXT           => 65,535자까지
               MEDIUMTEXT     => 16,777,215자까지
               LONGTEXT       => 4,294,967,295자까지
               

   3. 날짜형 : date, datetime, timestamp, time, year




























