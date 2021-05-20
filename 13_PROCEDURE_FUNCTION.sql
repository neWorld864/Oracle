-- 프로시져 : PL/SQL문을 저장하는 객체
-- 필요할 때마다 다시 쓸 필요 없이 간단히 호출해서 실행 결과를 얻을 수 있음
-- (*) 특정 로직을 처리하기만 하고 결과 값을 반환하지 않음
/*
    == 프로시저 생성 방법 ==
    CREATE OR REPLACE PROCEDURE 프로시저명
        (매개변수명1 [IN | OUT | IN OUT] 데이터타입[:= DEFAULT값],
         매개변수명2 [IN | OUT | IN OUT] 데이터타입[:= DEFAULT값],
         ....
         )
    IS
        선언부
    BEGIN 
        실행부
    EXCEPTION
        예외처리부
    END;
    /
    
    == 프로시저 호출 방법 ==
    EXECUTE 프로시저명;
    EXEC 프로시저명;
*/

CREATE TABLE EMP_DUP
AS SELECT * FROM EMPLOYEE;

CREATE OR REPLACE PROCEDURE DEL_ALL_EMP
IS
BEGIN
    DELETE FROM EMP_DUP;
    COMMIT;
END;
/
-- Procedure DEL_ALL_EMP이(가) 컴파일되었습니다.

EXECUTE DEL_ALL_EMP;
EXEC DEL_ALL_EMP;

SELECT * FROM EMP_DUP;

-- 매개변수 있는 PROCEDURE
CREATE OR REPLACE PROCEDURE DEL_EMP_ID(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
IS
BEGIN
    DELETE FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    --     변수         값
END;
/

--EXECUTE DEL_EMP_ID;
-- PLS-00306: wrong number or types of arguments in call to 'DEL_EMP_ID' -> 매개변수 값을 넣어야 함

--EXECUTE DEL_EMP_ID(200);
EXEC DEL_EMP_ID('&ID');

SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 210224
-- IN 매개변수 : 프로시저 내부에서 사용되는 변수
-- OUT 매개변수 : 프로시저 외부(호출부)에서 사용되는 변수
-- 사용자가 입력한 사번으로 이름, 급여, 보너스 조회하는 SELECT_EMP_ID프로시저 생성
CREATE OR REPLACE PROCEDURE SELECT_EMP_ID(
    V_EMP_ID IN EMPLOYEE.EMP_ID%TYPE,
    V_EMP_NAME OUT EMPLOYEE.EMP_NAME%TYPE,
    V_SALARY OUT EMPLOYEE.SALARY%TYPE,
    V_BONUS OUT EMPLOYEE.BONUS%TYPE
-- 밖에서 볼거기 때문에 OUT으로
)
IS
BEGIN
    SELECT EMP_NAME, SALARY, NVL(BONUS, 0)
    INTO V_EMP_NAME, V_SALARY, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
END;
/
-- Procedure SELECT_EMP_ID이(가) 컴파일되었습니다.

-- 바인드 변수 : SQL에 값을 전달할 수 있는 통로 역할의 변수
VARIABLE VAR_EMP_NAME VARCHAR2(30);
VAR VAR_SALARY NUMBER;
VAR VAR_BONUS NUMBER;

-- PRINT : 변수의 내용을 출력해주는 명령어
PRINT VAR_EMP_NAME;
PRINT VAR_SALARY;
PRINT VAR_BONUS;
-- 아직 입력 값이 없으므로 아무 값도 나오지 않는다!

EXEC SELECT_EMP_ID('&사번', :VAR_EMP_NAME, :VAR_SALARY, :VAR_BONUS);
-- 바인드 변수는 ':변수명'형태로 참조 가능
-- 위 바인드 변수에 값이 들어가 있을 것 -> PRINT 다시 출력하면 값이 나온다

SET AUTOPRINT ON;
-- 바인드 변수의 값을 자동으로 출력
-- 이거 하고 EXEC 바로 실행하면 됨. PRINT 따로 출력할 필요 없음

-- FUNCTION : 프로시저와 용도는 거의 비슷하지만 RETURN값이 있다는 점이 다름
/*
    CREATE OR REPLACE FUNCTION 함수명(매개변수명 매개변수타입, ...)
    RETURN 데이터타입
    IS
        선언부
    BEGIN
        실행부
        RETURN 반환값;
    EXCEPTION
        예외처리부
    END;
    /
*/

-- 사번을 입력받아 해당 사원의 연봉을 계산하고 리턴하는 함수 생성 : BONUS_CALC
CREATE OR REPLACE FUNCTION BONUS_CALC(V_EMP_ID EMPLOYEE.EMP_ID%TYPE)
RETURN NUMBER
IS
    CALC_SAL NUMBER;
    V_SAL EMPLOYEE.SALARY%TYPE;
    V_BONUS EMPLOYEE.BONUS%TYPE;
BEGIN
    SELECT SALARY, NVL(BONUS, 0) B
    INTO V_SAL, V_BONUS
    FROM EMPLOYEE
    WHERE EMP_ID = V_EMP_ID;
    
    CALC_SAL := (V_SAL + (V_SAL * V_BONUS)) * 12;
    
    RETURN CALC_SAL;
END;
/

VAR VAR_CALC NUMBER;

EXEC :VAR_CALC := BONUS_CALC('&ID');

SELECT EMP_ID, EMP_NAME, BONUS_CALC(EMP_ID)
FROM EMPLOYEE
WHERE BONUS_CALC(EMP_ID) > 30000000;