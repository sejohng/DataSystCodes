BEGIN
     DBMS_OUTPUT.PUT_LINE('call Invoice(''C07'', TO_DATE(''30-JAN-23''));');
     Invoice('C07', TO_DATE('30-JAN-23'));
     DBMS_OUTPUT.PUT_LINE('');
     
     DBMS_OUTPUT.PUT_LINE('call Invoice(''C04'', TO_DATE(''03-FEB-23''));');
     Invoice('C04', TO_DATE('03-FEB-23'));
     DBMS_OUTPUT.PUT_LINE('');

     DBMS_OUTPUT.PUT_LINE('call Invoice(''C01'', TO_DATE(''30-JAN-23''));');
     Invoice('C01', TO_DATE('30-JAN-23'));
     DBMS_OUTPUT.PUT_LINE('');
     
     DBMS_OUTPUT.PUT_LINE('call Invoice(''C08'', TO_DATE(''30-JAN-23''));');
     Invoice('C08', TO_DATE('30-JAN-23'));
     DBMS_OUTPUT.PUT_LINE('');
END;
/