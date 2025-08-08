
-- 테이블 삭제
drop table if exists tbl_character_equipment cascade;
drop table if exists tbl_item cascade;
drop table if exists tbl_equipment_slot cascade;
drop table if exists tbl_character cascade;
drop table if exists tbl_job cascade;

-- 테이블 생성

-- 직업 테이블 생성
create table if not exists tbl_job
(
	job_id varchar(30) primary key comment '장착부위_ID'
    , job_name varchar(30) not null comment '장착부위명'
    );

-- 캐릭터 테이블 생성
create table if not exists tbl_character
(
	character_name varchar(30) primary key comment '캐릭터명'
    , character_level int not null comment '레벨'
    , character_hp int not null comment '체력'
    , character_apoint int not null comment '기본 공격력'
    , character_dpoint int not null comment '기본 방어력'
    -- 폐기 , character_thp int comment '최종 체력'
    , character_tapoint int comment '최종 공격력'
    , character_tdpoint int comment '최종 방어력'
    , job_id varchar(30)
    , foreign key (job_id) references tbl_job(job_id)
    );
    
-- 장착부위 테이블 생성
create table if not exists tbl_equipment_slot
(
	equipmentslot_id varchar(30) primary key comment '장착부위_ID'
    , equipmentslot_name varchar(30) not null comment '장착부위명'
    );
    
-- 아이템 테이블 생성
create table if not exists tbl_item
(
	item_id varchar(30) primary key comment '아이템_ID'
    , item_name varchar(30) not null comment '아이템명'
    , item_apoint int not null comment '추가 공격력'
    , item_dpoint int not null comment '추가 방어력'
    , item_level int not null comment '장착레벨'
    , equipmentslot_id varchar(30)
    , foreign key (equipmentslot_id) references tbl_equipment_slot(equipmentslot_id)
    );
    
-- 캐릭터 장비 정보 테이블 생성
create table if not exists tbl_character_equipment
(
	character_name varchar(30)
    , equipmentslot_id varchar(30)
    , item_id varchar(30)
    , primary key (character_name, equipmentslot_id)	-- 한 부위에 하나의 아이템만 착용 제약조건
    , foreign key (character_name) references tbl_character(character_name)
    , foreign key (equipmentslot_id) references tbl_equipment_slot(equipmentslot_id)
    , foreign key (item_id) references tbl_item(item_id)
    );

-- 직업 추가
insert into tbl_job
(job_id, job_name)
values
('w1', '전사')
, ('a1', '궁수')
, ('m1', '마법사');

-- 캐릭터 추가
insert into tbl_character
(character_name, character_level, character_hp, character_apoint, character_dpoint, job_id)
values
('초보전사', 1, 100, 5, 5, 'w1')
, ('초보궁수', 1, 70, 7, 3, 'a1')
, ('초보마법사', 1, 50, 8, 2, 'm1')
, ('보통전사', 10, 1000, 14, 32, 'w1')
, ('보통궁수', 10, 520, 25, 21, 'a1')
, ('보통마법사', 10, 320, 35, 11, 'm1')
, ('고급전사', 20, 2000, 24, 62, 'w1')
, ('고급궁수', 20, 1020, 45, 41, 'a1')
, ('고급마법사', 20, 620, 65, 21, 'm1');

-- 장착부위 추가
insert into tbl_equipment_slot
(equipmentslot_id, equipmentslot_name)
values
('wepon', '무기')
, ('head', '머리')
, ('body', '몸')
, ('hand', '손')
, ('foot', '발');

-- 아이템 추가
insert into tbl_item
(item_id, item_name, item_apoint, item_dpoint, item_level, equipmentslot_id)
values
('wp1', '낡은검', 7, 0, 1, 'wepon')
, ('wp2', '일반검', 70, 0, 10, 'wepon')
, ('wp3', '고급검', 140, 0, 20, 'wepon')
,('wp4', '낡은활', 6, 0, 1, 'wepon')
,('wp5', '일반활', 60, 0, 10, 'wepon')
,('wp6', '고급활', 120, 0, 20, 'wepon')
,('wp7', '낡은지팡이', 5, 0, 1, 'wepon')
,('wp8', '일반지팡이', 50, 0, 10, 'wepon')
,('wp9', '고급지팡이', 100, 0, 20, 'wepon')
,('amhe1', '머리띠', 0, 2, 1, 'head')
,('amhe2', '모자', 0, 20, 10, 'head')
,('amb1', '천옷', 0, 3, 1, 'body')
,('amb2', '가죽옷', 0, 30, 10, 'body')
,('amha1', '장갑', 0, 1, 1, 'hand')
,('amha2', '가죽장갑', 0, 10, 10, 'hand')
,('amf1', '슬리퍼', 0, 1, 1, 'foot')
,('amf2', '신발', 0, 10, 10, 'foot');

-- 캐릭터 장비 정보 추가
insert into tbl_character_equipment
(character_name, equipmentslot_id, item_id)
values
('초보전사', 'wepon', 'wp1')
, ('초보전사', 'head', 'amhe1')
, ('초보전사', 'body', 'amb1')
, ('초보전사', 'hand', 'amha1')
, ('초보전사', 'foot', 'amf1');
