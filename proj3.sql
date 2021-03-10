Part 3
-- JASWANTH REDDY MATTA

create or replace view q1 as
	-- replace this line with your first SQL query
SELECT Distinct person.PEID as PERSON#, person.FirstName ||' '|| person.LastName as NAME 
FROM Deal inner 
JOIN Buyer on Deal.PEID = Buyer.PEID inner 
JOIN Person on person.PEID = Deal.PEID 
ORDER BY person.PEID;

create or replace view q2 as
        -- replace this line with your first SQL query
SELECT p.pno, p.suburb, p.type 
FROM property p 
WHERE p.pno IN (select DISTINCT r.pno FROM Property_for_Rent r) AND (p.pno IN 
(SELECT DISTINCT a.pno FROM Property_for_Auction a) OR p.pno IN (SELECT DISTINCT s.pno 
FROM Property_for_Private_Sale s))
;

create or replace view q3 as
	-- replace this line with your third SQL query
SELECT p.PEID as PERSON#,p.FirstName ||' '|| p.LastName as NAME 
FROM Person p 
JOIN Owner o on p.PEID=o.PEID 
JOIN Property a on p.PEID=a.PEID 
WHERE a.Type='Commercial'and a.Suburb='Randwick' 
ORDER BY p.PEID
;

create or replace view q4 as
	-- replace this line with your fourth SQL query
SELECT count(*) as NUMBER# 
FROM Person p 
WHERE p.PEID not in (SELECT PEID from Contract) and p.PEID not in (SELECT PEID from Property) and p.PEID not in (SELECT PEID from Deal)
;

create or replace view q5 as
	-- replace this line with your fifth SQL query
SELECT count(p.PNo) as NUMBER#,lower(p.Suburb) as SUBRUB 
FROM Property p, Deal d 
WHERE p.PNo=d.PNO 
GROUP BY lower(p.Suburb) having AVG(d.Price)<500000 
ORDER BY lower(p.Suburb)
;

create or replace view q6 as
	-- replace this line with your sixth SQL query
SELECT lower(p.Suburb) as SUBURB,max(d.Price) as MAXPRICE 
FROM Property p 
JOIN Deal d on p.PNo=d.PNo 
JOIN Branch b on b.Suburb=p.Suburb 
GROUP BY p.Suburb
;

create or replace view q7 as
	-- replace this line with your seventh SQL query
SELECT lower(p.suburb) as SUBURB,count(lower(r.PNo)) as NUMBER# 
FROM Property p, Property_for_Rent r 
WHERE p.PNo=r.PNo 
GROUP BY lower(SUBURB)
;

create or replace view q8 as
	-- replace this line with your eighth SQL query
SELECT p.pno ,p.suburb,p.type FROM property p where p.pno in ( select distinct a.pno
    FROM advertisement a where exists( SELECT a1.newspaper FROM advertisement a1 where a1.pno=a.pno
    and a1.newspaper!=a.newspaper))
;

create or replace view q9 as
	-- replace this line with your ninth SQL query
SELECT * FROM (select c.peid, sum(d.price) as Total 
FROM deal d 
JOIN contact c ON d.pno = c.pno  
GROUP BY c.peid 
ORDER BY Total desc) where ROWNUM = 1
;

create or replace view q10 is
	-- replace this line with your tenth SQL query
;


create or replace procedure p1(v_branch in integer)
    is begin DBMS_OUTPUT.PUT_LINE('PEID  No sold amount sold  NAME');
FOR cur in (select res.*, concat(concat(p.FIRSTNAME, ' '), p.LASTNAME) NAME 
from PERSON p 
join (select * from (select s.PEID, count(d.PNO) No_sold, sum(d.PRICE) amount_sold 
from CONTACT c join DEAL d on c.PNO = d.PNO left 
join STAFF s on c.PEID = s.PEID left 
join BRANCH b on s.PEID = b.PEID where s.BNO = v_branch 
group by s.PEID order by count(d.PNO) desc)
where ROWNUM <= 10) res on p.PEID = res.PEID order by res.amount_sold desc )
LOOP
dbms_output.put_line(cur.PEID || '    ' || cur.No_sold || '       ' || cur.amount_sold || '       ' || cur.NAME);
END LOOP;
end ;
/

create or replace procedure search(v_price in integer, v_feature1 in integer, v_feature2 in integer)is
begin FOR cur in (select p.SUBURB, p.PNO from PROPERTY p join FEATURED f1 on p.PNO = f1.PNO -- to meet feature 1 join FEATURED f2 on p.PNO = f2.PNO -- to meet feature 2 join DEAL d on p.PNO = d.PNO -- to meet max price of buyer where d.PRICE < v_price and f1.fid = v_feature1 and f2.fid = v_feature2 order by p.PNO desc )
LOOP
dbms_output.put_line('**');
dbms_output.put_line(cur.suburb);
dbms_output.new_line;
dbms_output.put_line('property id');
dbms_output.new_line;
dbms_output.put_line(cur.pno);
END LOOP;
end ;
/
DROP table AUDIT_PROP;
CREATE TABLE AUDIT_PROP(PNo INTEGER, USER_NAM VARCHAR(50), DATA_CHAN DATE, OLD_PRICE REAL, NEW_PRICE REAL);

CREATE or REPLACE TRIGGER update_price_of_parts
AFTER UPDATE OF ASKING_PRICE ON PROPERTY_FOR_PRIVATE_SALE
FOR EACH ROW 
   when (new.pno=80)
     BEGIN
      insert into AUDIT_PROP
       values (:old.pno, user, sysdate, :old.asking_price, :new.asking_price);
     END;	
/


UPDATE PROPERTY_FOR_PRIVATE_SALE SET ASKING_PRICE=23500 WHERE PNO=80;
/
select * from AUDIT_PROP;