# 1.查询Student表中的所有记录的Sname、Ssex和Class列。
select Sname,Ssex,Class from student;

# 2.查询教师所有的单位, 即不重复的Depart列。
select distinct depart from teacher;
select depart from teacher group by depart;

# 3.查询Score表中成绩在60到80之间的所有记录。
select * from score where score.DEGREE>=60 and score.DEGREE<=80;

# 4.查询Score表中成绩为85，86或88的记录。
select * from score where score.DEGREE=85 or score.DEGREE=86 or score.DEGREE=88;
select * from score where score.DEGREE in (85, 86, 88);

# 5.查询Student表中“95031”班或性别为“女”的同学记录。
select * from student where student.CLASS='95031' or student.SSEX='女';

# 6.以Class降序查询Student表的所有记录。
select * from student order by student.CLASS desc;

# 7.以Cno升序、Degree降序查询Score表的所有记录。
select * from score order by score.CNO asc, score.DEGREE desc;

# 8.查询“95031”班的学生人数。
select count(*) from student where student.CLASS='95031';

# 9.查询Score表中的最高分的学生学号和课程号。
select student.SNO,score.CNO from student inner join score where score.DEGREE=(select max(score.DEGREE) from score);
# with max_score as (select max(score.DEGREE) from score) 是sql server语法

# 10.查询‘3-105’号课程的平均分.
select avg(score.DEGREE) from student inner join score where student.SNO=score.SNO and score.CNO='3-105';

# 11.查询Score表中至少有5名学生选修的并以3开头的课程的平均分数。
# having用于查询聚合条件，作用于每一个分组的子集
select avg(score.DEGREE) from score where score.CNO like '3%' and score.CNO in (select score.CNO from score group by score.CNO having count(score.SNO)>=5);

# 12.查询最低分大于70，最高分小于90的Sno列。
select score.SNO from score group by score.SNO having max(score.DEGREE)<90 and min(score.DEGREE)>70;

# 13.查询所有学生的Sname、Cno和Degree列。
select student.SNAME,score.CNO,score.DEGREE from student inner join score on(student.SNO=score.SNO);

# 14.查询所有学生的Sno、Cname和Degree列。
select score.SNO,course.CNAME,score.DEGREE from score inner join course on score.CNO=course.CNO;

# 15.查询所有学生的Sname、Cname和Degree列。
select student.SNAME,course.CNAME,score.DEGREE from student left join score on student.SNO=score.SNO inner join course on course.CNO=score.CNO;

# 16.查询“95033”班所选课程的平均分。
select * from student where student.CLASS='95033'
