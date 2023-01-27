////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- tb_user 회원 테이블 (천우)


-- 테이블 생성
create table tb_user(
     id            char(10)              primary key             -- 아이디(pk)
    ,password      varchar2(20)          not null                -- 비밀번호
    ,uname         varchar2(10)          not null                -- 성명
    ,lunar         char(1)               not null                -- 양음력
    ,birth         varchar2(8)           not null                -- 생년월일
    ,gender        char(1)               not null                -- 성별
    ,addr          varchar2(100)         not null                -- 주소
    ,phone         varchar2(11)          not null                -- 연락처
    ,email         varchar2(50)          not null                -- 이메일
    ,mailreceive   char(1)               not null                -- 이메일 수신여부
    ,snsreceive    char(1)               not null                -- SNS 수신여부
    ,grade         char(1)               not null                -- 회원등급 코드
);

drop table tb_user;

-- 행 추가
insert  into tb_user(id, password, uname, lunar, birth, gender, addr, phone, email, mailreceive, snsreceive, grade)
values('gogo123', '1234', '병아리', 'S', '19940505', 'F', '서울특별시 강남구 역삼동 삼원빌딩 4층', '01011111111', 'gogo@naver.com', 'N', 'N', 'Y');

insert  into tb_user(id, password, uname, lunar, birth, gender, addr, phone, email, mailreceive, snsreceive, grade)
values('puppy456', '4567', '강아지', 'S', '19970202', 'M', '서울특별시 송파구 위례', '01022222222', 'puppy@gmail.com', 'N', 'N', 'O');

insert  into tb_user(id, password, uname, lunar, birth, gender, addr, phone, email, mailreceive, snsreceive, grade)
values('kawai789', '7890', '고양이', 'S', '20010404', 'F', '경기도 의정부시 커닝시티', '01033333333', 'kawai@naver.com', 'Y', 'N', 'G');

insert  into tb_user(id, password, uname, lunar, birth, gender, addr, phone, email, mailreceive, snsreceive, grade)
values('ginko159', '1590', '코끼리', 'L', '19990707', 'M', '강원도 춘천시 백령로 156', '01044444444', 'ginko@daum.net', 'N', 'N', 'B');

insert  into tb_user(id, password, uname, lunar, birth, gender, addr, phone, email, mailreceive, snsreceive, grade)
values('mokgin752', '7523', '기린', 'S', '19800101', 'F', '경기도 안양시 동안구 벌말로 126', '01055555555', 'mokgin@gmail.com', 'Y', 'Y', 'C');

insert  into tb_user(id, password, uname, lunar, birth, gender, addr, phone, email, mailreceive, snsreceive, grade)
values('kitty555', '0052', '고양이', 'S', '20000831', 'F', '서울특별시 송파구 송이로34길 26', '01066666666', 'kitty@naver.com', 'N', 'N', 'Y');

insert  into tb_user(id, password, uname, lunar, birth, gender, addr, phone, email, mailreceive, snsreceive, grade)
values('hamster974', '8542', '햄스터', 'L', '20020201', 'M', '경기도 이천시 신둔면 도봉리 1271', '01077777777', 'hamster@gmail.com', 'Y', 'Y', 'C');


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- tb_display 공연전시테이블 (강선)


-- 테이블 생성
create table tb_display (
    icode       varchar2(50)        not null        primary key     -- 상품구분코드(pk)
    ,iname      varchar2(62)        not null                        -- 상품이름  
    ,genre      varchar2(20)        not null                        -- 장르구분코드   
    ,sdate      date                not null                        -- 시작일
    ,edate      date                not null                        -- 종료일
    ,place      varchar2(10)        not null                        -- 장소구분코드
    ,extra      varchar2(1000)                                      -- 비고
    ,img        varchar2(100)                                       -- 이미지
);

drop table tb_display;

set define off;      
-- [레이 첸 & 선우예권] 문자열은 데이터값에 &포함시 변수로 판단하여 대체입력값이 요구됩니다. 
-- 쿼리 실행 전 [set define off;] 를 실행하면 & 문자를 대체변수로 인식하지 않습니다.


