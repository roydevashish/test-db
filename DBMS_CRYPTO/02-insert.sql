declare
   v_key    raw(32) := utl_raw.cast_to_raw('12345678901234567890123456789012'); -- 16, 24, or 32 bytes key
   v_salary raw(2000);
begin
   v_salary := dbms_crypto.encrypt(
      src => utl_raw.cast_to_raw('50000'), -- Convert salary to RAW
      typ => dbms_crypto.encrypt_aes256 + dbms_crypto.chain_cbc + dbms_crypto.pad_pkcs5,
      key => v_key
   );

   insert into dev_employee (
      emp_id,
      emp_name,
      salary
   ) values ( 1,
              'John Doe',
              v_salary );
   commit;
end;
/