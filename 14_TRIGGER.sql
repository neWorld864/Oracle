-- TRIGGER
-- 테이블이나 뷰에 DML문에 의해 변경이 일어났을 경우 자동으로 실행될 내용을 정의하여 저장하는 객체

-- 트리거 종류
/*
    - SQL문의 실행 시기에 따른 분류
        BEFORE TRIGGER : SQL문 실행 전 트리거 실행
        AFTER TRIGGER  : SQL문 실행 후 트리거 실행
    - SQL문에 의해 영향 받는 각 ROW에 따른 분류
        ROW TRIGGER
            SQL문 각 ROW에 대해 한 번씩 실행
            트리거 생성 시 FOR EACH ROW 옵션 작성
            :OLD    : 참조 전 열의 값(UPDATE : 수정 전 자료, DELETE : 삭제 전 자료)
            :NEW    : 참조 후 열의 값(INSERT : 입력한 자료, UPDATE : 수정 후 자료)
        STATEMENT TRIGGER
            SQL문에 의해 한 번만 실행(DEFAULT)

*/

-- 표현식
/*
    CREATE [OR REPLACE] TRIGGER 트리거명
    BEFORE | AFTER
    INSERT | UPDATE | DELETE
    ON 테이블명
    [FOR EACH ROW]
    [WHEN 조건]
    DECLARE
        선언부
    BEGIN
        실행부
    EXCEPTION
        예외처리부
    END;
    /
*/

-- EMPLOYEE테이블에 사원이 추가되면 '신입사원이 입사했습니다'라는 문구가 출력되는 TRG_01 트리거 생성
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT
ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('신입사원이 입사했습니다.');
END;
/

INSERT INTO EMPLOYEE
VALUES (999, '강건강', '000101-3333333', 'kang_kk@kh.or.kr', '01011112222', 'D5', 'J3', 'S5', 3000000, 0.1, 200,
        SYSDATE, NULL, DEFAULT);
-- 신입사원이 입사했습니다. : SET SERVEROUTPUT ON;을 해야 보임
        
ROLLBACK;

SET SERVEROUTPUT ON;

-- 상품 정보 테이블
CREATE TABLE PRODUCT(
    PCODE NUMBER PRIMARY KEY,   -- 상품코드
    PNAME VARCHAR2(30),         -- 상품 명
    BRAND VARCHAR2(30),         -- 브랜드
    PRICE NUMBER,               -- 가격
    STOCK NUMBER DEFAULT 0      -- 재고
);

-- 상품 입출고 상세 이력 테이블
CREATE TABLE PRO_DETAIL(
    DCODE NUMBER PRIMARY KEY,   -- 상세코드
    PCODE NUMBER,               -- 상품코드
    PDATE DATE,                 -- 상품 입출고일
    AMOUNT NUMBER,              -- 입출고 개수
    STATUS VARCHAR2(10) CHECK(STATUS IN('입고', '출고')), -- 상품 상태
    FOREIGN KEY(PCODE) REFERENCES PRODUCT(PCODE)
);

CREATE SEQUENCE SEQ_PCODE;
CREATE SEQUENCE SEQ_DCODE;

INSERT INTO PRODUCT
VALUES (SEQ_PCODE.NEXTVAL, '갤럭시S21', '삼성', 1000, DEFAULT);

INSERT INTO PRODUCT
VALUES (SEQ_PCODE.NEXTVAL, '아이폰12', '애플', 500, DEFAULT);

INSERT INTO PRODUCT
VALUES (SEQ_PCODE.NEXTVAL, 'WING', 'LG', 300, DEFAULT);

SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON PRO_DETAIL
FOR EACH ROW
BEGIN
    -- 상품이 입고된 경우 : STOCK 증가
    IF :NEW.STATUS = '입고' 
    THEN 
        UPDATE PRODUCT 
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE; 
    END IF;
END;
/

SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;

INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 5, '입고');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 10, '입고');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 20, '입고');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 5, '입고');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 1, '출고');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 19, '출고');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 15, '출고');
