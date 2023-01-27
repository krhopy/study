
파일 → 새로만들기 → 데이터베이스계층 → 데이터베이스 파일
    i:\java202207\database\20220829_02종합연습문제.sql
    
////////////////////////////////////////////////////////////////////////////////

● [종합 연습문제]

select count(*) from tb_student;    -- 6개
select count(*) from tb_gwamok;     -- 9개
select count(*) from tb_sugang;     -- 14개


문1) 디자인 교과목중에서 학점이 제일 많은 교과목을 수강신청한 명단을 조회하시오
    (학번, 이름, 과목코드)
    d002 g1005 진달래
    
 <강사님 코드>

-- 디자인 교과목의 학점 조회하기
select *
from tb_gwamok
where gcode like 'd%'
order by ghakjum desc;



-- 1) 디자인 교과목 중에서 학점이 제일 많은 학점 조회하기
select max(ghakjum) --5
from tb_gwamok
where gcode like 'd%';
-- 학점이 동률이면 데이터가 겹친다


-- 2-1) 1)결과에서 나온 학점(5)과 동일한 학점을 갖고 있는 행에서 과목코드 선택
--    즉, 디자인 교과목 중에서 학점이 제일 많은 과목코드(단, 중복된 학점이 없다는 가정하에)
select gcode
from tb_gwamok
where ghakjum=(5)
and gcode like 'd%';    --d002


-- 2-2) 5에 1)번 코드를 넣으면 최대 학점이 바뀌어도 코드 수정할 필요 없다. 
select gcode
from tb_gwamok
where ghakjum=(select max(ghakjum) from tb_gwamok where gcode like 'd%')
and gcode like 'd%';    --d002



-- 3) 2)에서 나온 과목코드 (d002) 수강신청한 명단을 조회
select gcode, hakno from tb_sugang where gcode=('d002');

select gcode, hakno 
from tb_sugang 
where gcode=(
            select gcode
            from tb_gwamok
            where ghakjum=(select max(ghakjum) from tb_gwamok where gcode like 'd%')
            and gcode like 'd%'
            );
            
            
-- 4) 3의 결과를 AA테이블로 만든 후, 학생테이블을 조인해서 이름 가져오기

select AA.gcode, AA.hakno, ST.uname        
from (
        select gcode, hakno 
        from tb_sugang 
        where gcode=(
                    select gcode
                    from tb_gwamok
                    where ghakjum=(select max(ghakjum) from tb_gwamok where gcode like 'd%')
                    and gcode like 'd%'
                    )
     )AA join tb_student ST
on AA.hakno=ST.hakno;
            
    
    
    
 <강선 코드>
 -- (1)
select gname, gcode, ghakjum from tb_gwamok where gcode like 'd%' order by ghakjum desc;


-- (2)
select ST.uname, SU.gcode, SU.hakno
from tb_sugang SU join tb_student ST
on SU.hakno=ST.hakno
where gcode like 'd%';


-- (3)
select AA.hakno, GW.gcode, uname
from (
        select ST.uname, SU.gcode, SU.hakno
        from tb_sugang SU join tb_student ST
        on SU.hakno=ST.hakno
        where gcode like 'd%'
)AA join tb_gwamok GW
on AA.gcode=GW.gcode
where GW.ghakjum>=5;


-- (4)
select AA.hakno, GW.gcode, uname
from (
        select ST.uname, SU.gcode, SU.hakno
        from tb_sugang SU join tb_student ST
        on SU.hakno=ST.hakno
        where gcode like 'd%'
)AA join tb_gwamok GW
on AA.gcode=GW.gcode
where GW.ghakjum>=(select max(ghakjum) from tb_gwamok where gcode like 'd%');



--------------------------------------------------------------------------------



문2) 학번별 수강신청한 총학점을 구하고 학번별 정렬해서 줄번호 4~6행 조회하시오
    (단, 수강신청하지 않은 학생의 총학점도 0으로 표시)
    
    g1004   0       4
    g1005   12      5
    g1006   3       6
    
    
 <강사님 코드>

-- 학생테이블 조회하기
select hakno, uname from tb_student order by hakno;


