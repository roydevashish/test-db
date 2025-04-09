DECLARE
    v_key RAW(32) := UTL_RAW.CAST_TO_RAW('12345678901234567890123456789012');
    v_decrypted_salary VARCHAR2(100);
BEGIN
    SELECT UTL_RAW.CAST_TO_VARCHAR2(
        DBMS_CRYPTO.DECRYPT(
            salary,
            DBMS_CRYPTO.ENCRYPT_AES256 + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5,
            v_key
        )
    ) INTO v_decrypted_salary
    FROM dev_employee
    WHERE emp_id = 1;

    DBMS_OUTPUT.PUT_LINE('Decrypted Salary: ' || v_decrypted_salary);
END;
/
