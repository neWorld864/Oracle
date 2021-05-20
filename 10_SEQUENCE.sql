-- SEQUENCE : �ڵ� ��ȣ �߻���

CREATE SEQUENCE SEQ_EMPID
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPID FROM DUAL;
-- ORA-00904: "SEQ_EMPID": invalid identifier
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- ORA-08002: sequence SEQ_EMPID.CURRVAL is not yet defined in this session
-- CURRVAL : ���������� ȣ��� NEXTVAL���� �����Ͽ� �����ִ� ��

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 300 : NEXT VALUE
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 300 : CURRENT VALUE
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 310

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- ORA-08004: sequence SEQ_EMPID.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- �ִ밪�� �Ѿ �� �̻� ������ �� ����

SELECT * FROM USER_SEQUENCES;
-- MAX_VALUE : 310

/*
    ALTER SEQUENCE �������̸�
    [INCREMENT BY ����]
    [MAXVALUE ���� | NOMAXVALUE]
    [MINVALUE ���� | NOMINVALUE]
    [CYCLE | NOCYCLE]
    [CACHE ����Ʈũ�� | NOCACHE];
    
    START WITH�� ���� �Ұ� : ���� ������ DROP �� �����
*/

ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 320 : 310���� MAXVALUE�����ϰ� 10 ����
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 320

/*
    CURRVAL / NEXTVAL ��� ���� / �Ұ���
    1) ��� ����
        - ���������� �ƴ� SELECT��
        - INSERT�� SELECT��
        - INSERT�� VALUES��
        - UPDATE�� SET��
        
    2) ��� �Ұ���
        - VIEW�� SELECT��
        - DISTINCTŰ���尡 �ִ� SELECT��
        - GROUP BY, HAVING, UPDATE���� ��������
        - CREATE TABLE, ALTER TABLE ��ɾ��� DEFAULT ��
*/

INSERT INTO EMPLOYEE
VALUES (SEQ_EMPID.NEXTVAL, 'ȫ�浿', '666666-6666666', 'hong_gd@kh.or.kr', '01011112222', 'D2', 'J7', 'S1',
        5000000, 0.1, 200, SYSDATE, NULL, DEFAULT);

SELECT * FROM EMPLOYEE;

CREATE TABLE TMP_EMPLOYEE (
    E_ID NUMBER DEFAULT SEQ_EID.CURRVAL,
    E_NAME VARCHAR2(30)
);
-- ���� ���� - ORA-00984: column not allowed here

ROLLBACK;