-- 행 추가
insert into tb_display(icode, iname, genre, sdate, edate, place, extra, img)
values ('exhibit001'
            , '앤서니 브라운의 원더랜드 뮤지엄전'
            , 'art'
            , '2022-04-28'
            , '2022-08-31'
            , 'hanart'
            , '(주)아트센터이다,아트레이스(주)/02-730-4368/전체관람/10:00 ~ 19:00/제3전시실, 제4전시실'
            , 'ensunny.png'
            );



insert into tb_display(icode, iname, genre, sdate, edate, place, extra, img)
values ('show001', 
            '레이 첸 선우예권 ',  -- 레이 첸 & 선우예권 문자열은 데이터값에 &포함시 변수로 판단하여 대체입력값이 요구됩니다. 쿼리 실행 전 [set define off;] 를 실행하면 & 문자를 대체변수로 인식하지 않습니다.
             'orche', 
             '2022-08-31', 
             '2022-08-31', 
             'concert', 
             '(주)마스트미디어/02-541-2512/8세 이상/19:30 (관람시간 100분)',
             'reichen.png'
            );


insert into tb_display(icode, iname, genre, sdate, edate, place, extra, img)
values ('exhibit002'
            , '홀 어스 트럭 스토어 2022: 가구, 오래 쓰는 물건'          -- iname varchar(50) 안돼요. "INAME" 열에 대한 값이 너무 큼(실제: 62, 최대값: 50) / varchar(62) 이상 줘야합니다.
            , 'art'
            , '2022-08-26'
            , '2022-09-11'
            , 'hanart'
            , '예술의전당 , 디자인누하/070-4254-0955/전체관람/전시입장마감시간 18:30/10:00 ~ 19:00/제7전시실'
            , 'hallearth.png'
            );
            

insert into tb_display(icode, iname, genre, sdate, edate, place, extra, img)
values ('show002'
            , '강석우와 함께하는 11시 콘서트'          
            , 'vocal'
            , '2022-08-31'
            , '2022-08-31'
            , 'ibk'
            , '두남재엔터테이먼트 주식회사/02-464-1515/8세 이상/11:00'
            , 'sukwoo.png'
            );
            
            
            
insert into tb_display(icode, iname, genre, sdate, edate, place, extra, img)
values ('exhibit003'
            , '앙리 카르티에 브레송 특별전: 결정적 순간'          
            , 'design'
            , '2022-06-10'
            , '2022-10-02'
            , 'hanart'
            , 'FOUNDATION HENRI CARTIER-BRESSON UNQP LTD. KATE FARM/02-747-7790/전체관람/10:00 ~ 19:00/제5전시실,제6전시실'
            , 'angli.png'
            );
            
            
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            
            
-- tb_seat 좌석테이블 (한이)


-- 테이블 생성
create table tb_seat (
    scode       varchar2(20)     primary key      -- 좌석구분코드 (pk)
   ,place       varchar2(20)     not null         -- 장소구분코드
   ,sgrade      varchar2(20)     not null         -- 등급
   ,startno     number(5)                         -- 좌석시작번호
   ,endno       number(5)                         -- 좌석끝번호
);

drop table tb_seat;


-- 행 추가
insert into tb_seat (scode, place, sgrade, startno, endno)
values('ibk_r', 'ibk', 'R', 1, 200);

insert into tb_seat (scode, place, sgrade, startno, endno)
values('ibk_s', 'ibk', 'S', 201, 400);

insert into tb_seat (scode, place, sgrade, startno, endno)
values('ibk_a', 'ibk', 'A', 401, 600);

insert into tb_seat (scode, place, sgrade, startno, endno)
values('concert_r', 'concert', 'R', 1, 500);

insert into tb_seat (scode, place, sgrade, startno, endno)
values('concert_s', 'concert', 'S', 501, 1000);