-- 1) 수강신청한 과목의 학점 가져오기
select SU.hakno, SU.gcode, GW.ghakjum
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode;


-- 2) 학번별로 총 학점 구하기(학번별로 그룹바이, 총학점은 sum)
select SU.hakno, sum(GW.ghakjum) as 총학점
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode
group by SU.hakno;


-- 3) 수강신청하지 않은 학생들도 가져올 수 있도록 학생테이블 left join 하고,
--    2)결과 (AA테이블)를 붙임

select ST.hakno, ST.uname, AA.hakno, AA.총학점
from tb_student ST left join (
                                select SU.hakno, sum(GW.ghakjum) as 총학점
                                from tb_sugang SU join tb_gwamok GW
                                on SU.gcode=GW.gcode
                                group by SU.hakno
                              ) AA 
on ST.hakno=AA.hakno; 


-- 4) 총학점이 null이면 0으로 바꾸고, 학번 순으로 조회하기
select ST.hakno, ST.uname, nvl(AA.총학점, 0)
from tb_student ST left join (
                                select SU.hakno, sum(GW.ghakjum) as 총학점
                                from tb_sugang SU join tb_gwamok GW
                                on SU.gcode=GW.gcode
                                group by SU.hakno
                              ) AA 
on ST.hakno=AA.hakno
order by ST.hakno; 


-- 5) 줄번호 추가 (줄번호가 있는 상태에서 정렬됨)
select ST.hakno, ST.uname, nvl(AA.총학점, 0), rownum as rnum
from tb_student ST left join (
                                select SU.hakno, sum(GW.ghakjum) as 총학점
                                from tb_sugang SU join tb_gwamok GW
                                on SU.gcode=GW.gcode
                                group by SU.hakno
                              ) AA 
on ST.hakno=AA.hakno
order by ST.hakno; 



-- 6) 5의 결과를 셀프조인하고, 줄번호 추가하기
select BB.hakno, BB.uname, BB.총학점2, rownum as rnum
from (
        select ST.hakno, ST.uname, nvl(AA.총학점, 0) as 총학점2
        from tb_student ST left join (
                                        select SU.hakno, sum(GW.ghakjum) as 총학점
                                        from tb_sugang SU join tb_gwamok GW
                                        on SU.gcode=GW.gcode
                                        group by SU.hakno
                                    ) AA 
        on ST.hakno=AA.hakno
        order by ST.hakno
) BB ;




-- 7) 6)의 결과를 셀프조인(cc테이블)하고 줄번호(rnum) 4~6 조회하기
select CC.hakno, CC.총학점2, rnum
from (
        select BB.hakno, BB.uname, BB.총학점2, rownum as rnum
        from (
                select ST.hakno, ST.uname, nvl(AA.총학점, 0) as 총학점2
                from tb_student ST left join (
                                                select SU.hakno, sum(GW.ghakjum) as 총학점
                                                from tb_sugang SU join tb_gwamok GW
                                                on SU.gcode=GW.gcode
                                                group by SU.hakno
                                             ) AA 
                on ST.hakno=AA.hakno
                order by ST.hakno
     ) BB
)CC 
where rnum>=4 and rnum<=6 ;



 <강선코드>
select ST.hakno, NVL(sum(GW.ghakjum), 0) as hakjum
from tb_student ST left join tb_sugang SU
on ST.hakno=SU.hakno left join tb_gwamok GW
on SU.gcode=GW.gcode
group by ST.hakno;


select hakno, hakjum, rownum as rnum
from (
    select ST.hakno, NVL(sum(GW.ghakjum), 0) as hakjum
    from tb_student ST left join tb_sugang SU
    on ST.hakno=SU.hakno left join tb_gwamok GW
    on SU.gcode=GW.gcode
    group by ST.hakno
);


select *
from (
        select hakno, hakjum, rownum as rnum
        from (
            select ST.hakno, NVL(sum(GW.ghakjum), 0) as hakjum
            from tb_student ST left join tb_sugang SU
            on ST.hakno=SU.hakno left join tb_gwamok GW
            on SU.gcode=GW.gcode
            group by ST.hakno
            order by ST.hakno
     )
)
where rnum>=4 and rnum<=6;




