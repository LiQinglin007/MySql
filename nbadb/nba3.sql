
SELECT * FROM team;
SELECT * FROM coach;
SELECT * FROM test;
SELECT * FROM player;
SELECT * FROM championTeam;
#运算符和函数  以及自定义函数


#函数
#1、字符函数
#2、数值运算符与函数
#3、比较运算符与函数
#4、日期时间函数
#5、信息函数
#6、聚合函数
#7、加密函数

#1、字符函数
#CONCAT() 字符的连接

SELECT CONCAT("李","-","小米");		#结果：李-小米
#把球员的名称和背号和总冠军数量拼接在一起
SELECT CONCAT(player.`playerName`,"    号码：",player.`playerNumber`,"    总冠军数量：",player.`championNumber`) AS playerData FROM player
   
#CONCAT_WS()  使用指定的分隔符进行字符拼接(就是用哪个符号拼接)  这里最少需要三个参数  第一个参数是用那个符号拼接  后边的是连接数据
SELECT CONCAT_WS("+","李","小米");	#结果：李+小米
#把球员的名称和背号和总冠军数量拼接在一起  并且用|分割
SELECT CONCAT_WS("|",player.`playerName`,player.`playerNumber`,player.`championNumber`) AS playerData FROM player

#FORMAT()  数字格式化  返回结果是一个字符(四舍五入)
#第一个参数  是要格式化的数字  
#第二个是保留几位小数
SELECT FORMAT(1256.7462,2)	#结果：1256.75

#LOWER()    转换成小写字母
SELECT LOWER("MySQL")		#结果：mysql

#UPPER()    转化成大写字符
SELECT UPPER("MySQL")		#结果：MYSQL

#LEFT()    获取左侧字符,就是前几位
#第一个参数：从那个字符串获取
#第二个参数：获取几位
SELECT LEFT("MySQL",2)		#结果：My
#然后把获取出来的转换成小写
SELECT LOWER(LEFT("MySQL",2))	#结果：my

#RIGHT()   获取右侧字符,就是获取后几位
SELECT RIGHT("MySQL",10)	#结果：MySQL

#LENGTH()  获取字符串长度
SELECT LENGTH("MySQL")		#结果：5

#LTRIM()   删除前导空格
SELECT LENGTH("  MySQL  ")	#结果：9
SELECT LTRIM("  MySQL  ")	#结果：MySQL  
SELECT LENGTH(LTRIM("  MySQL  "))#结果：7

#RTRIM()   删除后导空格
SELECT LENGTH("  MySQL  ")		#结果：9
SELECT RTRIM("  MySQL  ")		#结果：  MySQL
SELECT LENGTH(RTRIM("  MySQL  "))	#结果：7


#TRIM()    删除前导和后导空客
SELECT TRIM("   MySQL   ")		#结果：MySQL   
SELECT LENGTH(TRIM("  MySQL  "))	#结果：5

#删除前边或者后边的指定字符
SELECT TRIM(LEADING '#' FROM "##MySQL###")	#结果：MySQL###   
SELECT TRIM(TRAILING '#' FROM "##MySQL###")	#结果：##MySQL   
SELECT TRIM(BOTH '#' FROM "##MySQL###")		#结果：MySQL   




#SUBSTRING()  字符串截取
#第一个参数：从第几位开始截取  下标从1开始(这里可以写负数，负数是从后往前截取)
#第二个参数：截取多少位(如果不写这个，就截取到结尾)
SELECT SUBSTRING("MySQL",1,3)		#结果：MyS
SELECT SUBSTRING("MySQL",2)		#结果：ySQL   
SELECT SUBSTRING("MySQL",-2,1)		#结果：Q 
SELECT SUBSTRING("MySQL",-2)		#结果：QL   

#[NOT] LIKE   匹配模式
SELECT "MySql" LIKE "%M%"		#结果：1 

UPDATE player SET player.playerName="%李%小米" WHERE player.playerName="李小米"
SELECT * FROM player WHERE player.`playerName` LIKE "%1%%" ESCAPE 1;  #1后边的第一个字符就不用看成通配符了



#REPLACE()   字符串替换
#第一个参数：准备操作的串
#第二个参数：把谁替换
#第三个参数：替换成啥
SELECT REPLACE("#My#SQ#L#","#","")		#结果：MySQL


#2、数值运算符与函数

#CEIL()  进一取整  向上取整
SELECT CEIL(1.32)		#结果：2
#FLOOR() 舍一取整 向下取整
SELECT FLOOR(1.32)		#结果：1 

#DIV    整数除法
SELECT 3 DIV 5			#结果：0 

#MOD   取余数
SELECT 5 MOD 3			#结果：2 
SELECT 5.2 MOD 3		#结果：2.2 

#POWER()  幂运算
#2的3次方
SELECT POWER(2,3)		#结果：8

#ROUND()   四舍五入
#第一个参数：准备操作的数
#第二个参数：保留几位  不写默认保留整数
SELECT ROUND(1.32)		#结果：1 
SELECT ROUND(1.51)		#结果：2
SELECT ROUND(1.5151,2)		#结果：1.52

TRUNCATE()  #数字截取  把结果直接去掉  不四舍五入
SELECT TRUNCATE(125.872,2)  	#结果125.87
SELECT TRUNCATE(125.872,1)  	#结果 125.8
SELECT TRUNCATE(125.872,0)	#结果125
SELECT TRUNCATE(125.872,-1)	#结果120
SELECT TRUNCATE(125.872,-2)	#结果  100