insert into tb_seat (scode, place, sgrade, startno, endno)
values('concert_a', 'concert', 'A', 1001, 1500);

insert into tb_seat (scode, place, sgrade, startno, endno)
values('concert_b', 'concert', 'B', 1501, 2000);

insert into tb_seat (scode, place, sgrade, startno, endno)
values('concert_c', 'concert', 'C', 2001, 2500);

insert into tb_seat (scode, place, sgrade, startno, endno)
values('inchun_n', 'inchun', '일반석', 1, 100);

insert into tb_seat (scode, place, sgrade)
values('hanart_a', 'hanart', '성인');

insert into tb_seat (scode, place, sgrade)
values('hanart_t', 'hanart', '청소년');

insert into tb_seat (scode, place, sgrade)
values('hanart_j', 'hanart', '어린이');


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- tb_product 상품테이블 (다슬)


-- 테이블 생성
create table tb_product(
    icode          varchar2(50)        not null                         -- 상품구분코드
   ,scode          varchar2(20)        not null                         -- 좌석구분코드
   ,price          number(7)           default 0         not null       -- 가격
   ,sno            number(10)          not null                         -- 번호
   ,primary key(sno)                                                    -- 번호 (pk)
   ,foreign key(icode) references tb_display(icode)                     -- 상품구분코드 (fk)
   ,foreign key(scode) references tb_seat(scode)                        -- 좌석구분코드 (fk)
);

drop table tb_product;

-- 시퀀스 생성
create sequence tb_product_seq;