select *
from (
        select ST.hakno, ST.uname, SU.hakno, SU.gcode
        from tb_student ST left join tb_sugang SU
        on ST.hakno=SU.hakno
)AA left join tb_gwamok GW
on SU.gcode=GW.gcode;




--2)  학번별 정렬

-- 3)  줄번호 4~6행

-- 4) 수강신청하지 않은 학생 (outer left join)



--------------------------------------------------------------------------------



문3) 학번별로 수강신청 총학점을 구하고, 총학점순으로 내림차순 정렬후
     위에서 부터 1건만 조회하시오 (학번, 이름, 총학점)
     
     g1001      12      홍길동      1
     

-- 학번별로 수강신청 총학점

-- 총학점순으로 내림차순 정렬


문3) 학번별로 수강신청 총학점을 구하고, 총학점순으로 내림차순 정렬후
     위에서 부터 1건만 조회하시오 (학번, 이름, 총학점) 
-- 수강테이블에 행추가 해주세요
-- (총학점이 다 같은 값이여서 결과확인하기가 조금 애매 합니다)
insert into tb_sugang(sno,hakno,gcode) values(sugang_seq.nextval,'g1001','p005');
commit;



-- 1) 과목 코드가 일치하는 학점 가져오기
select SU.hakno, SU.gcode, GW.ghakjum
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode;


-- 2) 학번별로 총학점 구하고, 총학점순으로 내림차순 정렬하기
select SU.hakno, sum(GW.ghakjum) as 총학점
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode
group by SU.hakno 
order by sum(GW.ghakjum) desc;


-- 3) 2)의 결과를 AA 테이블로 만들고, 학생테이블 조인해서 이름 가져오기

select AA.hakno, AA.총학점, ST.uname, rownum as rnum
from (
        select SU.hakno, sum(GW.ghakjum) as 총학점
        from tb_sugang SU join tb_gwamok GW
        on SU.gcode=GW.gcode
        group by SU.hakno 
        order by sum(GW.ghakjum) desc
)AA join tb_student ST
on AA.hakno=ST.hakno;



-- 4) 3)의 결과를 셀프조인하고 줄번호를 이용해서 위에서부터 1건만 조회하기
select hakno, 총학점, uname, rnum
from (
        select AA.hakno, AA.총학점, ST.uname, rownum as rnum
        from (
                select SU.hakno, sum(GW.ghakjum) as 총학점
                from tb_sugang SU join tb_gwamok GW
                on SU.gcode=GW.gcode
                group by SU.hakno 
                order by sum(GW.ghakjum) desc
             )AA join tb_student ST
        on AA.hakno=ST.hakno
) 
where rnum=1;




 <강선코드>
 
select SU.gcode, sum(ghakjum)
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode 
group by SU.gcode 
order by sum(ghakjum) desc;



select SU.gcode, sum(ghakjum)
from tb_sugang SU join tb_gwamok GW
on SU.gcode=GW.gcode join tb_student ST
on SU.hakno=ST.hakno
group by SU.gcode 
order by sum(ghakjum) desc;



        select SU.hakno, sum(ghakjum)
        from tb_sugang SU join tb_gwamok GW
        on SU.gcode=GW.gcode
        group by SU.hakno 
        order by sum(ghakjum) desc;
        



select AA.hakno, hakjum, uname, rownum as rnum
from (
        select SU.hakno, sum(ghakjum) as hakjum
        from tb_sugang SU join tb_gwamok GW
        on SU.gcode=GW.gcode
        group by SU.hakno 
        order by sum(ghakjum) desc
) AA join tb_student ST
on AA.hakno=ST.hakno;



select *
from (
        select AA.hakno, hakjum, uname, rownum as rnum
        from (
                select SU.hakno, sum(ghakjum) as hakjum
                from tb_sugang SU join tb_gwamok GW
                on SU.gcode=GW.gcode
                group by SU.hakno 
                order by sum(ghakjum) desc
        ) AA join tb_student ST
        on AA.hakno=ST.hakno
) where rnum=1;


////////////////////////////////////////////////////////////////////////////////






























