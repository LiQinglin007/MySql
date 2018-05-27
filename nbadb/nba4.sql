#存储过程和存储引擎

#存储过程
#说到存储过程的作用，咱们先来说一下写了sql命令之后到拿到返回结果，mysql都经历了哪些。
#1、首先输入sql命令之后，mysql引擎会首先对sql命令进行语法分析，来检查sql命令是不是正确
#2、如果sql命令是正确的，那么sql命令会通过编译转化成msyql可以识别的命令
#3、然后开始执行命令
#4、最后将结果返回给客户端
#有了上述的这个过程，那咱们如果把检查命令和编译省略掉，就能提升sql命令的效率。那么问题来了，
#怎么能省略掉前边的步骤呢？就是是用存储过程！
#在一条sql命令第一次被执行的时候，同样会经历上述四个步骤。但是从第二次起，就不用再重新检查和编译了。

#存储过程是SQL语句和控制语句的预编译集合，以一个名称存储并座位一个单元处理

#存储过程的优点
#1、增强了SQL语句的功能和灵活性。在存储过程中可以用变量以及判断等，就可以使用存储过程完成比较复杂的功能。
#2、实现了比较快的执行速度。如果在一个操作包含大量的sql命令，效率较低。频繁调用时在使用存储过程效率较高。
#3、减少网络流量。如果要执行一个操作，要写一个完成的sql命令进去。但是如果使用存储过程，那就传递参数就好了，这样提交给服务器的内容就少了很多。

#参数的含义
#1、IN,表示该参数的值必须在调用存储过程时指定，这个不能被返回。
#2、OUT,表示该参数的值可以被存储过程改变，并且可以返回。
#3、INOUT,表示该参数的值在调用时指定，并且可以改变和返回。

#过程体
#1、过程体由合法的sql语句构成；
#2、过程体可以是任意的SQL语句构成；
#3、过程体如果为复合结构则使用 BEGIN...END语句；
#4、复合结构可以声明变量，循环，控制流程；

#自定义函数和存储过程的区别
#1、存储过程实现的功能更复杂一些;函数针对性更强.很少用函数对表做操作，存储过程经常对表做操作。
#2、存储过程可以返回多个值，函数只能返回一个。
#3、存储过程一般独立的执行；函数可以座位其他SQL语句的组成部分出现。

#创建不带参数的存储过程
create PROCEDURE sp1() SELECT VERSION();
#调用存储过程
CALL sp1();
#如果该存储过程没有参数,可以省略后边算是方法名的小括号
CALL sp1;

#创建IN参数的存储过程
#按id删除球员
#这里有个问题，参数名的不要和数据库里边字段的名称相同 
CREATE PROCEDURE deletePlyerById(IN id INT UNSIGNED) 
BEGIN
DELETE FROM player where player.playerId=id;
END 

#删除存储过程
DROP PROCEDURE deletePlyerById;

select * FROM player
select player.playerId FROM player WHERE player.playerName="我是小米1";
select player.playerId FROM player WHERE player.playerName="我是小米";
#调用存储过程删除两个球员
CALL deletePlyerById(59);
CALL deletePlyerById(60);

#删除球员，并且返回数据库里边还有多少球员
CREATE PROCEDURE detelePlayerByIdReturnPlayerSum(IN id INT UNSIGNED,OUT playerSum INT UNSIGNED)
BEGIN
DELETE FROM player WHERE player.playerId=id;
SELECT COUNT(player.playerId) FROM player INTO playerSum;
END
 
select player.playerId FROM player WHERE player.playerName="李小米%%";

CALL  detelePlayerByIdReturnPlayerSum(57,@playerSum);
SELECT @playerSum

SELECT SUM(player.championNumber) FROM player WHERE player.teamId=2