#3、比较运算符与函数
#[NOT] BETWEEN ... AND ... [不]在范围之内
#[NOT]IN()  [不]在列出值范围内
#IS [NOT] NULL  [不]为空

SELECT 2 BETWEEN 1 AND 3		#结果：1 
SELECT 2 BETWEEN 3 AND 5		#结果：0 

SELECT 2 IN (1,3,5,7)			#结果：0
SELECT 2 NOT IN (1,3,5,7)		#结果：1

#那个球队的队名不是null
SELECT *FROM team WHERE team.`teamName` IS NOT NULL
 



#4、日期时间函数

#NOW()  当前的日期和时间
SELECT NOW()			#结果：2018-05-23 14:34:49
#CURDATE() 当前日期
SELECT CURDATE()		#结果：2018-05-23
#CURTIME() 当前时间
SELECT CURTIME()		#结果：14:34:49

#DATE_ADD() 日期变化
#加一年
SELECT DATE_ADD("2018-05-23" ,INTERVAL 365 DAY)  #结果：2019-05-23
#减一年
SELECT DATE_ADD("2018-05-23" ,INTERVAL -365 DAY)  #结果：2017-05-23
#加两个月
SELECT DATE_ADD("2018-05-23" ,INTERVAL 2 MONTH)  #结果：2018-07-23
#加两个星期
SELECT DATE_ADD("2018-05-23" ,INTERVAL 2 WEEK)  #结果：2018-06-06
 

#DATEDIFF()  日期差值
SELECT DATEDIFF("2018-05-23" ,"2018-06-06")  #结果：-14
SELECT DATEDIFF("2018-06-06","2018-05-23" )  #结果：14

#DATE_FORMAT()  日期格式化  %表示小于10的时候  用09来表示
SELECT DATE_FORMAT("2018-06-06","%m/%d/%Y" )  #结果：06/06/2018


#5、信息函数
#CONNECTION_ID()  连接ID(也就是线程id)
SELECT CONNECTION_ID()
#DATABASE() 当前数据库
SELECT DATABASE()
#LAST_INSERT_ID() 最后插入记录
INSERT INTO player VALUES(NULL,"李小米","后卫",6,998,5); 
SELECT LAST_INSERT_ID()
#USER()当前用户
SELECT USER()
#VERSION() 当前数据库 版本信息
SELECT VERSION()



#6、聚合函数
#AVG() 平均值
SELECT AVG(team.`championNumber`) FROM team
#COUNT() 计数
SELECT COUNT(team.`championNumber`) FROM team
#MAX() 最大值
SELECT MAX(team.`championNumber`) FROM team
#MIN() 最小值
SELECT MIN(team.`championNumber`) FROM team
#SUM() 求和
SELECT SUM(team.`championNumber`) FROM team

#7、加密函数
#MD5()  一般使用或者
SELECT MD5("123456")		#结果：e10adc3949ba59abbe56e057f20f883e
#PASSWORD()  这个是在mysql中改变user的密码，会使用到，一般不用
SELECT PASSWORD("123456")	#结果：*6BB4837EB74329105EE4568DDA7DC67ED2CA2AD9



#自定义函数
#用户自定义函数是一种对MySQL扩展的途径，用法和内置函数相同。

#函数体
#1、函数体可以由合法的SQL语句构成
#2、函数体可以是简单的SELECT或者INSERT语句；
#3、函数体如果为复合结构则使用BGGIN...END语句；
#4、复合结构可以包含声明、循环、控制结构。

#创建无参函数
SELECT DATE_FORMAT(NOW(),"%Y年%m月%d日 %H点:%i分:%s秒");

#		方法名          返回类型	   返回值	
CREATE FUNCTION   f1()  RETURNS VARCHAR(30) RETURN DATE_FORMAT(NOW(),'%Y年%m月%d日 %H点:%i分:%s秒');
SELECT f1();
 
#创建有参函数
CREATE FUNCTION   f2(num1 INT ,num2 INT)  RETURNS FLOAT(10,2) RETURN (num1+num2)/2;
SELECT f2(5,4);
#删除函数
DROP FUNCTION f2;

#创建具有复合结构函数体的自定义函数
#往球员表中插入一条记录，返回插入记录的id
#参数   球员名称，球员位置，号码，球队id,总冠军数量

#这里在sql中默认以分号结束当前语句，但是在字段定义函数中要使用到分号，所以把分号改成;;或者其他的来结束当前语句
DELIMITER ;;  


CREATE FUNCTION   addPlayer(playerName VARCHAR(20) ,playerPosition VARCHAR(20) ,playerNumber INT UNSIGNED ,teamId INT UNSIGNED ,championNumber  INT) 
 RETURNS INT   UNSIGNED
BEGIN
	INSERT INTO player VALUES(NULL,playerName,playerPosition,playerNumber,teamId,championNumber);
	RETURN LAST_INSERT_ID();
END 

SELECT addPlayer("我是小米","后卫",55,999,5);
SELECT addPlayer("我是小米1","后卫",55,999,5);
SELECT addPlayer("我是小米2","后卫",55,999,5);
DROP FUNCTION addPlayer;
