-- 행 추가
insert into tb_product(icode, scode, price, sno)
values('exhibit001','hanart_a',20000,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('exhibit001','hanart_t',13000,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('exhibit001','hanart_j',13000,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('show001','concert_r',120000,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('show001','concert_s',90000,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('show001','concert_a',70000,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('show001','concert_b',50000,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('show001','concert_c',30000,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('exhibit002','hanart_a',0,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('exhibit003','hanart_a',18000,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('exhibit003','hanart_t',15000,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('exhibit003','hanart_j',12000,tb_product_seq.nextval);

insert into tb_product(icode, scode, price, sno)
values('show002','ibk_r',30000,tb_product_seq.nextval);


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- tb_basket 장바구니 테이블 (천우)


-- 테이블 생성
create table tb_basket(
    sno         number(10)      primary key          -- 일련번호(pk)
    ,icode      varchar2(50)    not null             -- 상품구분코드
    ,foreign key(icode) references tb_display(icode)  
    on delete cascade                                -- 상품구분코드(fk)
    ,amount     number(3)       default 0            -- 수량
    ,id         char(10)        not null             -- 아이디
    ,foreign key(id) references tb_user(id)
    on delete cascade                                -- 아이디(fk)
    ,bview      char(12)        not null             -- 관람회차
    ,seat       number(4)                            -- 선택좌석
    ,scode      varchar2(20)    not null             -- 좌석구분코드
    ,foreign key(scode) references tb_seat(scode)
    on delete cascade                                -- 좌석구분코드(fk)
    ,ship       char(1)         not null             -- 배송비
    ,sale       char(1)         not null             -- 할인코드
);

drop table tb_basket;

-- 시퀀스 생성
create sequence basket_seq;

-- 행추가
insert  into tb_basket(sno, icode, amount, id, bview, seat, scode, ship, sale)
values(basket_seq.nextval,'show001',1,'gogo123','20220831-001',206,'concert_r','Y','N');

insert  into tb_basket(sno, icode, amount, id, bview, seat, scode, ship, sale)
values(basket_seq.nextval,'show001',1,'gogo123','20220831-001',1001,'concert_a','Y','T');

insert  into tb_basket(sno, icode, amount, id, bview, seat, scode, ship, sale)
values(basket_seq.nextval,'exhibit001',2,'puppy456','20220831-001',null,'hanart_a','Y','N');

insert  into tb_basket(sno, icode, amount, id, bview, seat, scode, ship, sale)
values(basket_seq.nextval,'exhibit001',2,'puppy456','20220831-001',null,'hanart_t','Y','N');

insert  into tb_basket(sno, icode, amount, id, bview, seat, scode, ship, sale)
values(basket_seq.nextval,'exhibit003',1,'mokgin752','20220908-001',null,'hanart_t','N','N');

insert  into tb_basket(sno, icode, amount, id, bview, seat, scode, ship, sale)
values(basket_seq.nextval,'exhibit003',1,'mokgin752','20220908-001',null,'hanart_j','N','N');


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- tb_order 주문서테이블 (한샘)

-- 테이블 생성
create table tb_order(
     orderid        char(10)            not null           -- 회원아이디 (fk)
    ,onum           char(18)            not null           -- 주문번호 (pk)
    ,dis            number(10)          default 0          -- 할인금액
    ,fpay           number(10)          default 0          -- 총 결제금액
    ,oto            varchar2(20)        not null           -- 받는 사람
    ,addr           varchar2(100)                          -- 받는 주소 (현장수령 null)
    ,mas            varchar2(200)                          -- 배송메세지
    ,osta           char(1)             not null           -- 배송현황
    
    ,primary key(onum)
    ,foreign key(orderid) references tb_user(id)     -- 회원아이디 (fk)
);

drop table tb_order;

-- 행 추가
insert into tb_order(orderid,onum,dis,fpay,oto,addr,mas,osta)
values(
         'gogo123'
        ,'20220831073030-001'
        ,'0'                        -- 기본값 0 → 테이블 조인 후 sum으로 계산 
        ,'0'                        
        ,'병아리'
        ,'서울특별시 강남구 역삼동 삼원빌딩 4층'
        ,'허리업'
        ,'D'
        );
insert into tb_order(orderid,onum,dis,fpay,oto,addr,mas,osta)
values(
         'puppy456'
        ,'20220831120603-002'
        ,'0'                         
        ,'0'                        
        ,'강아지'
        ,'서울특별시 송파구 위례'
        ,'너만 오면 됨'
        ,'I'
        );
insert into tb_order(orderid,onum,dis,fpay,oto,osta)
values(
         'mokgin752'
        ,'20220831164520-003'
        ,'0'                         
        ,'0'                       
        ,'기린'
        ,'B'    
        );                          -- 현장수령:addr null 
        
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- tb_detail 주문 상세 내역서 테이블 (강선)


-- 테이블 생성
create table tb_detail (
    dno          number(10)          not null        primary key         -- 일련번호 (pk)
    ,dnum        char(18)            not null                            -- 주문서번호
    ,dcode       varchar2(50)        not null                            -- 상품코드
    ,damount     number(3)           default 0                           -- 상품수량
    ,dship       char(1)             not null                            -- 배송비
    ,dsum        number(10)          default 0                           -- 금액
    ,dview       char(12)            not null                            -- 관람회
    ,foreign key(dnum) references  tb_order(onum)                        -- 주문서번호 (fk)
    ,foreign key(dcode) references tb_display(icode)                     --  상품코드 (fk)
);

drop table tb_detail;


-- 시퀀스 생성
create sequence detail_seq;
drop sequence detail_seq;


-- 행 추가
insert into tb_detail (dno, dnum, dcode, dship, dview)
values(detail_seq.nextval, '20220831073030-001', 'show001', 'Y', '20220831-001');

insert into tb_detail (dno, dnum, dcode, dship, dview)
values(detail_seq.nextval, '20220831120603-002', 'exhibit001', 'Y', '20220831-001');

insert into tb_detail (dno, dnum, dcode, dship, dview)
values(detail_seq.nextval, '20220831164520-003', 'exhibit003', 'Y', '20220908-001');


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- tb_notice 공지사항테이블 (다슬)

--테이블 생성
create table tb_notice(
    sno             number(8)              not null                             -- 일련번호
   ,gubun           varchar2(10)           not null                             -- 구분 (info:안내/aca:아카데미/mojib:모집)
   ,title           varchar2(100)          not null                             -- 제목
   ,content         varchar2(1000)         not null                             -- 내용
   ,regdt           date                   default sysdate         not null     -- 등록일
   ,writer          varchar2(10)           not null                             -- 작성자
   ,img             varchar2(1000)                                              -- 첨부파일
   ,primary key(sno)                                                            -- 일련번호 (pk)   ,
); 

drop table tb_notice;

--시퀀스 생성
create sequence tb_notice_seq;


--행 추가
insert into tb_notice(sno, gubun, title, content, regdt, writer)
values(tb_notice_seq.nextval,'info','8.31(수) 예술의전당 문화가 있는 날 안내','매달 마지막 수요일은 문화가 있는 날!','2022-08-31','관리자');

insert into tb_notice(sno, gubun, title, content, regdt, writer)
values(tb_notice_seq.nextval,'info','2022 예술의전당 9월 청년미술상점 안내','청년미술상점은 작가와 관람객이 만나는 소통의 공간입니다.','2022-08-29','관리자');

insert into tb_notice(sno, gubun, title, content, regdt, writer)
values(tb_notice_seq.nextval,'info','9월1일부터 예술의전당 주차장 이용요금이 변경됩니다.','혼합할증: 연중 토,일,공휴일에 한하여 주차요금의 1.5배 부과','2022-08-17','관리자');

insert into tb_notice(sno, gubun, title, content, regdt, writer)
values(tb_notice_seq.nextval,'aca','[미술실기]2022 가을학기 수강생 모집(~9.24)','2022 예술의 전당 미술실기아카데미 가을학기 수강생 모집','2022-08-04','관리자');

insert into tb_notice(sno, gubun, title, content, regdt, writer, img)
values(tb_notice_seq.nextval,'mojib','예술의전당 하우스 어텐던트 모집(상시)','어제는 관객으로 왔던 예술의전당에서, 오늘은 예술의전당 하트가 되어 다채로운 공연의 현장을 직접 경험해보세요','2022-07-22','관리자','예술의전당 하우스 어텐던트 응시원서.hwp,
하우스 어텐던트 교육일정표(7.22).pdf');


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- tb_event 이벤트 테이블 (강선)


-- 테이블 생성
create table tb_event (
    ecode          varchar2(5)        not null           -- 구분코드 
    , etitle       varchar2(150)      not null           -- 제목  
    , eimg         varchar2(100)      not null           -- 본문이미지
    , sdate        date               not null           -- 공연시작날짜
    , edate        date               not null           -- 공연종료날짜
    , windate      date               not null           -- 당첨자발표날짜
    , grade        varchar2(11)       not null           -- 참여대상등급
    , primary key(ecode)
);

drop table tb_event;


-- 행 추가
insert into tb_event (ecode, etitle, eimg, sdate, edate, windate, grade)
values ('co001', '2022 스타일웨이 위너 콘서트', 'style.jpg', '2022-08-29', '2022-09-18', '2022-09-22', 'N/Y/O/G/B/G');

insert into tb_event (ecode, etitle, eimg, sdate, edate, windate, grade)
values ('ad001', '챗봇 속닥속닥(SAC) 이벤트', 'SAC.jpg', '2022-05-02', '2022-12-31', '2023-01-01', 'N/Y/O/G/B/G');

insert into tb_event (ecode, etitle, eimg, sdate, edate, windate, grade)
values ('co002', '[골드회원] 파보 예르비 ＆ 에스토니안 페스티벌 오케스트라 기대평 이벤트 ', 'paavo.jpg', '2022-08-13', '2022-08-26', '2022-08-26', 'G');
-- & 이 특수문자 먹히지 않음. ＆ 특수문자 바꿔야함. 아니면  set define off;     선언하기

insert into tb_event (ecode, etitle, eimg, sdate, edate, windate, grade)
values ('ad002', '여름음악축제 골드회원을 위한 행운의 칠칠(77)이벤트', 'summer.jpg', '2022-08-12', '2022-08-24', '2022-08-24', 'G');

insert into tb_event (ecode, etitle, eimg, sdate, edate, windate, grade)
values ('co003', '[유료회원] 국립합창단 기획공연 마지막 눈사람 기대평 이벤트', 'choral.jpg', '2022-08-06', '2022-08-23', '2022-08-23', 'GR/B/GO');

delete from tb_event;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- tb_applicant 이벤트 신청자 테이블 (강선)

-- 테이블 생성
create table tb_applicant (
    ano                varchar2(4)     not null          primary key     -- 일련번호 (pk)
    ,ecode             varchar2(5)     not null                          -- 구분코드
    ,aid               char(10)        not null                          -- 아이디
    ,adate             date            default sysdate                   -- 작성날짜
    ,acomment          varchar2(500)   not null                          -- 댓글내용
    ,foreign key(ecode) references tb_event(ecode)                       -- 구분코드 (fk)
    ,foreign key(aid) references tb_user(id)                             -- 아이디 (fk)
);

drop table tb_applicant;

select*from tb_applicant;

-- 시퀀스 생성
create sequence applicant_seq;
drop sequence applicant_seq;


-- 행 추가
insert into tb_applicant (ano, ecode, aid, acomment)
values ( applicant_seq.nextval 
        ,'co001'
        ,'gogo123' 
        ,'우리나라 피아니스트들과는 또 다른 느낌으로 연주할 것 같은 기대감과, 피아니스트와 클래식에 대한 이해의 깊이가 더욱 깊어질 것 같아요~'
        );

insert into tb_applicant (ano, ecode, aid, acomment)
values ( applicant_seq.nextval
        ,'co002'
        ,'puppy456' 
        ,'관심있는 피아니스트입니다. 꼭 관람하고 싶어요~!'
        );
        
insert into tb_applicant (ano, ecode, aid, acomment)
values ( applicant_seq.nextval 
        ,'co003'
        ,'kawai789'
        ,'앨림 베이젬바이예프의 섬세한 연주를 직접 들어볼 수 있는 기회가 있다니 너무 설레입니다.'
    );
        
insert into tb_applicant (ano, ecode, aid, acomment)
values (applicant_seq.nextval
        ,'co001'
        ,'ginko159'
        ,'요즘 피아노 공연이 인기가 많아진것같아 저도 동참하고싶습니다.'
        );
                
insert into tb_applicant (ano, ecode, aid, acomment)
values ( applicant_seq.nextval 
        ,'co002'
        ,'mokgin752' 
        ,'9월 20일이 생일인데 생일 선물로 받고 싶네요!! 공연 기대합니다.'
        );
        
        select*from tb_applicant;
        
        
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- tb_review 관람평테이블 (한샘)
create table tb_review(
     snum          number(10)                                          -- 일련번호(pk)
    ,icode         varchar2(50)         not null                       -- 상품구분코드(fk)
    ,title         varchar2(100)        not null                       -- 상품 제목
    ,img           varchar2(100)                                       -- 상품 이미지
    ,reid          char(10)                                            -- 작성자 아이디(fk)
    ,rdate         date                 default sysdate                -- 작성일
    ,rscop         varchar2(20)         not null                       -- 별점
    ,rcont         varchar2 (1000)                                     -- 관람평 
    
    ,primary key(snum)                                                 -- 일련번호(pk)
    ,foreign key(icode) references tb_display(icode)                   -- 상품구분코드(fk)
    ,foreign key(reid) references tb_user(id)                          -- 작성자 아이디(fk)
);

drop table tb_review;

-- 시퀀스 생성
create sequence re_seq start with 1 ;
drop sequence re_seq;

-- 행 추가
insert into tb_review(snum,icode,title,img,reid,rdate,rscop,rcont)
values(
         re_seq.nextval
        ,'exhibit003'
        ,'앙리 카르티에 브레송 특별전: 결정적 순간'                        
        ,'HenriCartier.png'            
        ,'mokgin752'
        ,'2022-09-08'
        ,'★★★'    
        ,'기대 이상입니다'
        );          
insert into tb_review(snum,icode,title,img,reid,rdate,rscop,rcont)
values(
         re_seq.nextval
        ,'show001'
        ,'레이 첸 ＆ 선우예권'                        
        ,'laychen.png' 
        ,'gogo123'
        ,'2022-09-01'
        ,'★★★★★'    
        ,'와 멋있어요'
        );                
insert into tb_review(snum,icode,title,img,reid,rdate,rscop,rcont)
values(
         re_seq.nextval
        ,'exhibit001'
        ,'앤서니 브라운의 원더랜드 뮤지엄전'                        
        ,'anthonybrowne.png'   
        ,'puppy456'
        ,'2022-09-01'
        ,'★★'    
        ,'최악'
        );     
        
insert into tb_review(snum,icode,title,img,reid,rdate,rscop,rcont)
values(
         re_seq.nextval
        ,'show002'
        ,'강석우와 함께하는 11시 콘서트'                        
        ,'11concert.png'   
        ,'kitty555'
        ,'2022-07-27'
        ,'★★★★★'    
        ,'사랑합니다'
        );           
insert into tb_review(snum,icode,title,img,reid,rdate,rscop,rcont)
values(
         re_seq.nextval
        ,'exhibit002'
        ,'홀 어스 트럭 스토어 2022: 가구, 오래 쓰는 물건'                        
        ,'truckstore.png'   
        ,'hamster974'
        ,'2022-07-24'
        ,'★★★★'    
        ,'앞으로 계속 좋은 기획 부탁드립니다'
        );   


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- tb_inquiry 1:1 문의테이블 (한이)


-- 테이블 생성
create table tb_inquiry(
    in_no        varchar2(20)    primary key                       -- 문의번호 (pk)
    ,in_type     char(20)        not null                          -- 문의종류
    ,in_date     date            default sysdate       not null    -- 작성일
    ,userid      char(10)        not null                          -- 회원ID
    ,in_title    varchar(50)     not null                          -- 작성제목
    ,in_content  varchar(500)    not null                          -- 작성내용
    ,foreign key(userid) references tb_user(id)                    -- 회원ID(fk)
);

drop table tb_inquiry;

--행 추가
insert into tb_inquiry(in_no, in_type, in_date, userid, in_title, in_content)
values('20220801114130-001', '회원제 운영', '20220801', 'gogo123', '회원제 비싸요', '이 가격이 말이 됩니까?');

insert into tb_inquiry(in_no, in_type, in_date, userid, in_title, in_content)
values('20220802103101-002', '홈페이지 운영', '20220802', 'ginko159', '글자가 잘 안 보여요', '글씨 크기 좀... 크게... 해주세요ㅛ...');

insert into tb_inquiry(in_no, in_type, in_date, userid, in_title, in_content)
values('20220802103101-003', '편의시설', '20220815', 'kawai789', '주변에 맥도날드 없나요?', '맥도날드파인데');

insert into tb_inquiry(in_no, in_type, in_date, userid, in_title, in_content)
values('20220802103101-004', '티켓 예매 취소', '20220817', 'puppy456', '예매 취소 확인', '취소된거 맞나요?');


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- tb_answer 답변테이블 (한이)


-- 테이블 생성
create table tb_answer (
    in_no          varchar2(20)     not null          --문의번호
   ,an_content     varchar2(500)    not null          --답변내용
   ,foreign key(in_no) references tb_inquiry(in_no)
    on delete cascade
);

drop table tb_answer;

--행추가
insert into tb_answer (in_no, an_content)
values('20220802103101-004', '확인 결과 취소되었습니다. 문의주셔서 감사합니다.');

insert into tb_answer (in_no, an_content)
values('20220802103101-003', '없습니다.');

insert into tb_answer (in_no, an_content)
values('20220802103101-002', '참고하겠습니다.');


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

select BA.id, BA.seat, BA.amount, DI.iname, DI.sdate
from tb_basket BA join tb_display DI
on BA.icode=DI.icode;


from tb_product join 



