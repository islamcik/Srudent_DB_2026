
select * from  student_performance_dataset;

#Analysefragen für deine Tabelle:
#Wie viele Schüler*innen gibt es insgesamt in der Tabelle?
select count(Student_ID) as Anzahl_Schuleren from student_performance_dataset spd;


#Wie ist die Altersverteilung der Schüler*innen?
select age, count(*) as anzahl_schuler  from student_performance_dataset
group  by 1
order by 1 desc ;


#Wie viele männliche und weibliche Schüler*innen gibt es?
select gender, count(*) as anzahl_geschlecht from student_performance_dataset spd 
where gender = 'Male'
union
select gender, count(*) as anzahl_geschlecht from student_performance_dataset spd 
where gender = 'Female';


#Wie viele Schüler*innen besuchen jede Klasse?
select Class, round(count(Student_ID),0) as anzahl_besucher  from student_performance_dataset 
group by 1;


#Was ist der durchschnittliche tägliche Lernaufwand (Study_Hours_Per_Day) pro Klasse?
select Class,round(avg(Study_Hours_Per_Day),2) as avg_stunden from student_performance_dataset 
group by 1;


#Gibt es einen Zusammenhang zwischen Parental_Education und Final_Percentage?
select 
    Parental_Education,
    concat(round(sum(Final_Percentage) * 100.0 / (select sum(Final_Percentage) from student_performance_dataset),2),'%') as prozent
from student_performance_dataset
group by Parental_Education
order by prozent desc;


#Wie viele Schüler*innen haben Internetzugang und wie viele nicht?
select Internet_Access,count(*) as anzahl_schuler from student_performance_dataset spd 
where Internet_Access = 'No'
group by Internet_Access
union
select Internet_Access,count(*) as anzahl_schuler from student_performance_dataset spd 
where Internet_Access = 'Yes'
group by Internet_Access;


#Was ist die durchschnittliche Punktzahl in Mathe, Naturwissenschaften und Englisch?
select round(avg(Math_Score),0) as avg_math, round(avg(English_Score),0) as avg_Eng, round(avg(Science_Score),0) as  avg_Science    from student_performance_dataset; 



#Welche Schüler*innen haben die höchsten und niedrigsten Final_Percentage?
select Student_ID ,Final_Percentage from student_performance_dataset spd 
where spd.Final_Percentage in (select max(Final_Percentage) from student_performance_dataset) or  
	  spd.Final_Percentage  in (select min(Final_Percentage) from student_performance_dataset)
;

#Welche Klasse hat die besten Durchschnittsnoten in Mathe?
select Class, round(avg(Math_Score),1) as Math_Score  from student_performance_dataset
group by 1
order by 2 desc
limit 1;


#Gibt es Schüler*innen, deren Previous_Year_Score deutlich schlechter oder besser als das aktuelle Ergebnis ist?
select  Previous_Year_Score, Final_Percentage, round(if(Previous_Year_Score >= Final_Percentage,Previous_Year_Score - Final_Percentage,Final_Percentage - Previous_Year_Score),0) as Note,
													if(Previous_Year_Score >= Final_Percentage, 'schlechter', 'besser') as Ergebnis 
from student_performance_dataset;