#创建多个out类型参数的存储过程
#通过teamid 查询这个球队 有多少个球员，以及这些球员所获得的总冠军总数
CREATE PROCEDURE queryPlayerNumberAndChampionSumByTeamId(IN p_teamId INT ,OUT playerSumForTeam INT UNSIGNED,OUT championSum INT UNSIGNED)
BEGIN
SELECT COUNT(player.playerId) FROM player WHERE player.teamId=p_teamId INTO playerSumForTeam;
SELECT SUM(player.championNumber) FROM player WHERE player.teamId=p_teamId INTO championSum;
END

#调用
CALL queryPlayerNumberAndChampionSumByTeamId(2,@playerSumForTeam,@championSum);
SELECT @playerSumForTeam
SELECT @championSum











#MySQL存储引擎
#MySQL可以将数据以不同的技术存储在文件中，这种技术被称为存储引擎。
#每种存储引擎使用不同的存储机制、索引技巧、锁定水平，最终提供广泛且不同的功能。
#1、MyISAM
#2、InnoDB
#3、Memory
#4、CSV
#5、Archive


#并发控制
#并发控制：当多个连接对记录进行修改时保证数据的一致性和完整性。
#这个通过锁策略来解决。
#锁：  
#1、共享锁(读锁)：在同一个时间段内，多个用户可以读取同一个资源，读取过程中不数据不会发生任何变化。
#2、排他锁(写锁)：在任何时候只能由一个用户来写入资源，当其他写锁时会阻塞其他的写锁或者读锁操作。
#锁颗粒
#表锁，是一种开销最小的锁策略。一个表最大只有一个表锁。
#行锁，是一种开销最大的锁策略。一个表有多少行，最大就有多少个行锁。


#事务处理
#事务：使用用于保证数据的完整性
#举个栗子：A有200，B有200.A给B赚了100块钱。有几个步骤？
#1、从A账户减少100；
#2、给B账户增加100；
#在这两个步骤中，不管哪一步出现问题，都应该恢复到操作之前的数据，就是A和B都有200块钱。

#事务的特性
#1、原子性(Atomicity)
#2、一致性(Consistency)
#3、隔离性(Isolation)
#4、持久性(Durability)


#外键
#外键是保持数据一致性的策略


#索引
#索引是对数据表中一列或者多列的值进行排序的一种结构。一般情况下使用MyISAM和InnoDB比较多。在MySQL5.5使用InnoDB。

#							MyISAM    InnoDB     Memory   Archive

#存储限制     256TB      64TB      有        无

#事务安全       -  			支持			-					-

#支持索引			支持			支持			支持			支持

#锁颗粒				表锁			行锁			表锁			行锁	

#数据压缩			支持				-				-					支持

#支持外键			-					支持			-					-



#修改存储引擎的方法
#1、通过修改MySQL配置文件来实现。
#-default-storage-engine=engine(存储引擎的名称)
#2、通过创建数据表命令实现
CREATE TABLE test1(
s1 VARCHAR(10))
engine=MyISAM;


CREATE TABLE test2(
s1 VARCHAR(10))
engine=InnoDB;

SHOW 	CREATE table test1;
#结果
#CREATE TABLE `test1` (  `s1` varchar(10) DEFAULT NULL) ENGINE=MyISAM DEFAULT CHARSET=utf8

SHOW 	CREATE table test2;
#结果
#CREATE TABLE `test2` ( `s1` varchar(10) DEFAULT NULL ) ENGINE=InnoDB DEFAULT CHARSET=utf8


#修改数据表的引擎
ALTER TABLE test1 ENGINE=INNODB;
#结果
#CREATE TABLE `test1` (  `s1` varchar(10) DEFAULT NULL) ENGINE=InnoDB DEFAULT CHARSET=utf8

SHOW 	CREATE table test1;
#结果
#CREATE TABLE `test1` (  `s1` varchar(10) DEFAULT NULL) ENGINE=MyISAM DEFAULT CHARSET=utf8
 

#删除表
DROP TABLE test1,test2;





















