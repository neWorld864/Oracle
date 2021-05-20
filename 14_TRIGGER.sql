-- TRIGGER
-- ���̺��̳� �信 DML���� ���� ������ �Ͼ�� ��� �ڵ����� ����� ������ �����Ͽ� �����ϴ� ��ü

-- Ʈ���� ����
/*
    - SQL���� ���� �ñ⿡ ���� �з�
        BEFORE TRIGGER : SQL�� ���� �� Ʈ���� ����
        AFTER TRIGGER  : SQL�� ���� �� Ʈ���� ����
    - SQL���� ���� ���� �޴� �� ROW�� ���� �з�
        ROW TRIGGER
            SQL�� �� ROW�� ���� �� ���� ����
            Ʈ���� ���� �� FOR EACH ROW �ɼ� �ۼ�
            :OLD    : ���� �� ���� ��(UPDATE : ���� �� �ڷ�, DELETE : ���� �� �ڷ�)
            :NEW    : ���� �� ���� ��(INSERT : �Է��� �ڷ�, UPDATE : ���� �� �ڷ�)
        STATEMENT TRIGGER
            SQL���� ���� �� ���� ����(DEFAULT)

*/

-- ǥ����
/*
    CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ�
    BEFORE | AFTER
    INSERT | UPDATE | DELETE
    ON ���̺��
    [FOR EACH ROW]
    [WHEN ����]
    DECLARE
        �����
    BEGIN
        �����
    EXCEPTION
        ����ó����
    END;
    /
*/

-- EMPLOYEE���̺� ����� �߰��Ǹ� '���Ի���� �Ի��߽��ϴ�'��� ������ ��µǴ� TRG_01 Ʈ���� ����
CREATE OR REPLACE TRIGGER TRG_01
AFTER INSERT
ON EMPLOYEE
BEGIN
    DBMS_OUTPUT.PUT_LINE('���Ի���� �Ի��߽��ϴ�.');
END;
/

INSERT INTO EMPLOYEE
VALUES (999, '���ǰ�', '000101-3333333', 'kang_kk@kh.or.kr', '01011112222', 'D5', 'J3', 'S5', 3000000, 0.1, 200,
        SYSDATE, NULL, DEFAULT);
-- ���Ի���� �Ի��߽��ϴ�. : SET SERVEROUTPUT ON;�� �ؾ� ����
        
ROLLBACK;

SET SERVEROUTPUT ON;

-- ��ǰ ���� ���̺�
CREATE TABLE PRODUCT(
    PCODE NUMBER PRIMARY KEY,   -- ��ǰ�ڵ�
    PNAME VARCHAR2(30),         -- ��ǰ ��
    BRAND VARCHAR2(30),         -- �귣��
    PRICE NUMBER,               -- ����
    STOCK NUMBER DEFAULT 0      -- ���
);

-- ��ǰ ����� �� �̷� ���̺�
CREATE TABLE PRO_DETAIL(
    DCODE NUMBER PRIMARY KEY,   -- ���ڵ�
    PCODE NUMBER,               -- ��ǰ�ڵ�
    PDATE DATE,                 -- ��ǰ �������
    AMOUNT NUMBER,              -- ����� ����
    STATUS VARCHAR2(10) CHECK(STATUS IN('�԰�', '���')), -- ��ǰ ����
    FOREIGN KEY(PCODE) REFERENCES PRODUCT(PCODE)
);

CREATE SEQUENCE SEQ_PCODE;
CREATE SEQUENCE SEQ_DCODE;

INSERT INTO PRODUCT
VALUES (SEQ_PCODE.NEXTVAL, '������S21', '�Ｚ', 1000, DEFAULT);

INSERT INTO PRODUCT
VALUES (SEQ_PCODE.NEXTVAL, '������12', '����', 500, DEFAULT);

INSERT INTO PRODUCT
VALUES (SEQ_PCODE.NEXTVAL, 'WING', 'LG', 300, DEFAULT);

SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;

CREATE OR REPLACE TRIGGER TRG_02
AFTER INSERT ON PRO_DETAIL
FOR EACH ROW
BEGIN
    -- ��ǰ�� �԰�� ��� : STOCK ����
    IF :NEW.STATUS = '�԰�' 
    THEN 
        UPDATE PRODUCT 
        SET STOCK = STOCK + :NEW.AMOUNT
        WHERE PCODE = :NEW.PCODE; 
    END IF;
END;
/

SELECT * FROM PRODUCT;
SELECT * FROM PRO_DETAIL;

INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 5, '�԰�');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 10, '�԰�');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 20, '�԰�');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 5, '�԰�');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 3, SYSDATE, 1, '���');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 2, SYSDATE, 19, '���');
INSERT INTO PRO_DETAIL VALUES(SEQ_DCODE.NEXTVAL, 1, SYSDATE, 15, '���');
